-- One-row network summary over the derived views: how many pools this nest tracks, how many distinct
-- tokens they span, and the total swap / mint / burn activity in the indexed range. The header-panel
-- numbers — every one of them from a single factory rule and a handful of SQL views, no per-pool code.
CREATE VIEW global AS
SELECT
  (SELECT count(*) FROM pools)              AS pools,
  (SELECT count(*) FROM tokens)             AS tokens,
  (SELECT count(*) FROM pool__swap)         AS swaps,
  (SELECT count(*) FROM pool__mint)         AS mints,
  (SELECT count(*) FROM pool__burn)         AS burns,
  (SELECT count(*) FROM pool_stats WHERE swaps > 0) AS pools_with_swaps;
