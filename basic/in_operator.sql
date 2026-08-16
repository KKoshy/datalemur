-- The IN operator allows us to specify multiple values in a single line's WHERE clause, 
-- instead of the more tedious approach of having to use multiple OR conditions to filter for multiple values.

SELECT manufacturer, drug, units_sold 
FROM pharmacy_sales
WHERE units_sold NOT BETWEEN 55000 AND 550000
AND manufacturer IN ('Roche', 'Bayer', 'AstraZeneca');
