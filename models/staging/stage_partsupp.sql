SELECT
    *
FROM {{ source('tpch','partsupp') }}
