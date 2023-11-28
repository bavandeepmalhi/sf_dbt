{{
    config(materialized='table')
}}

WITH SOURCE AS (

    SELECT
        *
    FROM {{ source('tpch', 'customer') }}

),

RENAMED AS (

    SELECT

        C_CUSTKEY AS CUSTOMER_KEY,
        C_NAME AS NAME,
        C_ADDRESS AS ADDRESS,
        C_NATIONKEY AS NATION_KEY,
        C_PHONE AS PHONE_NUMBER,
        C_ACCTBAL AS ACCOUNT_BALANCE,
        C_MKTSEGMENT AS MARKET_SEGMENT,
        C_COMMENT AS COMMENT

    FROM SOURCE

)

SELECT * FROM RENAMED
