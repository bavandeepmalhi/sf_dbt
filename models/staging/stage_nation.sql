WITH SOURCE AS (

    SELECT
        *
    FROM {{ source('tpch', 'nation') }}

),

RENAMED AS (

    SELECT

        N_NATIONKEY AS NATION_KEY,
        N_NAME AS NATION_NAME,
        N_REGIONKEY AS REGION_KEY,
        N_COMMENT AS COMMENT

    FROM SOURCE

)

SELECT * FROM RENAMED
