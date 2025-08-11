{{ 
    config(materialized = 'table')
}}

select * from {{ ref('cust_login_detail') }}