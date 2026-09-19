// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IPortfolioVault {
    function deposit(address asset, uint256 amount, address receiver) external returns (uint256);
    function withdraw(address asset, uint256 shares, address receiver) external returns (uint256);
}
