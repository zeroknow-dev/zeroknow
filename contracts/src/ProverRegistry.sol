// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract ProverRegistry {
    struct Prover {
        string metadataURI;
        bool active;
        uint256 registeredAt;
    }

    mapping(address => Prover) public provers;

    event ProverRegistered(address indexed prover, string metadataURI);
    event ProverStatusChanged(address indexed prover, bool active);

    function registerProver(string calldata metadataURI) external {
        provers[msg.sender] = Prover({metadataURI: metadataURI, active: true, registeredAt: block.timestamp});
        emit ProverRegistered(msg.sender, metadataURI);
    }

    function setActive(bool active) external {
        provers[msg.sender].active = active;
        emit ProverStatusChanged(msg.sender, active);
    }
}
