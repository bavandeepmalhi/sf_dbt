{{
    config(
        materialized = 'table'
    )
}}
WITH REGIONS AS (

    SELECT
        *
    FROM {{ ref('stage_region') }}

)

SELECT
    R.REGION_KEY,
    R.REGION_NAME
FROM
    REGIONS AS R
ORDER BY
    R.REGION_KEY
