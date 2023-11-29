{{
    config(
        materialized = 'table'
    )
}}

/*
Per TPC-H Spec:
2.4.2 Minimum Cost Supplier Query (Q2)
*/

WITH PART_SUPPLIERS AS (

    SELECT
        S.SUPPLIER_ACCOUNT_BALANCE,
        S.SUPPLIER_NAME,
        S.SUPPLIER_NATION_KEY,
        S.SUPPLIER_REGION_KEY,
        S.SUPPLIER_NATION_NAME,
        S.SUPPLIER_REGION_NAME,
        S.PART_KEY,
        S.PART_MANUFACTURER_NAME,
        S.PART_SIZE,
        S.PART_TYPE_NAME,
        S.SUPPLIER_COST,
        S.SUPPLIER_ADDRESS,
        S.SUPPLIER_PHONE_NUMBER,
        RANK() OVER (PARTITION BY S.SUPPLIER_REGION_KEY, S.PART_KEY ORDER BY S.SUPPLIER_COST) AS SUPPLIER_COST_RANK,
        ROW_NUMBER() OVER (PARTITION BY S.SUPPLIER_REGION_KEY, S.PART_KEY, S.SUPPLIER_COST ORDER BY S.SUPPLIER_ACCOUNT_BALANCE DESC) AS SUPPLIER_RANK
    FROM
        {{ ref("dim_part_supplier_xrf") }} AS S
)

SELECT
    S.*
FROM
    PART_SUPPLIERS AS S
WHERE
    S.SUPPLIER_COST_RANK = 1 AND
    S.SUPPLIER_RANK <= 100
ORDER BY
    S.SUPPLIER_NAME, S.PART_KEY