SELECT *
FROM customers
WHERE LOWER(customer_name) LIKE '%son' AND gender='Male' AND age=20;
