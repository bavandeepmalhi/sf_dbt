/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

WITH SOURCE_DATA AS (

    SELECT 1 AS ID
    UNION ALL
    SELECT NULL AS ID

)

SELECT *
FROM SOURCE_DATA

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
