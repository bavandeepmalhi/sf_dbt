{{
    config(
        materialized = 'table'
    )
}}
WITH PARTS AS (

    SELECT
        *
    FROM {{ ref('parts') }}

),

SUPPLIERS AS (

    SELECT
        *
    FROM {{ ref('suppliers') }}

),

PART_SUPPLIERS AS (

    SELECT
        *
    FROM {{ ref('stage_part_suppliers') }}

)

SELECT

    (P.PART_KEY || '-' || S.SUPPLIER_KEY) AS PART_SUPPLIER_KEY,

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
    S.NATION_KEY,

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
ORDER BY
    P.PART_KEY
