-- Per-pool activity + latest price: the "which pools are busy and where do they trade" dashboard row.
-- Swap / mint / burn counts and the most recent swap price for each pool, joined to its pair and fee.
-- Pools with no swaps in the indexed range still appear (left join), with 0 swaps and a null price.
CREATE VIEW pool_stats AS
SELECT
  p.pool,
  p.token0,
  p.token1,
  p.fee,
  p.tick_spacing,
  p.created_at,
  count(s.log_index)                                                            AS swaps,
  (SELECT count(*) FROM pool__mint m WHERE m.address = p.pool)                  AS mints,
  (SELECT count(*) FROM pool__burn b WHERE b.address = p.pool)                  AS burns,
  max(s.block_timestamp)                                                        AS last_swap_at,
  -- Latest swap's price (chain order = block_number then log_index).
  arg_max(
    pow(CAST(s.sqrtPriceX96 AS DOUBLE) / pow(2, 96), 2),
    s.block_number * 1000000 + s.log_index
  )                                                                             AS latest_price
FROM pools p
LEFT JOIN pool__swap s ON s.address = p.pool
GROUP BY p.pool, p.token0, p.token1, p.fee, p.tick_spacing, p.created_at;
