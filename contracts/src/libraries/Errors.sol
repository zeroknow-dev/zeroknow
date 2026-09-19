// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

library Errors {
    error NotOwner();
    error NotVerifier();
    error NotFactory();
    error NotRouter();
    error InvalidAddress();
    error InvalidAmount();
    error InvalidProof();
    error RequestNotFound();
    error RequestClosed();
    error AlreadyVerified();
    error InsufficientShares();
    error OraclePriceUnavailable();
}
