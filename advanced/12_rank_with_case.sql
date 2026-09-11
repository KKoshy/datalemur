WITH MeasurementInfo AS (
    SELECT
        measurement_id,
        ROW_NUMBER() OVER (
            PARTITION BY measurement_time::DATE
            ORDER BY measurement_time
        ) AS row_number,
        measurement_value,
        measurement_time
    FROM measurements
),

NewData AS (
    SELECT
        measurement_id,
        CASE
            WHEN row_number % 2 = 0 THEN 'even'
            ELSE 'odd'
        END AS category,
        measurement_value,
        measurement_time::DATE AS measurement_day
    FROM MeasurementInfo
)

SELECT measurement_day,
       SUM(CASE
            WHEN category='odd' THEN measurement_value
            ELSE 0
           END) AS odd_sum,
       SUM(CASE
            WHEN category='even' THEN measurement_value
            ELSE 0
           END) AS even_sum
FROM NewData
GROUP BY measurement_day
ORDER BY measurement_day;
