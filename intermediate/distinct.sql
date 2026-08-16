-- The DISTINCT SQL command is used in conjunction with the SELECT statement to return only distinct (different) values. 

SELECT category, COUNT(DISTINCT product) 
FROM product_spend
GROUP BY category;
