WITH SOURCE AS (

    SELECT
        *
    FROM {{ source('tpch', 'partsupp') }}

),

RENAMED AS (

    SELECT

        ('ps_partkey' || 'ps_suppkey') AS PART_SUPPLIER_KEY,
        PS_PARTKEY AS PART_KEY,
        PS_SUPPKEY AS SUPPLIER_KEY,
        PS_AVAILQTY AS SUPPLIER_AVAILABLE_QUANTITY,
        PS_SUPPLYCOST AS SUPPLIER_COST,
        PS_COMMENT AS COMMENT

    FROM SOURCE

)

SELECT * FROM RENAMED
