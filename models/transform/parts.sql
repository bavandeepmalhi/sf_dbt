{{
    config(
        materialized = 'table'
    )
}}
WITH PARTS AS (

    SELECT
        *
    FROM {{ ref('stage_parts') }}

)

SELECT
    P.PART_KEY,
    P.PART_NAME,
    P.PART_MANUFACTURER_NAME,
    P.PART_BRAND_NAME,
    P.PART_TYPE_NAME,
    P.PART_SIZE,
    P.PART_CONTAINER_DESC,
    P.RETAIL_PRICE
FROM
    PARTS AS P
ORDER BY
    P.PART_KEY
