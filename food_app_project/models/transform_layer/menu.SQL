{{ 
    config(
        materialized = 'table',
        post_hook=[
            "{{ 
            add_table_pk_constraint(this, 'MENU_ID') 
            }}",
            "{{ 
            add_table_fk_constraint(this, 'RESTAURANT_ID',ref('restaurant'),'RESTAURANT_ID') 
            }}"
        ]
        )
}}

select 
MENUID AS MENU_ID,
RESTAURANTID AS RESTAURANT_ID,
 {{ handle_null_val('ITEMNAME') }} as MENU_ITEM_NAME,
 {{ handle_null_val('DESCRIPTION') }} AS DESCRIPTION,
to_number(PRICE) as PRICE,
{{ handle_null_val('CATEGORY') }} as CATEGORY,
case 
when upper(trim(AVAILABILITY)) = 'TRUE' then TRUE
ELSE FALSE
end as is_available_now,
 cast  ( {{ handle_column_date('CREATEDDATE') }} as timestamp_ntz ) as CREATE_DATE,
 'admin' as create_user,
 cast ( {{ handle_column_date('MODIFIEDDATE') }} as timestamp_ntz) as CHANGE_DATE,
 'admin' as change_user
from {{ source('STAGE','MENU') }}