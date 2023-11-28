{{
    config(
        materialized='table',
        cluster_by=['order_date']
    )
}}

WITH SOURCE AS (

    SELECT
        *
    FROM {{ source('tpch', 'orders') }}

),

RENAMED AS (

    SELECT

        O_ORDERKEY AS ORDER_KEY,
        O_CUSTKEY AS CUSTOMER_KEY,
        O_ORDERSTATUS AS ORDER_STATUS_CODE,
        O_TOTALPRICE AS ORDER_TOTAL_PRICE,
        O_ORDERDATE AS ORDER_DATE,
        O_ORDERPRIORITY AS ORDER_PRIORITY_CODE,
        O_CLERK AS ORDER_CLERK_NAME,
        O_SHIPPRIORITY AS ORDER_SHIPPING_PRIORITY,
        O_COMMENT AS ORDER_COMMENT

    FROM SOURCE

)

SELECT * FROM RENAMED
