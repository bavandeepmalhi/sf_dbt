SELECT
    *
FROM {{ source('tpch','supplier') }}
