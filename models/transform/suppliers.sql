{{
    config(
        materialized = 'table'
    )
}}
WITH SUPPLIERS AS (

    SELECT
        *
    FROM {{ ref('stage_suppliers') }}

)

SELECT
    S.SUPPLIER_KEY,
    S.SUPPLIER_NAME,
    S.SUPPLIER_ADDRESS,
    S.NATION_KEY,
    S.PHONE_NUMBER,
    S.ACCOUNT_BALANCE
FROM
    SUPPLIERS AS S
ORDER BY
    S.SUPPLIER_KEY
