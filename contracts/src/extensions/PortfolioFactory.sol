// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {PortfolioVault} from "./PortfolioVault.sol";

contract PortfolioFactory {
    address[] public allVaults;
    mapping(address => address[]) public vaultsByCreator;

    event PortfolioCreated(
        address indexed creator,
        address indexed vault,
        address indexed share,
        string name,
        string symbol,
        string metadataURI
    );

    function createPortfolio(string calldata name, string calldata symbol, string calldata metadataURI)
        external
        returns (address vault)
    {
        PortfolioVault created = new PortfolioVault(msg.sender, name, symbol, metadataURI);
        vault = address(created);
        allVaults.push(vault);
        vaultsByCreator[msg.sender].push(vault);
        emit PortfolioCreated(msg.sender, vault, address(created.share()), name, symbol, metadataURI);
    }

    function allVaultsLength() external view returns (uint256) {
        return allVaults.length;
    }
}
