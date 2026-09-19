// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {PortfolioFactory} from "../src/extensions/PortfolioFactory.sol";
import {PortfolioVault} from "../src/extensions/PortfolioVault.sol";
import {PortfolioShare} from "../src/extensions/PortfolioShare.sol";
import {MarketRouter} from "../src/extensions/MarketRouter.sol";
import {MockMarketAdapter} from "../src/extensions/MockMarketAdapter.sol";
import {MockERC20} from "../src/extensions/MockERC20.sol";

contract PortfolioExtensionTest {
    function testCreatePortfolio() public {
        PortfolioFactory factory = new PortfolioFactory();
        address vaultAddress = factory.createPortfolio("ZeroKnow Privacy Basket", "zkBASKET", "ipfs://metadata");

        PortfolioVault vault = PortfolioVault(vaultAddress);
        assertEq(vault.creator(), address(this));
        assertEq(factory.allVaultsLength(), 1);
        assertTrue(address(vault.share()) != address(0));
    }

    function testAddRemoveLiquidity() public {
        PortfolioFactory factory = new PortfolioFactory();
        PortfolioVault vault =
            PortfolioVault(factory.createPortfolio("ZeroKnow Privacy Basket", "zkBASKET", "ipfs://metadata"));
        MockERC20 asset = new MockERC20("Mock Asset", "MOCK");

        asset.mint(address(this), 100 ether);
        asset.approve(address(vault), 100 ether);

        uint256 mintedShares = vault.deposit(address(asset), 10 ether, address(this));
        PortfolioShare share = vault.share();

        assertEq(mintedShares, 10 ether);
        assertEq(asset.balanceOf(address(vault)), 10 ether);
        assertEq(share.balanceOf(address(this)), 10 ether);

        uint256 withdrawn = vault.withdraw(address(asset), 4 ether, address(this));

        assertEq(withdrawn, 4 ether);
        assertEq(asset.balanceOf(address(this)), 94 ether);
        assertEq(share.balanceOf(address(this)), 6 ether);
        assertEq(vault.assetBalance(address(asset)), 6 ether);
    }

    function testRouterAdapterFlow() public {
        MarketRouter router = new MarketRouter(address(this));
        MockMarketAdapter adapter = new MockMarketAdapter();
        bytes32 marketId = keccak256("DEV_MARKET");
        bytes memory payload = abi.encode("proof-aware-route", uint256(100));

        router.setAdapter(marketId, address(adapter));
        bytes memory result = router.route(marketId, payload);
        bytes32 routedHash = abi.decode(result, (bytes32));

        assertEq(routedHash, keccak256(payload));
    }

    function assertTrue(bool condition) internal pure {
        require(condition, "assertTrue failed");
    }

    function assertEq(address left, address right) internal pure {
        require(left == right, "address assertEq failed");
    }

    function assertEq(uint256 left, uint256 right) internal pure {
        require(left == right, "uint256 assertEq failed");
    }

    function assertEq(bytes32 left, bytes32 right) internal pure {
        require(left == right, "bytes32 assertEq failed");
    }
}
