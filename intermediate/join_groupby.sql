SELECT city, COUNT(city) AS total_orders
FROM trades
LEFT JOIN users
ON trades.user_id = users.user_id
WHERE trades.status = 'Completed'
GROUP BY city
ORDER BY 2 DESC
LIMIT 3;
