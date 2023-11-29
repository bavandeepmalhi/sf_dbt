{{
    config(
        materialized = 'table'
    )
}}
WITH ORDER_ITEMS AS (

    SELECT * FROM {{ ref('order_items') }}

),

PART_SUPPLIERS AS (

    SELECT * FROM {{ ref('part_suppliers') }}

),

FINAL AS (
    SELECT

        O.ORDER_ITEM_KEY,
        O.ORDER_KEY,
        O.ORDER_DATE,
        O.CUSTOMER_KEY,
        O.ORDER_STATUS_CODE,

        O.PART_KEY,
        O.SUPPLIER_KEY,
        O.LINE_NUMBER AS ORDER_LINE_NUMBER,
        O.LINE_STATUS_CODE AS ORDER_LINE_STATUS_CODE,
        O.SHIP_DATE,
        O.COMMIT_DATE,
        O.RECEIPT_DATE,
        O.SHIP_MODE_NAME,
        PS.SUPPLIER_COST,
        PS.RETAIL_PRICE,
        O.BASE_PRICE,
        O.DISCOUNT_PERCENTAGE,
        O.DISCOUNTED_PRICE,
        O.TAX_RATE,

        1 AS ORDER_ITEM_COUNT,
        O.QUANTITY,

        O.GROSS_ITEM_SALES_AMOUNT,
        O.DISCOUNTED_ITEM_SALES_AMOUNT,
        O.ITEM_DISCOUNT_AMOUNT,
        O.ITEM_TAX_AMOUNT,
        O.NET_ITEM_SALES_AMOUNT

    FROM
        ORDER_ITEMS AS O
    INNER JOIN
        PART_SUPPLIERS AS PS
        ON
            O.PART_KEY = PS.PART_KEY AND
            O.SUPPLIER_KEY = PS.SUPPLIER_KEY
)

SELECT
    F.*,
    {{ dbt_housekeeping() }}
FROM
    FINAL AS F
ORDER BY
    F.ORDER_DATE
