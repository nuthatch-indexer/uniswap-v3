-- Per-pool gross volume — the metric the Uniswap subgraph publishes as volumeToken0/volumeToken1,
-- here a plain SUM over signed swap amounts. A swap records signed deltas (one token in, one out), so
-- gross flow is `sum(abs(...))`. Amounts are in raw units; divide by 10^decimals for human units
-- (token decimals need a contract call, out of scope for the declarative core — join a token list).
--
-- The `*_dec` columns are the DECIMAL(38,0) views nuthatch derives for the int256 amount columns —
-- so this is honest arithmetic over the exact on-chain values, not a floating-point approximation.
CREATE VIEW pool_volume AS
SELECT
  s.address                    AS pool,
  count(*)                     AS swaps,
  sum(abs(s.amount0_dec))      AS volume_token0,
  sum(abs(s.amount1_dec))      AS volume_token1
FROM pool__swap s
GROUP BY s.address;
