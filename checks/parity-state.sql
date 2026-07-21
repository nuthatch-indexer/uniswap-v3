-- Parity vs the canonical Uniswap V3 Arbitrum subgraph (3V7ZY6muhxaQL5qvntX1CFXJ32W7BxXZTGTwmpH5J4t3),
-- queried at the SAME block. Raw on-chain units — byte-exact, no floating point.
-- Pool: WETH/USDC 0.05% (0xC6962004f452bE9203591991D15f6b388e09E8D0).
-- Subgraph pool state @ block 485,300,000:
--   tick = -201022   sqrtPrice = 3419540503345272445389517   liquidity = 2712824308373787012  → all exact.
-- Human price = pow(sqrtPriceX96/2^96, 2) * 10^(dec0-dec1) via DOUBLE (see 30-pool-stats.sql); the
-- exact sqrtPriceX96 match here proves the price input is exact.
-- Requires a backfill covering block 485,300,000 for this pool.
SELECT
  block_number,
  tick,
  sqrtPriceX96,
  CAST(liquidity AS DECIMAL(38,0)) AS liquidity
FROM "pool__swap"
WHERE address = '0xc6962004f452be9203591991d15f6b388e09e8d0'
  AND block_number <= 485300000
ORDER BY block_number DESC, log_index DESC
LIMIT 1;
