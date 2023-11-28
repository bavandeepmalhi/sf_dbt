{{
    config(
        materialized = 'table'
    )
}}

WITH CUSTOMERS AS (

    SELECT
        *
    FROM {{ ref('stage_customer') }}

)

SELECT
    C.CUSTOMER_KEY,
    C.NAME,
    C.ADDRESS,
    C.NATION_KEY,
    C.PHONE_NUMBER,
    C.ACCOUNT_BALANCE,
    C.MARKET_SEGMENT
FROM
    CUSTOMERS AS C
ORDER BY
    C.CUSTOMER_KEY
