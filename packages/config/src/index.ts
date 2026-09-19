export type ZeroKnowContracts = {
  proofRequestRegistry?: `0x${string}`;
  devProofVerifier?: `0x${string}`;
  proverRegistry?: `0x${string}`;
  portfolioFactory?: `0x${string}`;
  marketRouter?: `0x${string}`;
  devOracleRegistry?: `0x${string}`;
};

export type ZeroKnowNetworkConfig = {
  name: string;
  chainId?: number;
  rpcUrl?: string;
  explorerUrl?: string;
  contracts: ZeroKnowContracts;
  notes: string;
};

export const defaultNetworkConfig: ZeroKnowNetworkConfig[] = [
  {
    name: "local-anvil",
    chainId: 31337,
    rpcUrl: "http://127.0.0.1:8545",
    contracts: {},
    notes: "Local development only. Replace addresses after local deployment."
  }
];

export const unsupportedNetworkNotice =
  "No production networks or deployed addresses are claimed by this scaffold. Add only verified values.";
