WITH MeasurementInfo AS (
    SELECT
        measurement_id,
        ROW_NUMBER() OVER (
            PARTITION BY measurement_time::DATE
            ORDER BY measurement_time
        ) AS row_number,
        measurement_value,
        measurement_time::DATE AS measurement_day
    FROM measurements
)

SELECT measurement_day,
       SUM(CASE
            WHEN row_number%2=1 THEN measurement_value
            ELSE 0
           END) AS odd_sum,
       SUM(CASE
            WHEN row_number%2=0 THEN measurement_value
            ELSE 0
           END) AS even_sum
FROM MeasurementInfo
GROUP BY measurement_day
ORDER BY measurement_day;
