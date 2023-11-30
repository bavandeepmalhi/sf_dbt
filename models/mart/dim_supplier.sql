{{ config(
  materialized='table'
) }}

WITH SUPPLIERS AS (

    SELECT * FROM {{ ref('suppliers') }}

),

NATIONS AS (

    SELECT * FROM {{ ref('nations') }}
),

REGIONS AS (

    SELECT * FROM {{ ref('regions') }}

),

FINAL AS (

    SELECT
        S.SUPPLIER_KEY,
        S.SUPPLIER_NAME,
        S.SUPPLIER_ADDRESS,
        N.NATION_KEY AS SUPPLIER_NATION_KEY,
        N.NATION_NAME AS SUPPLIER_NATION_NAME,
        R.REGION_KEY AS SUPPLIER_REGION_KEY,
        R.REGION_NAME AS SUPPLIER_REGION_NAME,
        S.SUPPLIER_PHONE_NUMBER,
        S.SUPPLIER_ACCOUNT_BALANCE
    FROM
        SUPPLIERS AS S
    INNER JOIN
        NATIONS AS N
        ON S.NATION_KEY = N.NATION_KEY
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
    F.SUPPLIER_KEY
