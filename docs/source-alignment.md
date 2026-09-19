# Source Alignment and Deviations

**Experimental / Under Active Development / Not Audited**

This document reconciles the requested repository scope against the attached **ZeroKnow v1.0 Concept Paper**.

## Concepts Supported by the Paper

The concept paper supports the following protocol themes:

- Privacy-focused onchain infrastructure.
- Zero-knowledge cryptography for proving claims without revealing underlying information.
- Private state.
- Proof generation.
- Verification.
- Selective disclosure.
- Privacy-preserving payments, identity, DeFi, trading, reputation, credentials, DAOs, gaming, token ecosystems, and cross-chain activity.
- Architecture layers:
  - Private State Layer
  - Proof Layer
  - Verification Layer
  - Application Layer
  - Settlement Layer
- Developer SDK abstractions.
- Decentralized prover ecosystem / proof marketplace.
- Security assumptions around cryptographic primitives, circuits, implementation, key management, and protocol assumptions.
- Possible $ZK utility and ecosystem functions.
- Roadmap phases from research through privacy ecosystem.

## Concepts Not Specified by the Paper

The concept paper does **not** define:

- PortfolioFactory
- PortfolioVault
- PortfolioShare
- MarketRouter
- Portfolio-first markets
- Portfolio share liquidity accounting
- Oracle-backed portfolio valuation
- Router adapter markets

These modules were included because they were explicitly requested by the user. They are treated as experimental extensions and are not presented as ZeroKnow v1.0 paper-defined architecture.

## Implementation Decision

This repo includes both:

1. ZeroKnow-native scaffolding:
   - `ProofRequestRegistry`
   - `DevProofVerifier`
   - `ProverRegistry`
   - SDK helpers for proof requests and proof submission

2. Requested portfolio extension:
   - `PortfolioFactory`
   - `PortfolioVault`
   - `PortfolioShare`
   - `MarketRouter`
   - `DevOracleRegistry`

The portfolio extension is useful as a sample application surface where proof-aware private DeFi might eventually be explored, but it is not a claim from the paper.
