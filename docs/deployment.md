# Deployment

This repository does not include any production deployment claims.

## Local

Install Foundry, then run:

```bash
cd contracts
forge test
```

For local deployment, use Anvil and a deployment workflow of your choice. The included `DeployZeroKnow.s.sol` is a simple deployer contract scaffold and avoids hard-coded private keys, RPC URLs, or chain assumptions.

## Networks

No production networks are configured.

Do not add:

- fabricated chain IDs
- fabricated RPC URLs
- fabricated Robinhood Chain metadata
- fabricated deployed addresses
- fabricated audit references

Only add verified network metadata controlled by the project.
