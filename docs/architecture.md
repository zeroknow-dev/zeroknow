# Architecture

ZeroKnow is modeled as a privacy infrastructure stack:

```text
Private State -> Proof Generation -> Verification -> Application -> Settlement
```

## Private State Layer

Represents user-owned information that should not automatically become public, such as balances, credentials, eligibility, reputation, or membership.

This scaffold does not implement private storage or cryptographic circuits. It defines application-facing registries and interfaces that can later be connected to real proof systems.

## Proof Layer

Proofs are represented by opaque bytes in the MVP. `DevProofVerifier` is intentionally development-only and checks a configured hash.

Production implementations must replace this with audited proof verification contracts and carefully specified circuits.

## Verification Layer

`ProofRequestRegistry` lets applications create claim requests and lets provers submit proofs against a verifier contract.

## Application Layer

The Next.js app and SDK show how developers might integrate ZeroKnow proof requests.

## Settlement Layer

Settlement is application-specific. The requested portfolio extension contains vault accounting and router flows as a sample extension, not a paper-defined settlement system.
