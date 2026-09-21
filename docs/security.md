# Security

**Experimental / Under Active Development / Not Audited**

The ZeroKnow paper states that security depends on cryptographic primitives, circuit design, implementation, key management, and protocol assumptions.

## Requirements Before Production

- Formal protocol specification.
- Audited circuits and verifier contracts.
- Transparent cryptographic assumptions.
- Reproducible builds.
- Independent security review.
- Threat model for linkability and metadata leakage.
- Key management design.
- Nullifier and replay protection design.
- Prover marketplace security model.
- Oracle design if portfolio extensions are retained.
- Economic analysis if native utility or ecosystem incentives are introduced.

## Development-Only Components

The following are explicitly not production-ready:

- `DevProofVerifier`
- `DevOracleRegistry`
- `MockERC20`
- `MockMarketAdapter`

## Privacy Warning

Putting proof metadata onchain can still leak information. Even when proofs reveal less than raw private state, request timing, claim categories, public inputs, verifier identity, and application usage can become behavioral signals.
