// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Ownable} from "../Ownable.sol";
import {Errors} from "../libraries/Errors.sol";

contract DevOracleRegistry is Ownable {
    struct Price {
        uint256 value;
        uint256 updatedAt;
    }

    mapping(address => Price) public prices;

    event DevPriceSet(address indexed asset, uint256 value, uint256 updatedAt);

    constructor(address owner_) Ownable(owner_) {}

    function setPrice(address asset, uint256 value) external onlyOwner {
        if (asset == address(0)) revert Errors.InvalidAddress();
        if (value == 0) revert Errors.InvalidAmount();
        prices[asset] = Price({value: value, updatedAt: block.timestamp});
        emit DevPriceSet(asset, value, block.timestamp);
    }

    function getPrice(address asset) external view returns (uint256 value, uint256 updatedAt) {
        Price memory price = prices[asset];
        if (price.value == 0) revert Errors.OraclePriceUnavailable();
        return (price.value, price.updatedAt);
    }
}
