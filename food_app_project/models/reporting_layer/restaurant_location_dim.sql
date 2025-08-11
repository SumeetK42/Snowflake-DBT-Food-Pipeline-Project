{{ 
    config(materialized = 'table')
}}

select * from {{ ref('restaurant') }}