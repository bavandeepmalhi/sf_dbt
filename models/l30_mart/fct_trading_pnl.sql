{{ 
config(
	  materialized='incremental'
	  , tags=["Fact Data"]
	  ) 
}}
SELECT SRC.*
FROM {{ref('tfm_trading_pnl')}} AS SRC

{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    WHERE (SRC.TRADER, SRC.INSTRUMENT, SRC.DATE, SRC.STOCK_EXCHANGE_NAME) NOT IN (SELECT TRADER, INSTRUMENT, DATE, STOCK_EXCHANGE_NAME FROM {{ this }})

{% endif %}
