SELECT
    TSH.*,
    FX_GBP.VALUE * OPEN AS GBP_OPEN,
    FX_GBP.VALUE * HIGH AS GBP_HIGH,
    FX_GBP.VALUE * LOW AS GBP_LOW,
    FX_GBP.VALUE * CLOSE AS GBP_CLOSE,
    FX_EUR.VALUE * OPEN AS EUR_OPEN,
    FX_EUR.VALUE * HIGH AS EUR_HIGH,
    FX_EUR.VALUE * LOW AS EUR_LOW,
    FX_EUR.VALUE * CLOSE AS EUR_CLOSE
FROM {{ref('tfm_stock_history')}} AS TSH,
    {{ref('tfm_fx_rates')}} AS FX_GBP,
    {{ref('tfm_fx_rates')}} AS FX_EUR
WHERE
    FX_GBP.CURRENCY = 'USD/GBP'
    AND FX_EUR.CURRENCY = 'USD/EUR'
    AND TSH.DATE = FX_GBP.DATE
    AND TSH.DATE = FX_EUR.DATE