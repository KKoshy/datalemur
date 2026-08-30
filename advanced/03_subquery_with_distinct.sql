-- SELECT customer_id
-- FROM customer_contracts 
-- LEFT JOIN products
-- ON customer_contracts.product_id=products.product_id
-- GROUP BY customer_id
-- HAVING COUNT(DISTINCT product_category)=3;

--- here the count 3 is hardcoded, so using sub-query to avoid that.

SELECT customer_id
FROM customer_contracts 
LEFT JOIN products
ON customer_contracts.product_id=products.product_id
GROUP BY customer_id
HAVING COUNT(DISTINCT product_category)= (
  SELECT COUNT(DISTINCT product_category) FROM products
);
