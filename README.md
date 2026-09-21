# ZEROKNOW Protocol

**Experimental / Under Active Development / Not Audited**

ZeroKnow is privacy-focused onchain infrastructure for verifiable digital activity. The v1.0 protocol paper describes a system that lets users and applications prove claims while minimizing disclosure of the underlying information.

Core principle:

> Reveal the minimum. Prove the maximum.

This repository is a GitHub-ready protocol scaffold. It includes Solidity contracts, a Foundry project, a TypeScript SDK, ABI/config packages, a Next.js frontend scaffold, a PostgreSQL-backed analytics indexer scaffold, and protocol documentation.

## Repository Layout

```text
apps/web                 Next.js app scaffold
contracts                Foundry Solidity project
packages/sdk             TypeScript viem helpers
packages/abi             Minimal ABI exports
packages/config          Network and contract configuration
backend/indexer          Node/TypeScript indexing scaffold
docs                     Architecture, protocol, contracts, security, risks
```

## What Is Implemented

- ZeroKnow-native proof request registry for claim requests, proof submissions, and verification status.
- Development-only verifier and prover registry for local experimentation.
- Requested portfolio extension:
  - `PortfolioFactory`
  - `PortfolioVault`
  - `PortfolioShare`
  - `MarketRouter`
  - `DevOracleRegistry`
- Foundry tests for portfolio creation, add/remove liquidity, and router adapter flow.
- SDK helpers for proof requests and portfolio extension flows.
- Minimal ABIs and network config with no fabricated chain IDs, RPC URLs, or deployed addresses.
- Indexer migrations for analytics only, not canonical balances or ownership.

## Quick Start

```bash
npm install
npm run build
```

Contracts:

```bash
cd contracts
forge test
```

Foundry was not bundled in this environment when this repo was generated. Install Foundry from the official Foundry docs before running contract tests locally.

## Environment

Copy `.env.example` to `.env` and fill only real values you control. Do not add fabricated chain IDs, RPC URLs, deployed addresses, audits, or production-readiness claims.

## Status

- Experimental
- Under active development
- Not audited
- Not production ready
- No deployed addresses included
- No Robinhood Chain metadata fabricated

## License

MIT
