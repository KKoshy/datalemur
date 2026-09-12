WITH SpendData AS (
  SELECT product_id,
        spend AS curr_year_spend,
        EXTRACT(YEAR FROM transaction_date) AS year,
        LAG(spend) OVER (PARTITION BY product_id ORDER BY EXTRACT(YEAR FROM transaction_date)) AS prev_year_spend 
  FROM user_transactions
  ORDER BY 1, 3
)

SELECT year,
      product_id,
      curr_year_spend,
      prev_year_spend,
      ROUND(((curr_year_spend - prev_year_spend)/prev_year_spend) * 100, 2) AS yoy_rate
FROM SpendData;
