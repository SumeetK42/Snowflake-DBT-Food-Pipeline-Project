{{ 
    config(
        materialized = 'table',
        post_hook=[
            "{{ 
            add_table_pk_constraint(this, 'DELIVERY_ID') 
            }}"
        ]
        )
}}

select
DELIVERYID as DELIVERY_ID,
ORDERID AS ORDER_ID,
DELIVERYAGENTID AS DELIVERYAGENT_ID,
UPPER({{ handle_null_val('DELIVERYSTATUS') }}) AS DELIVERY_STATUS,
ABS(TO_NUMBER((SPLIT_PART(UPPER(TRIM(ESTIMATEDTIME)),'MINUTES',1)))) AS ESTIMATED_TIME_MINUTES,
DELIVERYADDRESS AS DELIVERY_ADDRESS_ID ,
{{  handle_column_date ('DELIVERYDATE') }} as DELIVERY_DATE,
{{  handle_column_date ('CREATEDDATE') }} as CREATE_DATE,
'admin' as create_user,
{{  handle_column_date ('MODIFIEDDATE') }} as CHANGE_DATE,
'admin' as change_user
from {{ source('STAGE','DELIVERY') }}
