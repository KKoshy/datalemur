-- Amazon - Hard level problem
WITH sq_ft_data AS (
  SELECT item_type,
         SUM(square_footage) AS total_sqft,
         COUNT(item_category) AS item_count
  FROM inventory
  GROUP BY item_type
),

prime_summary AS (
  SELECT item_type, 
         total_sqft,
         FLOOR(500000/total_sqft) AS batch_count,
        (FLOOR(500000/total_sqft)*item_count) AS item_count
  FROM sq_ft_data WHERE item_type='prime_eligible'
),

non_prime_summary AS (
  SELECT
    s.item_type,
    FLOOR((500000-(batch_count*p.total_sqft))/s.total_sqft)*s.item_count AS item_count
  FROM prime_summary AS p
  CROSS JOIN sq_ft_data AS s
  WHERE s.item_type='not_prime'
)

SELECT item_type, item_count FROM prime_summary
UNION ALL
SELECT item_type, item_count from non_prime_summary;
