// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {IMarketAdapter} from "../interfaces/IMarketAdapter.sol";

contract MockMarketAdapter is IMarketAdapter {
    event Executed(address indexed caller, bytes data);

    function execute(bytes calldata data) external returns (bytes memory result) {
        emit Executed(msg.sender, data);
        return abi.encode(keccak256(data));
    }
}
