// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {DevProofVerifier} from "../src/DevProofVerifier.sol";
import {ProofRequestRegistry} from "../src/ProofRequestRegistry.sol";

contract ProofRequestRegistryTest {
    function testCreateAndVerifyProofRequest() public {
        DevProofVerifier verifier = new DevProofVerifier();
        ProofRequestRegistry registry = new ProofRequestRegistry();

        bytes32 claimHash = keccak256("balance >= 10000");
        bytes memory proof = abi.encode("development proof");
        bytes memory publicInputs = abi.encode("minimum disclosure");
        verifier.setExpectedProof(claimHash, keccak256(abi.encodePacked(proof, publicInputs)));

        uint256 requestId = registry.createRequest(claimHash, address(verifier), "ipfs://proof-request");
        registry.submitProof(requestId, proof, publicInputs);

        (
            address requester,
            bytes32 storedClaimHash,
            ,
            address storedVerifier,
            ProofRequestRegistry.RequestStatus status,
            address prover,
            bytes32 proofHash
        ) = registry.requests(requestId);

        assertEq(requester, address(this));
        assertEq(storedClaimHash, claimHash);
        assertEq(storedVerifier, address(verifier));
        assertEq(uint256(status), uint256(ProofRequestRegistry.RequestStatus.Verified));
        assertEq(prover, address(this));
        assertEq(proofHash, keccak256(abi.encodePacked(proof, publicInputs)));
    }

    function assertEq(address left, address right) internal pure {
        require(left == right, "address assertEq failed");
    }

    function assertEq(uint256 left, uint256 right) internal pure {
        require(left == right, "uint256 assertEq failed");
    }

    function assertEq(bytes32 left, bytes32 right) internal pure {
        require(left == right, "bytes32 assertEq failed");
    }
}
