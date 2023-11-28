{{
    config(
        materialized = 'table'
    )
}}
WITH NATIONS AS (

    SELECT
        *
    FROM {{ ref('stage_nation') }}

)

SELECT
    N.NATION_KEY,
    N.NATION_NAME,
    N.REGION_KEY
FROM
    NATIONS AS N
ORDER BY
    N.NATION_KEY
