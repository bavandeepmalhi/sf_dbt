{{
    config(
        materialized = 'table'
    )
}}
WITH ORDERS AS (

    SELECT
        *
    FROM {{ ref('stage_orders') }}

)

SELECT
    O.ORDER_KEY,
    O.ORDER_DATE,
    O.CUSTOMER_KEY,
    O.ORDER_STATUS_CODE,
    O.ORDER_PRIORITY_CODE,
    O.ORDER_CLERK_NAME,
    O.ORDER_SHIPPING_PRIORITY
FROM
    ORDERS AS O
ORDER BY
    O.ORDER_DATE
