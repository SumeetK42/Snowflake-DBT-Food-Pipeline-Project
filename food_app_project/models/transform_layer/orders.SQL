{{ 
    config(
        materialized = 'table',
        post_hook=[
            "{{ 
            add_table_pk_constraint(this, 'ORDER_ID') 
            }}",
            "{{ 
            add_table_fk_constraint(this, 'RESTAURANT_ID',ref('restaurant'),'RESTAURANT_ID') 
            }}",
            "{{ 
            add_table_fk_constraint(this, 'CUSTOMER_ID',ref('customer'),'CUSTOMER_ID') 
            }}"
        ]
        )
}}

select 
ORDERID as ORDER_ID,
CUSTOMERID  AS CUSTOMER_ID,
RESTAURANTID AS RESTAURANT_ID,
{{ handle_column_date('ORDERDATE') }} AS ORDER_DATE,
TO_NUMBER(TOTALAMOUNT) AS TOTAL_AMOUNT,
UPPER({{ handle_null_val('STATUS') }}) as  ORDER_STATUS,
UPPER({{ handle_null_val('PAYMENTMETHOD') }}) AS PAYMENT_METHOD,
{{ handle_column_date('CREATEDDATE') }} AS CREATE_DATE,
'admin' as create_user,
{{ handle_column_date('MODIFIEDDATE') }} AS CHANGE_DATE,
'admin' as change_user
from {{ source('STAGE','ORDERS') }}