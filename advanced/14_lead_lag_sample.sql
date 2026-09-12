SELECT ticker,
       date,
       close,
       LEAD(close) OVER (ORDER BY date) - close AS consecutive_diff,
       close - LAG(close, 3) OVER (ORDER BY date) AS prior_3_diff
FROM stock_prices
WHERE ticker='GOOG';
