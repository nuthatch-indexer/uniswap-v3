-- Every token that appears in any pool, with how many pools reference it — the token universe this
-- nest touches, ranked by pool count (a proxy for how central a token is: WETH, USDC, and friends
-- sit at the top). Token metadata (symbol, decimals) needs a contract call and is intentionally not
-- indexed by the declarative core; join a vendored token list for human labels.
CREATE VIEW tokens AS
SELECT token, count(*) AS pools
FROM (
  SELECT token0 AS token FROM pools
  UNION ALL
  SELECT token1 AS token FROM pools
)
GROUP BY token
ORDER BY pools DESC, token;
