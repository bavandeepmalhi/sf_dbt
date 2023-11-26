SELECT
    SRC."Currency" AS CURRENCY,
    SRC."Currency Unit" AS CURRENCY_UNIT,
    SRC."Frequency" AS FREQUENCY,
    SRC."Date" AS DATE,
    SRC."Value" AS VALUE,
    'Knoema.FX Rates' AS DATA_SOURCE_NAME,
    SRC.*
FROM {{source('economy_data_atlas','exratescc2018')}} 
AS SRC
