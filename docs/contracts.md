# Contracts

All contracts are experimental and not audited.

## Paper-Aligned Scaffolding

### ProofRequestRegistry

Creates proof requests, accepts proof submissions, delegates validation to a verifier, and stores minimal public status.

### DevProofVerifier

Development-only verifier. It validates a proof by comparing `keccak256(proof, publicInputs)` to a configured expected value.

Do not use this in production.

### ProverRegistry

Simple metadata registry for prover participants.

## Requested Experimental Portfolio Extension

These contracts are not specified by the ZeroKnow v1.0 Concept Paper.

### PortfolioFactory

Permissionlessly deploys `PortfolioVault` instances.

### PortfolioVault

Accepts ERC20-like assets and mints portfolio shares one-to-one with deposits in this MVP. This is deliberately simple and does not implement production-grade NAV, strategy accounting, fees, or slippage.

### PortfolioShare

Minimal ERC20-like share token minted and burned by its vault.

### MarketRouter

Routes calls to configured market adapters.

### DevOracleRegistry

Development-only price registry. It is included because the requested portfolio extension may need local price references. It is not a production oracle.

## Known Contract Limitations

- No production ZK verifier.
- No privacy-preserving state commitment tree.
- No nullifier set.
- No real proof marketplace settlement.
- No reentrancy guard in the simple portfolio MVP.
- No fee, slippage, or NAV model.
- No production oracle integration.
- No deployed addresses.
