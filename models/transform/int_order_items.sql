WITH ORDERS AS (

    SELECT
        *
    FROM {{ ref('stage_orders') }}

),

LINE_ITEMS AS (

    SELECT
        *
    FROM {{ ref('stage_line_item') }}

)

SELECT

    (O.ORDER_KEY || '-' || L.LINE_NUMBER) AS ORDER_ITEM_KEY,

    O.ORDER_KEY,
    O.ORDER_DATE,
    O.CUSTOMER_KEY,
    O.ORDER_STATUS_CODE,

    L.PART_KEY,
    L.SUPPLIER_KEY,
    L.RETURN_FLAG,
    L.LINE_NUMBER,
    L.LINE_STATUS_CODE,
    L.SHIP_DATE,
    L.COMMIT_DATE,
    L.RECEIPT_DATE,
    L.SHIP_MODE_NAME,
    L.QUANTITY,

    -- extended_price is actually the line item total,
    -- so we back out the extended price per item
    L.EXTENDED_PRICE / NULLIF(L.QUANTITY, 0) AS INT_BASE_PRICE,
    L.DISCOUNT_PERCENTAGE,
    (L.EXTENDED_PRICE / NULLIF(L.QUANTITY, 0)) * (1 - L.DISCOUNT_PERCENTAGE) AS INT_DISCOUNTED_PRICE,

    L.EXTENDED_PRICE AS GROSS_ITEM_SALES_AMOUNT,
    L.EXTENDED_PRICE * (1 - L.DISCOUNT_PERCENTAGE) AS INT_DISCOUNTED_ITEM_SALES_AMOUNT,
    -- We model discounts as negative amounts
    (-1 * L.EXTENDED_PRICE * L.DISCOUNT_PERCENTAGE) AS INT_ITEM_DISCOUNT_AMOUNT,
    L.TAX_RATE,
    ((GROSS_ITEM_SALES_AMOUNT + INT_ITEM_DISCOUNT_AMOUNT) * L.TAX_RATE) AS INT_ITEM_TAX_AMOUNT,
    (
        GROSS_ITEM_SALES_AMOUNT +
        INT_ITEM_DISCOUNT_AMOUNT +
        INT_ITEM_TAX_AMOUNT
    ) AS INT_NET_ITEM_SALES_AMOUNT

FROM
    ORDERS AS O
INNER JOIN
    LINE_ITEMS AS L
    ON O.ORDER_KEY = L.ORDER_KEY
ORDER BY
    O.ORDER_DATE
