import { defaultNetworkConfig } from "@zeroknow/config";
import { StatusBadge } from "../components/status-badge";

const layers = [
  "Private State",
  "Proof Generation",
  "Verification",
  "Application",
  "Settlement"
];

const useCases = [
  "Private payments",
  "Private DeFi",
  "Private identity",
  "Private DAOs",
  "Private reputation",
  "Private credentials"
];

export default function HomePage() {
  return (
    <main>
      <nav className="nav">
        <strong>ZEROKNOW</strong>
        <div>
          <a href="#protocol">Protocol</a>
          <a href="#sdk">SDK</a>
          <a href="#extensions">Extensions</a>
          <a href="#risks">Risks</a>
        </div>
      </nav>

      <section className="hero">
        <div className="heroCopy">
          <StatusBadge />
          <p className="eyebrow">Zero-knowledge privacy infrastructure</p>
          <h1>Reveal the minimum. Prove the maximum.</h1>
          <p className="lead">
            ZeroKnow lets applications verify claims without unnecessarily exposing balances,
            credentials, identity data, transaction history, or reputation sources.
          </p>
          <div className="actions">
            <a href="#protocol">Explore protocol</a>
            <a href="#sdk" className="secondary">
              Developer SDK
            </a>
          </div>
        </div>
        <div className="proofObject" aria-label="Abstract private state proof visualization">
          <div className="xMark" />
          <div className="privateLayer">PRIVATE STATE</div>
          <div className="proofLayer">PROOF</div>
          <div className="validLayer">VALID</div>
        </div>
      </section>

      <section id="protocol" className="band">
        <p className="eyebrow">Architecture</p>
        <h2>Private data becomes a verifiable claim, not a public dataset.</h2>
        <div className="layerGrid">
          {layers.map((layer, index) => (
            <article key={layer}>
              <span>{String(index + 1).padStart(2, "0")}</span>
              <h3>{layer}</h3>
            </article>
          ))}
        </div>
      </section>

      <section id="sdk" className="split">
        <div>
          <p className="eyebrow">SDK</p>
          <h2>Request proofs with application-friendly helpers.</h2>
          <p>
            The SDK scaffold uses viem and exports helpers for creating proof requests,
            submitting development proofs, and interacting with the requested portfolio extension.
          </p>
        </div>
        <pre>{`await createProofRequest(client, {
  claimHash,
  verifier,
  metadataURI
});`}</pre>
      </section>

      <section id="extensions" className="band alt">
        <p className="eyebrow">Requested extension</p>
        <h2>Portfolio contracts are experimental additions, not paper-defined ZeroKnow v1.0 modules.</h2>
        <p>
          The ZeroKnow paper describes private state, proofs, verification, selective disclosure,
          prover markets, SDKs, and security assumptions. PortfolioFactory, PortfolioVault,
          PortfolioShare, and MarketRouter are included only as requested experimental extensions.
        </p>
      </section>

      <section className="useCases">
        {useCases.map((useCase) => (
          <article key={useCase}>{useCase}</article>
        ))}
      </section>

      <section id="risks" className="footerBand">
        <h2>Experimental. Under active development. Not audited.</h2>
        <p>
          No deployed addresses are included. Default network config contains no fabricated chain IDs,
          RPC URLs, Robinhood Chain metadata, audit claims, or production readiness statements.
        </p>
        <p>Configured networks: {defaultNetworkConfig.length}</p>
      </section>
    </main>
  );
}
