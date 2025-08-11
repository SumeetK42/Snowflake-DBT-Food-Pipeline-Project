{{ 
    config(materialized = 'table')
}}

select 
ORDERITEMID as ORDER_ITEM_ID,
ORDERID as ORDER_ID,
MENUID as MENU_ID,
to_number(QUANTITY) as QUANTITY,
to_number(PRICE) as PRICE,
case 
  when to_number(SUBTOTAL) <>  to_number(QUANTITY) * to_number(PRICE) then to_number(QUANTITY) * to_number(PRICE)
  else to_number(SUBTOTAL)
end as SUBTOTAL ,
CREATEDDATE as CREATE_DATE,
'admin' as create_user,
MODIFIEDDATE AS CHANGE_DATE,
'admin' as change_user
from {{ source('STAGE','ORDER_ITEMS') }}