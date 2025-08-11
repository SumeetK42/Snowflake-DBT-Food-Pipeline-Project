{{ 
    config(materialized = 'table')
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
 {{ handle_column_date('CREATEDDATE') }} as CREATE_DATE,
 'admin' as create_user,
 {{ handle_column_date('MODIFIEDDATE') }} as CHANGE_DATE,
 'admin' as change_user
from {{ source('STAGE','MENU') }}