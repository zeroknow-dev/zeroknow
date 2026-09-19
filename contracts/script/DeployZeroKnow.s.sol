// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {ProofRequestRegistry} from "../src/ProofRequestRegistry.sol";
import {DevProofVerifier} from "../src/DevProofVerifier.sol";
import {ProverRegistry} from "../src/ProverRegistry.sol";
import {PortfolioFactory} from "../src/extensions/PortfolioFactory.sol";
import {MarketRouter} from "../src/extensions/MarketRouter.sol";
import {DevOracleRegistry} from "../src/extensions/DevOracleRegistry.sol";

contract DeployZeroKnow {
    struct Deployment {
        address proofRequestRegistry;
        address devProofVerifier;
        address proverRegistry;
        address portfolioFactory;
        address marketRouter;
        address devOracleRegistry;
    }

    function run(address owner) external returns (Deployment memory deployment) {
        ProofRequestRegistry proofRequestRegistry = new ProofRequestRegistry();
        DevProofVerifier devProofVerifier = new DevProofVerifier();
        ProverRegistry proverRegistry = new ProverRegistry();
        PortfolioFactory portfolioFactory = new PortfolioFactory();
        MarketRouter marketRouter = new MarketRouter(owner);
        DevOracleRegistry devOracleRegistry = new DevOracleRegistry(owner);

        deployment = Deployment({
            proofRequestRegistry: address(proofRequestRegistry),
            devProofVerifier: address(devProofVerifier),
            proverRegistry: address(proverRegistry),
            portfolioFactory: address(portfolioFactory),
            marketRouter: address(marketRouter),
            devOracleRegistry: address(devOracleRegistry)
        });
    }
}
