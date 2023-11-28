WITH SOURCE AS (

    SELECT
        *
    FROM {{ source('tpch', 'region') }}

),

RENAMED AS (

    SELECT

        R_REGIONKEY AS REGION_KEY,
        R_NAME AS REGION_NAME,
        R_COMMENT AS COMMENT

    FROM SOURCE

)

SELECT * FROM RENAMED
