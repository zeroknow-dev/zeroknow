export const proofRequestRegistryAbi = [
  {
    type: "function",
    name: "createRequest",
    stateMutability: "nonpayable",
    inputs: [
      { name: "claimHash", type: "bytes32" },
      { name: "verifier", type: "address" },
      { name: "metadataURI", type: "string" }
    ],
    outputs: [{ name: "requestId", type: "uint256" }]
  },
  {
    type: "function",
    name: "submitProof",
    stateMutability: "nonpayable",
    inputs: [
      { name: "requestId", type: "uint256" },
      { name: "proof", type: "bytes" },
      { name: "publicInputs", type: "bytes" }
    ],
    outputs: []
  },
  {
    type: "event",
    name: "ProofRequested",
    inputs: [
      { indexed: true, name: "requestId", type: "uint256" },
      { indexed: true, name: "requester", type: "address" },
      { indexed: true, name: "claimHash", type: "bytes32" },
      { indexed: false, name: "verifier", type: "address" },
      { indexed: false, name: "metadataURI", type: "string" }
    ]
  },
  {
    type: "event",
    name: "ProofVerified",
    inputs: [
      { indexed: true, name: "requestId", type: "uint256" },
      { indexed: true, name: "verifier", type: "address" },
      { indexed: true, name: "prover", type: "address" }
    ]
  }
] as const;

export const portfolioFactoryAbi = [
  {
    type: "function",
    name: "createPortfolio",
    stateMutability: "nonpayable",
    inputs: [
      { name: "name", type: "string" },
      { name: "symbol", type: "string" },
      { name: "metadataURI", type: "string" }
    ],
    outputs: [{ name: "vault", type: "address" }]
  },
  {
    type: "function",
    name: "allVaultsLength",
    stateMutability: "view",
    inputs: [],
    outputs: [{ name: "", type: "uint256" }]
  },
  {
    type: "event",
    name: "PortfolioCreated",
    inputs: [
      { indexed: true, name: "creator", type: "address" },
      { indexed: true, name: "vault", type: "address" },
      { indexed: true, name: "share", type: "address" },
      { indexed: false, name: "name", type: "string" },
      { indexed: false, name: "symbol", type: "string" },
      { indexed: false, name: "metadataURI", type: "string" }
    ]
  }
] as const;

export const portfolioVaultAbi = [
  {
    type: "function",
    name: "deposit",
    stateMutability: "nonpayable",
    inputs: [
      { name: "asset", type: "address" },
      { name: "amount", type: "uint256" },
      { name: "receiver", type: "address" }
    ],
    outputs: [{ name: "shares", type: "uint256" }]
  },
  {
    type: "function",
    name: "withdraw",
    stateMutability: "nonpayable",
    inputs: [
      { name: "asset", type: "address" },
      { name: "shares", type: "uint256" },
      { name: "receiver", type: "address" }
    ],
    outputs: [{ name: "amount", type: "uint256" }]
  },
  {
    type: "function",
    name: "share",
    stateMutability: "view",
    inputs: [],
    outputs: [{ name: "", type: "address" }]
  }
] as const;

export const marketRouterAbi = [
  {
    type: "function",
    name: "setAdapter",
    stateMutability: "nonpayable",
    inputs: [
      { name: "marketId", type: "bytes32" },
      { name: "adapter", type: "address" }
    ],
    outputs: []
  },
  {
    type: "function",
    name: "route",
    stateMutability: "nonpayable",
    inputs: [
      { name: "marketId", type: "bytes32" },
      { name: "data", type: "bytes" }
    ],
    outputs: [{ name: "result", type: "bytes" }]
  }
] as const;
