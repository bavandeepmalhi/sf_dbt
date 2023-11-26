{{ 
config(
	  materialized='table'
	  , tags=["Reference Data"]
	  ) 
}}
SELECT SRC.*
FROM {{ref('base_knoema_fx_rates')}} AS SRC
WHERE
    SRC."Indicator Name" = 'Close'
    AND SRC."Frequency" = 'D'
    AND SRC."Date" > '2016-01-01'
