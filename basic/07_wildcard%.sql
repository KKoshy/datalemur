-- Example in Query	Definition
-- WHERE first_name LIKE 'a%'	Finds any values that starts with "a"
-- WHERE first_name LIKE '%a'	Finds any values that ends with "a"
-- WHERE first_name LIKE '%ae%'	Finds any values that have "ae" in the middle
-- WHERE first_name LIKE '_b%'	Finds any values with "b" in the second position
-- WHERE first_name LIKE 'a%o'	Finds any values that starts with "a" and ends with "o"
-- WHERE first_name LIKE 'a___'	Finds any value that starts with "a" and has 3 characters

SELECT * 
FROM customers
WHERE customer_name LIKE 'F%ck';
