-- Assertion model to check row counts
WITH
  stage_order_row_count AS (
    SELECT COUNT(*) AS row_count
    FROM {{ ref('stage_orders') }}
  ),
  transform_orders_row_count AS (
    SELECT COUNT(*) AS row_count
    FROM {{ ref('orders') }}
  )
SELECT
  *
FROM stage_order_row_count sorc
  join transform_orders_row_count torc
  where sorc.row_count != torc.row_count