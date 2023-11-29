{{
    config(
        materialized = 'table'
    )
}}
WITH CUSTOMERS AS (

    SELECT * FROM {{ ref('customers') }}

),

NATIONS AS (

    SELECT * FROM {{ ref('nations') }}
),

REGIONS AS (

    SELECT * FROM {{ ref('regions') }}

),

FINAL AS (
    SELECT
        C.CUSTOMER_KEY,
        C.CUSTOMER_NAME,
        C.CUSTOMER_ADDRESS,
        N.NATION_KEY AS CUSTOMER_NATION_KEY,
        N.NATION_NAME AS CUSTOMER_NATION_NAME,
        R.REGION_KEY AS CUSTOMER_REGION_KEY,
        R.REGION_NAME AS CUSTOMER_REGION_NAME,
        C.CUSTOMER_PHONE_NUMBER,
        C.CUSTOMER_ACCOUNT_BALANCE,
        C.CUSTOMER_MARKET_SEGMENT_NAME
    FROM
        CUSTOMERS AS C
    INNER JOIN
        NATIONS AS N
        ON C.NATION_KEY = N.NATION_KEY
    INNER JOIN
        REGIONS AS R
        ON N.REGION_KEY = R.REGION_KEY
)

SELECT
    F.*,
    {{ dbt_housekeeping() }}
FROM
    FINAL AS F
ORDER BY
    F.CUSTOMER_KEY
