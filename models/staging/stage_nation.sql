SELECT
    *
FROM {{ source('tpch','nation') }}
