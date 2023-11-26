SELECT
    "Company" AS COMPANY,
    "Company Name" AS COMPANY_NAME,
    "Company Ticker" AS COMPANY_TICKER,
    "Stock Exchange" AS STOCK_EXCHANGE,
    "Stock Exchange Name" AS STOCK_EXCHANGE_NAME,
    "Indicator" AS INDICATOR,
    "Indicator Name" AS INDICATOR_NAME,
    "Units" AS UNITS,
    "Scale" AS SCALE,
    "Frequency" AS FREQUENCY,
    "Date" AS DATE,
    "Value" AS VALUE,
    'Knoema.Stock History' AS DATA_SOURCE_NAME
FROM {{source('economy_data_atlas','usindssp2020')}}
