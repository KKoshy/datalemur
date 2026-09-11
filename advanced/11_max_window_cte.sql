WITH TransactionInfo AS (
  SELECT user_id, 
         transaction_date, 
         COUNT(product_id) AS product_count,
         MAX(transaction_date) OVER (PARTITION BY user_id) AS last_seen
  FROM user_transactions
  GROUP BY user_id, transaction_date
)


SELECT transaction_date,
       user_id,
       product_count
FROM TransactionInfo
WHERE transaction_date=last_seen
ORDER BY transaction_date;
