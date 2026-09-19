# SDK

The SDK is a TypeScript scaffold built around viem.

## Helpers

- `createProofRequest`
- `submitProof`
- `createPortfolio`
- `depositToPortfolio`
- `routeMarket`

## Example

```ts
import { createProofRequest } from "@zeroknow/sdk";

await createProofRequest(walletClient, {
  registry: "0x...",
  claimHash: "0x...",
  verifier: "0x...",
  metadataURI: "ipfs://..."
});
```

The SDK does not generate real zero-knowledge proofs yet. It defines the integration boundary where a real proof engine can later plug in.
