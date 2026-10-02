SELECT ic_order_products_curr.product_id,
       ic_products.product_name,
       ic_products.aisle_id,
       ic_products.department_id,
       ic_departments.department,
       ic_aisles.aisle,
       SUM(ic_order_products_prior.reordered) AS prior_reorders,
       SUM(ic_order_products_curr.reordered) AS current_reorders
      -- SUM(ic_order_products_curr.reordered) - SUM(ic_order_products_prior.reordered) AS progress
FROM ic_order_products_curr
JOIN ic_order_products_prior
ON ic_order_products_curr.product_id=ic_order_products_prior.product_id
JOIN ic_products
ON ic_order_products_curr.product_id=ic_products.product_id
JOIN ic_departments
ON ic_products.department_id=ic_departments.department_id
JOIN ic_aisles
ON ic_products.aisle_id=ic_aisles.aisle_id
GROUP BY ic_order_products_curr.product_id,
         ic_products.product_name,
         ic_products.aisle_id,
         ic_products.department_id,
         ic_departments.department,
         ic_aisles.aisle
HAVING SUM(ic_order_products_prior.reordered)<10 AND SUM(ic_order_products_curr.reordered) > 10
ORDER BY 8 DESC, 7, 1 DESC;
