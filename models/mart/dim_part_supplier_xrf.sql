{{
    config(
        materialized = 'table'
    )
}}
WITH SUPPLIERS AS (

    SELECT * FROM {{ ref('suppliers') }}

),

PARTS AS (

    SELECT * FROM {{ ref('parts') }}

),

PART_SUPPLIERS AS (

    SELECT * FROM {{ ref('part_suppliers') }}

),

NATIONS AS (

    SELECT * FROM {{ ref('nations') }}
),

REGIONS AS (

    SELECT * FROM {{ ref('regions') }}

),

FINAL AS (

    SELECT
        PS.PART_SUPPLIER_KEY,

        P.PART_KEY,
        P.PART_NAME,
        P.PART_MANUFACTURER_NAME,
        P.PART_BRAND_NAME,
        P.PART_TYPE_NAME,
        P.PART_SIZE,
        P.PART_CONTAINER_DESC,
        P.RETAIL_PRICE,

        S.SUPPLIER_KEY,
        S.SUPPLIER_NAME,
        SUPPLIER_ADDRESS,
        S.SUPPLIER_PHONE_NUMBER,
        S.SUPPLIER_ACCOUNT_BALANCE,
        N.NATION_KEY AS SUPPLIER_NATION_KEY,
        N.NATION_NAME AS SUPPLIER_NATION_NAME,
        R.REGION_KEY AS SUPPLIER_REGION_KEY,
        R.REGION_NAME AS SUPPLIER_REGION_NAME,

        PS.SUPPLIER_AVAILABLE_QUANTITY,
        PS.SUPPLIER_COST
    FROM
        PARTS AS P
    INNER JOIN
        PART_SUPPLIERS AS PS
        ON P.PART_KEY = PS.PART_KEY
    INNER JOIN
        SUPPLIERS AS S
        ON PS.SUPPLIER_KEY = S.SUPPLIER_KEY
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
    F.PART_KEY,
    F.SUPPLIER_KEY
