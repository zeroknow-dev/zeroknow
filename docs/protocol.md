# Protocol Notes

## Principle

Reveal the minimum. Prove the maximum.

ZeroKnow separates the information needed to prove a statement from the information disclosed to a network or application.

## Claim Requests

An application can request proof of a claim, such as:

```text
balance >= 10000
age >= 18
membership == approved
reputation_score >= 90
```

The claim is represented by a `bytes32 claimHash`. Metadata can point to offchain context such as a schema, credential description, or application policy.

## Proof Submission

The prover submits:

- proof bytes
- public input bytes

The registry asks the verifier whether the proof is valid for the requested claim.

## Selective Disclosure

Selective disclosure is a protocol goal from the ZeroKnow paper. This scaffold does not implement private credential formats, nullifier design, membership trees, or disclosure policies. Those require formal protocol specifications and audits.

## Decentralized Prover Ecosystem

`ProverRegistry` is a small scaffold for prover metadata and active status. A production prover marketplace would need:

- job pricing
- staking or reputation
- proof assignment
- slashing or dispute handling
- payout settlement
- privacy-preserving job metadata
