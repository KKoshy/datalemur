SELECT * 
FROM trades
JOIN users
ON trades.user_id=users.user_id;
