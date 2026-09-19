# ZeroKnow Indexer

Experimental analytics indexer for ZeroKnow events.

This service mirrors selected events into PostgreSQL for dashboards, analytics, and developer visibility. It must not be treated as canonical balances, ownership, identity, proof validity, or vault accounting.

Canonical state remains onchain.

## Run

```bash
DATABASE_URL=postgres://postgres:postgres@localhost:5432/zeroknow_indexer \
INDEXER_RPC_URL=http://127.0.0.1:8545 \
INDEXER_CHAIN_ID=31337 \
INDEXER_START_BLOCK=0 \
npm run dev
```
