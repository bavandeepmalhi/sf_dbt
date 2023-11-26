SELECT
    COMPANY_TICKER, COMPANY_NAME, STOCK_EXCHANGE_NAME, DATE, DATA_SOURCE_NAME,
  {{ dbt_utils.pivot(
      column = 'indicator_name',
      values = dbt_utils.get_column_values(ref('base_knoema_stock_history'), 'indicator_name'),
      then_value = 'value'
  ) }}
FROM {{ ref('base_knoema_stock_history') }}
GROUP BY COMPANY_TICKER, COMPANY_NAME, STOCK_EXCHANGE_NAME, DATE, DATA_SOURCE_NAME
