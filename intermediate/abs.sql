SELECT ticker, COUNT(ticker)
FROM stock_prices
WHERE ABS(((close - open)/open) * 100) > 10
GROUP BY ticker
ORDER BY count DESC;
