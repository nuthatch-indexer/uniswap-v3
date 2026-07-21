-- Parity vs the canonical Uniswap V3 Arbitrum subgraph — windowed swap volume in raw base units.
-- The subgraph stores CUMULATIVE volume, so the window (485,280,000, 485,300,000] is its diff:
--   volumeToken0 Δ = 50921331.029602776 - 50920948.711671210 = 382.317931566 WETH
--   volumeToken1 Δ = 145314353834.433782 - 145313642373.286046 = 711461.147736 USDC
-- Raw base units below are exact: /1e18 = WETH, /1e6 = USDC. 633 swaps (subgraph txCount Δ 684 =
-- 633 swaps + ~51 mint/burn/collect). Pool: WETH/USDC 0.05%.
SELECT
  count(*)               AS swaps,
  sum(abs(amount0_dec))  AS weth_base_units,   -- /1e18 = 382.317931565321634085 WETH
  sum(abs(amount1_dec))  AS usdc_base_units    -- /1e6  = 711461.147736 USDC
FROM "pool__swap"
WHERE address = '0xc6962004f452be9203591991d15f6b388e09e8d0'
  AND block_number > 485280000 AND block_number <= 485300000;
