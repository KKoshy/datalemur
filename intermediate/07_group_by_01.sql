SELECT ticker, MIN(open)
FROM stock_prices
GROUP BY ticker
ORDER BY 2 DESC;
