{{ 
    config(materialized = 'table')
}}

select * from {{ ref('menu') }}