// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ERC20Lite} from "./ERC20Lite.sol";
import {Errors} from "../libraries/Errors.sol";

contract PortfolioShare is ERC20Lite {
    address public immutable vault;

    constructor(string memory name_, string memory symbol_, address vault_) ERC20Lite(name_, symbol_) {
        if (vault_ == address(0)) revert Errors.InvalidAddress();
        vault = vault_;
    }

    modifier onlyVault() {
        if (msg.sender != vault) revert Errors.NotOwner();
        _;
    }

    function mint(address to, uint256 amount) external onlyVault {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) external onlyVault {
        _burn(from, amount);
    }
}
