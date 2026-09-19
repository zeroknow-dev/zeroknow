// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Errors} from "./libraries/Errors.sol";

abstract contract Ownable {
    address public owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor(address initialOwner) {
        if (initialOwner == address(0)) revert Errors.InvalidAddress();
        owner = initialOwner;
        emit OwnershipTransferred(address(0), initialOwner);
    }

    modifier onlyOwner() {
        if (msg.sender != owner) revert Errors.NotOwner();
        _;
    }

    function transferOwnership(address newOwner) external onlyOwner {
        if (newOwner == address(0)) revert Errors.InvalidAddress();
        emit OwnershipTransferred(owner, newOwner);
        owner = newOwner;
    }
}
