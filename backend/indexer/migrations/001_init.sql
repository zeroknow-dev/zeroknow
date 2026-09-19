create table if not exists indexer_runs (
  id bigserial primary key,
  chain_id integer not null,
  started_at timestamptz not null default now(),
  completed_at timestamptz,
  from_block numeric not null,
  to_block numeric
);

create table if not exists proof_requests (
  id bigserial primary key,
  chain_id integer not null,
  request_id numeric not null,
  requester text not null,
  claim_hash text not null,
  verifier text not null,
  metadata_uri text not null,
  tx_hash text not null,
  block_number numeric not null,
  observed_at timestamptz not null default now(),
  unique (chain_id, request_id)
);

create table if not exists proof_verifications (
  id bigserial primary key,
  chain_id integer not null,
  request_id numeric not null,
  verifier text not null,
  prover text not null,
  tx_hash text not null,
  block_number numeric not null,
  observed_at timestamptz not null default now()
);

create table if not exists portfolio_created_events (
  id bigserial primary key,
  chain_id integer not null,
  creator text not null,
  vault text not null,
  share text not null,
  name text not null,
  symbol text not null,
  metadata_uri text not null,
  tx_hash text not null,
  block_number numeric not null,
  observed_at timestamptz not null default now(),
  unique (chain_id, vault)
);

comment on table proof_requests is
  'Analytics-only event mirror. Onchain contracts remain canonical for proof request state.';

comment on table portfolio_created_events is
  'Analytics-only event mirror. This table is not canonical ownership, share balance, or vault accounting state.';
