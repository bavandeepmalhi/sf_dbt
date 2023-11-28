{{
    config(
        materialized = 'table'
    )
}}

SELECT

    I.ORDER_ITEM_KEY,
    I.ORDER_KEY,
    I.ORDER_DATE,
    I.CUSTOMER_KEY,
    I.ORDER_STATUS_CODE,
    I.PART_KEY,
    I.SUPPLIER_KEY,
    I.RETURN_FLAG,
    I.LINE_NUMBER,
    I.LINE_STATUS_CODE,
    I.SHIP_DATE,
    I.COMMIT_DATE,
    I.RECEIPT_DATE,
    I.SHIP_MODE_NAME,
    I.QUANTITY,

    {{ money('i.int_base_price') }} AS BASE_PRICE,

    I.DISCOUNT_PERCENTAGE,

    {{ money('i.int_discounted_price') }} AS DISCOUNTED_PRICE,

    I.GROSS_ITEM_SALES_AMOUNT,

    {{ money('i.int_discounted_item_sales_amount') }} AS DISCOUNTED_ITEM_SALES_AMOUNT,
    {{ money('i.int_item_discount_amount') }} AS ITEM_DISCOUNT_AMOUNT,

    I.TAX_RATE,

    {{ money('i.int_item_tax_amount') }} AS ITEM_TAX_AMOUNT,
    {{ money('i.int_net_item_sales_amount') }} AS NET_ITEM_SALES_AMOUNT

FROM
    {{ ref('int_order_items') }} AS I
