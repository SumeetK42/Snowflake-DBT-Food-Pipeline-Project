{{ 
    config(materialized = 'table')
}}

select * from {{ ref('delivery_agent') }}