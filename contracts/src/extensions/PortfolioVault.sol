// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Errors} from "../libraries/Errors.sol";
import {PortfolioShare} from "./PortfolioShare.sol";

interface IERC20Like {
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

contract PortfolioVault {
    address public immutable factory;
    address public immutable creator;
    PortfolioShare public immutable share;
    string public metadataURI;

    mapping(address => uint256) public assetBalance;

    event LiquidityAdded(address indexed asset, address indexed provider, uint256 amount, uint256 shares);
    event LiquidityRemoved(address indexed asset, address indexed provider, uint256 shares, uint256 amount);

    constructor(address creator_, string memory name_, string memory symbol_, string memory metadataURI_) {
        if (creator_ == address(0)) revert Errors.InvalidAddress();
        factory = msg.sender;
        creator = creator_;
        metadataURI = metadataURI_;
        share = new PortfolioShare(name_, symbol_, address(this));
    }

    function deposit(address asset, uint256 amount, address receiver) external returns (uint256 shares) {
        if (asset == address(0) || receiver == address(0)) revert Errors.InvalidAddress();
        if (amount == 0) revert Errors.InvalidAmount();

        bool ok = IERC20Like(asset).transferFrom(msg.sender, address(this), amount);
        if (!ok) revert Errors.InvalidAmount();

        shares = amount;
        assetBalance[asset] += amount;
        share.mint(receiver, shares);

        emit LiquidityAdded(asset, receiver, amount, shares);
    }

    function withdraw(address asset, uint256 shares, address receiver) external returns (uint256 amount) {
        if (asset == address(0) || receiver == address(0)) revert Errors.InvalidAddress();
        if (shares == 0) revert Errors.InvalidAmount();
        if (assetBalance[asset] < shares) revert Errors.InvalidAmount();

        amount = shares;
        assetBalance[asset] -= amount;
        share.burn(msg.sender, shares);

        bool ok = IERC20Like(asset).transfer(receiver, amount);
        if (!ok) revert Errors.InvalidAmount();

        emit LiquidityRemoved(asset, msg.sender, shares, amount);
    }
}
