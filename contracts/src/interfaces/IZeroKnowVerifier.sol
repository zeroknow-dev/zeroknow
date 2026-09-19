// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IZeroKnowVerifier {
    function verifyProof(bytes32 claimHash, bytes calldata proof, bytes calldata publicInputs)
        external
        view
        returns (bool);
}
