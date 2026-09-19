// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Errors} from "./libraries/Errors.sol";
import {IZeroKnowVerifier} from "./interfaces/IZeroKnowVerifier.sol";

contract ProofRequestRegistry {
    enum RequestStatus {
        Open,
        Verified,
        Closed
    }

    struct ProofRequest {
        address requester;
        bytes32 claimHash;
        string metadataURI;
        address verifier;
        RequestStatus status;
        address prover;
        bytes32 proofHash;
    }

    uint256 public nextRequestId = 1;
    mapping(uint256 => ProofRequest) public requests;

    event ProofRequested(
        uint256 indexed requestId,
        address indexed requester,
        bytes32 indexed claimHash,
        address verifier,
        string metadataURI
    );
    event ProofSubmitted(uint256 indexed requestId, address indexed prover, bytes32 proofHash);
    event ProofVerified(uint256 indexed requestId, address indexed verifier, address indexed prover);
    event ProofRequestClosed(uint256 indexed requestId);

    function createRequest(bytes32 claimHash, address verifier, string calldata metadataURI)
        external
        returns (uint256 requestId)
    {
        if (claimHash == bytes32(0)) revert Errors.InvalidProof();
        if (verifier == address(0)) revert Errors.InvalidAddress();

        requestId = nextRequestId++;
        requests[requestId] = ProofRequest({
            requester: msg.sender,
            claimHash: claimHash,
            metadataURI: metadataURI,
            verifier: verifier,
            status: RequestStatus.Open,
            prover: address(0),
            proofHash: bytes32(0)
        });

        emit ProofRequested(requestId, msg.sender, claimHash, verifier, metadataURI);
    }

    function submitProof(uint256 requestId, bytes calldata proof, bytes calldata publicInputs) external {
        ProofRequest storage request = requests[requestId];
        if (request.requester == address(0)) revert Errors.RequestNotFound();
        if (request.status != RequestStatus.Open) revert Errors.RequestClosed();

        bool isValid =
            IZeroKnowVerifier(request.verifier).verifyProof(request.claimHash, proof, publicInputs);
        if (!isValid) revert Errors.InvalidProof();

        request.status = RequestStatus.Verified;
        request.prover = msg.sender;
        request.proofHash = keccak256(abi.encodePacked(proof, publicInputs));

        emit ProofSubmitted(requestId, msg.sender, request.proofHash);
        emit ProofVerified(requestId, request.verifier, msg.sender);
    }

    function closeRequest(uint256 requestId) external {
        ProofRequest storage request = requests[requestId];
        if (request.requester == address(0)) revert Errors.RequestNotFound();
        if (request.requester != msg.sender) revert Errors.NotOwner();
        if (request.status == RequestStatus.Verified) revert Errors.AlreadyVerified();
        request.status = RequestStatus.Closed;
        emit ProofRequestClosed(requestId);
    }
}
