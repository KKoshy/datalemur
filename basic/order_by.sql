-- ORDER BY Numbers, Not Column Names
-- Pro tip: you can substitute numbers for column names in the ORDER BY clause. 
-- The numbers correspond to the columns you specify in the SELECT clause.

-- For example, the query below is exactly the same as the previous two-column sort SQL query example:

-- SELECT policy_holder_id, call_category, call_received 
-- FROM callers
-- ORDER BY 1,3 DESC;
-- 1 maps to the column policy_holder_id because it's 1st in the SELECT statement, 
-- and 3 represents call_received because it's the 3rd column named in the SELECT query.


SELECT drug, 
  total_sales - cogs AS total_profit
FROM pharmacy_sales
ORDER BY 2 DESC
LIMIT 3;
