-- Recent Revenue Trends (Last 10 Years)

-- Question: How has our total revenue changed in recent years?
-- This shows if we're growing or declining and helps forecast future revenue

SELECT 
  -- Get just the year from the date
  EXTRACT(YEAR FROM `Production Date`) AS year,
  
  -- Total revenue for that year (Oil + Gas combined)
  -- Oil: $50 per barrel
  -- Gas: $3 per thousand cubic feet
  SUM(
    CASE 
      WHEN Commodity = 'Oil (bbl)' THEN Volume * 50
      WHEN Commodity = 'Gas (Mcf)' THEN Volume * 3
    END
  ) AS annual_revenue,
  
  -- Number of transactions that year
  COUNT(*) AS transactions

FROM `us-oil-gas.oil_gas_production.production_data`

WHERE Volume > 0
  AND Commodity IN ('Oil (bbl)', 'Gas (Mcf)')
  AND EXTRACT(YEAR FROM `Production Date`) >= 2015  -- Last 10 years 

GROUP BY year
ORDER BY year DESC;
