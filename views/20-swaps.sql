-- Every swap across every discovered pool, joined to its token pair, with the post-swap price derived
-- from `sqrtPriceX96` — Uniswap-v3's price accumulator: price = (sqrtPriceX96 / 2^96)^2, expressed as
-- token1 per token0 in *raw* units (multiply by 10^(decimals0-decimals1) for a human price; token
-- decimals need a contract call, out of scope for the declarative core — join a vendored token list).
--
-- `amount0`/`amount1` are the signed int256 deltas the pool recorded (one negative = out, one positive
-- = in). They are carried through raw: nuthatch stores a negative int256 as its two's-complement hex,
-- so they are NOT summed here — see the note in semantic.toml. `tick` is the post-swap tick.
CREATE VIEW swaps AS
SELECT
  s.address                                            AS pool,
  p.token0,
  p.token1,
  s.block_number,
  s.block_timestamp,
  s.tx_hash,
  s.log_index,
  s.sender,
  s.recipient,
  pow(CAST(s.sqrtPriceX96 AS DOUBLE) / pow(2, 96), 2)  AS price_token1_per_token0,
  CAST(s.tick AS INTEGER)                              AS tick
FROM pool__swap s
LEFT JOIN pools p ON p.pool = s.address;
