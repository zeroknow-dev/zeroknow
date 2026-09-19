// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20Lite} from "./ERC20Lite.sol";

contract MockERC20 is ERC20Lite {
    constructor(string memory name_, string memory symbol_) ERC20Lite(name_, symbol_) {}

    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }
}
