-- The DISTINCT SQL command is used in conjunction with the SELECT statement to return only distinct (different) values.

-- DISTINCT With Two Columns
-- If you include two (or more) columns in a SELECT DISTINCT clause, your results will contain all of the unique pairs 
-- of those two columns.

-- For example, imagine you worked at stock trading app Robinhood and had access to their trades dataset. 
-- Here's a SQL query that uses DISTINCT on two columns – user_id's and trade statuses:

-- SELECT DISTINCT user_id, status
-- FROM trades
-- ORDER BY user_id;
-- Note: You only need to include DISTINCT once in your SELECT clause—you do not need to add it for each column name.

SELECT category, COUNT(DISTINCT product) 
FROM product_spend
GROUP BY category;
