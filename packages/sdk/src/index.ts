import type { Address, Hex, WalletClient } from "viem";
import {
  marketRouterAbi,
  portfolioFactoryAbi,
  portfolioVaultAbi,
  proofRequestRegistryAbi
} from "@zeroknow/abi";

export type WriteClient = WalletClient & {
  account: NonNullable<WalletClient["account"]>;
};

export type CreateProofRequestArgs = {
  registry: Address;
  claimHash: Hex;
  verifier: Address;
  metadataURI: string;
};

export async function createProofRequest(client: WriteClient, args: CreateProofRequestArgs) {
  return client.writeContract({
    account: client.account,
    address: args.registry,
    abi: proofRequestRegistryAbi,
    functionName: "createRequest",
    args: [args.claimHash, args.verifier, args.metadataURI],
    chain: client.chain
  });
}

export type SubmitProofArgs = {
  registry: Address;
  requestId: bigint;
  proof: Hex;
  publicInputs: Hex;
};

export async function submitProof(client: WriteClient, args: SubmitProofArgs) {
  return client.writeContract({
    account: client.account,
    address: args.registry,
    abi: proofRequestRegistryAbi,
    functionName: "submitProof",
    args: [args.requestId, args.proof, args.publicInputs],
    chain: client.chain
  });
}

export type CreatePortfolioArgs = {
  factory: Address;
  name: string;
  symbol: string;
  metadataURI: string;
};

export async function createPortfolio(client: WriteClient, args: CreatePortfolioArgs) {
  return client.writeContract({
    account: client.account,
    address: args.factory,
    abi: portfolioFactoryAbi,
    functionName: "createPortfolio",
    args: [args.name, args.symbol, args.metadataURI],
    chain: client.chain
  });
}

export type DepositPortfolioArgs = {
  vault: Address;
  asset: Address;
  amount: bigint;
  receiver: Address;
};

export async function depositToPortfolio(client: WriteClient, args: DepositPortfolioArgs) {
  return client.writeContract({
    account: client.account,
    address: args.vault,
    abi: portfolioVaultAbi,
    functionName: "deposit",
    args: [args.asset, args.amount, args.receiver],
    chain: client.chain
  });
}

export type RouteMarketArgs = {
  router: Address;
  marketId: Hex;
  data: Hex;
};

export async function routeMarket(client: WriteClient, args: RouteMarketArgs) {
  return client.writeContract({
    account: client.account,
    address: args.router,
    abi: marketRouterAbi,
    functionName: "route",
    args: [args.marketId, args.data],
    chain: client.chain
  });
}
