{{ config(materialized='view') }}


--Calling macros
SELECT
    *
    ,{{salary_int_to_char_visualization('salary')}}
FROM
    {{ ref('stg_psql_employees') }} e