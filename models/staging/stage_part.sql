SELECT
    *
FROM {{ source('tpch','part') }}
