{{
    config(
        materialized = 'table'
    )
}}
WITH PARTS AS (

    SELECT * FROM {{ ref('parts') }}

),

FINAL AS (

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
)

SELECT
    F.*,
    {{ dbt_housekeeping() }}
FROM
    FINAL AS F
ORDER BY
    F.PART_KEY
