// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IZeroKnowVerifier} from "./interfaces/IZeroKnowVerifier.sol";

contract DevProofVerifier is IZeroKnowVerifier {
    event DevProofRuleSet(bytes32 indexed claimHash, bytes32 expectedProofHash);

    mapping(bytes32 => bytes32) public expectedProofHash;

    function setExpectedProof(bytes32 claimHash, bytes32 proofHash) external {
        expectedProofHash[claimHash] = proofHash;
        emit DevProofRuleSet(claimHash, proofHash);
    }

    function verifyProof(bytes32 claimHash, bytes calldata proof, bytes calldata publicInputs)
        external
        view
        returns (bool)
    {
        bytes32 expected = expectedProofHash[claimHash];
        return expected != bytes32(0) && expected == keccak256(abi.encodePacked(proof, publicInputs));
    }
}
