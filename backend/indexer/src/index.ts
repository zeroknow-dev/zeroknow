import { Pool } from "pg";
import { createPublicClient, http, parseAbiItem } from "viem";

const databaseUrl = process.env.DATABASE_URL;
const rpcUrl = process.env.INDEXER_RPC_URL;
const chainId = Number(process.env.INDEXER_CHAIN_ID || "0");
const startBlock = BigInt(process.env.INDEXER_START_BLOCK || "0");
const proofRegistry = process.env.INDEXER_PROOF_REQUEST_REGISTRY as `0x${string}` | undefined;
const portfolioFactory = process.env.INDEXER_PORTFOLIO_FACTORY as `0x${string}` | undefined;

if (!databaseUrl) {
  throw new Error("DATABASE_URL is required");
}

if (!rpcUrl || !chainId) {
  throw new Error("INDEXER_RPC_URL and INDEXER_CHAIN_ID are required");
}

const pool = new Pool({ connectionString: databaseUrl });

const client = createPublicClient({
  chain: {
    id: chainId,
    name: "configured-network",
    nativeCurrency: { name: "Ether", symbol: "ETH", decimals: 18 },
    rpcUrls: { default: { http: [rpcUrl] } }
  },
  transport: http(rpcUrl)
});

async function recordProofEvents() {
  if (!proofRegistry) return;

  const logs = await client.getLogs({
    address: proofRegistry,
    event: parseAbiItem(
      "event ProofRequested(uint256 indexed requestId, address indexed requester, bytes32 indexed claimHash, address verifier, string metadataURI)"
    ),
    fromBlock: startBlock,
    toBlock: "latest"
  });

  for (const log of logs) {
    await pool.query(
      `insert into proof_requests
        (chain_id, request_id, requester, claim_hash, verifier, metadata_uri, tx_hash, block_number)
       values ($1,$2,$3,$4,$5,$6,$7,$8)
       on conflict (chain_id, request_id) do nothing`,
      [
        chainId,
        log.args.requestId?.toString(),
        log.args.requester,
        log.args.claimHash,
        log.args.verifier,
        log.args.metadataURI,
        log.transactionHash,
        log.blockNumber?.toString()
      ]
    );
  }
}

async function recordPortfolioEvents() {
  if (!portfolioFactory) return;

  const logs = await client.getLogs({
    address: portfolioFactory,
    event: parseAbiItem(
      "event PortfolioCreated(address indexed creator, address indexed vault, address indexed share, string name, string symbol, string metadataURI)"
    ),
    fromBlock: startBlock,
    toBlock: "latest"
  });

  for (const log of logs) {
    await pool.query(
      `insert into portfolio_created_events
        (chain_id, creator, vault, share, name, symbol, metadata_uri, tx_hash, block_number)
       values ($1,$2,$3,$4,$5,$6,$7,$8,$9)
       on conflict (chain_id, vault) do nothing`,
      [
        chainId,
        log.args.creator,
        log.args.vault,
        log.args.share,
        log.args.name,
        log.args.symbol,
        log.args.metadataURI,
        log.transactionHash,
        log.blockNumber?.toString()
      ]
    );
  }
}

async function main() {
  await recordProofEvents();
  await recordPortfolioEvents();
  await pool.end();
}

main().catch(async (error) => {
  console.error(error);
  await pool.end();
  process.exitCode = 1;
});
