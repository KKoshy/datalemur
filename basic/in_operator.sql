SELECT manufacturer, drug, units_sold 
FROM pharmacy_sales
WHERE units_sold NOT BETWEEN 55000 AND 550000
AND manufacturer IN ('Roche', 'Bayer', 'AstraZeneca');
