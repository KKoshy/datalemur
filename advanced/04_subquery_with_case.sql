-- The over-complicated version,

-- WITH reference AS (
--   SELECT order_id AS ref_id,
--          item AS ref_item
--   FROM orders
-- )


-- SELECT order_id,
--        item,
--        CASE 
--         WHEN order_id%2=1 AND order_id=(
--           SELECT MAX(ref_id)
--           FROM reference
--         )
--         THEN item
--         WHEN order_id%2=1 THEN (
--           SELECT ref_item
--           FROM reference
--           WHERE ref_id=order_id+1
--         )
--         WHEN order_id%2=0 THEN (
--           SELECT ref_item
--           FROM reference
--           WHERE ref_id=order_id-1
--         )
--        END AS item
-- FROM orders;

-- The above version corrects the item (why?), when we could just correct the order_id
-- Simplified version be like (with cross join)

WITH order_data AS (
  SELECT max(order_id) AS max_id
  FROM orders
)

SELECT
       order_id,
       CASE 
        WHEN order_id%2=1 AND order_id=max_id THEN order_id
        WHEN order_id%2=1 THEN order_id+1
        ELSE order_id-1
       END AS corrected_order_id,
       item
FROM orders
CROSS JOIN order_data
ORDER BY corrected_order_id;
