-- The pool registry: one row per pool the factory has ever created, with its token pair, fee tier
-- (in hundredths of a bip: 100 = 0.01%, 500 = 0.05%, 3000 = 0.3%, 10000 = 1%), and tick spacing.
-- `pool` is the pool contract address — the key every `pool__*` event joins on (their implicit
-- `address` column). This is the spine the rest of the views hang off; one factory rule discovers
-- every row, no per-pool config.
CREATE VIEW pools AS
SELECT
  pool,
  token0,
  token1,
  CAST(fee AS INTEGER)         AS fee,
  CAST(tickSpacing AS INTEGER) AS tick_spacing,
  block_number                 AS created_block,
  block_timestamp              AS created_at
FROM factory__pool_created;
