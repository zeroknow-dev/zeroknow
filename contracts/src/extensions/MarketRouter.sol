// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Ownable} from "../Ownable.sol";
import {Errors} from "../libraries/Errors.sol";
import {IMarketAdapter} from "../interfaces/IMarketAdapter.sol";

contract MarketRouter is Ownable {
    mapping(bytes32 => address) public adapters;

    event AdapterSet(bytes32 indexed marketId, address indexed adapter);
    event Routed(bytes32 indexed marketId, address indexed caller, bytes result);

    constructor(address owner_) Ownable(owner_) {}

    function setAdapter(bytes32 marketId, address adapter) external onlyOwner {
        if (marketId == bytes32(0) || adapter == address(0)) revert Errors.InvalidAddress();
        adapters[marketId] = adapter;
        emit AdapterSet(marketId, adapter);
    }

    function route(bytes32 marketId, bytes calldata data) external returns (bytes memory result) {
        address adapter = adapters[marketId];
        if (adapter == address(0)) revert Errors.InvalidAddress();
        result = IMarketAdapter(adapter).execute(data);
        emit Routed(marketId, msg.sender, result);
    }
}
