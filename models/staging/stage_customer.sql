SELECT
    *
FROM {{ source('tpch','customer') }}
