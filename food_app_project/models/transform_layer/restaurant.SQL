{{ 
    config(
        materialized = 'table',
        post_hook=[
            "{{ 
            add_table_pk_constraint(this, 'RESTAURANT_ID') 
            }}"
        ]
        )
}}

select 
RESTAURANTID as RESTAURANT_ID,
 {{ handle_name('NAME') }} AS RESTAURANT_NAME,
SPLIT(CUISINETYPE,',') AS  CUISINE_TYPE,
NVL(PRICING_FOR_2,1) AS DOUBLE_SHARING_PRICE,
 {{ handle_phone_number('RESTAURANT_PHONE') }} as RESTAURANT_PHONE_NUMBER,
trim(SPLIT_PART(OPERATINGHOURS,'-',1)) AS OPENING_TIME,
trim(SPLIT_PART(OPERATINGHOURS,'-',2)) AS CLOSING_TIME,
LOCATIONID AS LOCATION_ID,
CASE
WHEN upper(ACTIVEFLAG) = 'YES' THEN TRUE
else FALSE
END AS IS_ACTIVE,
case 
when upper(trim(OPENSTATUS)) not in ('OPEN','CLOSED') THEN 'N/A'
else upper(trim(OPENSTATUS))
end as RESTAURANT_STATUS,
{{ handle_null_val('LOCALITY') }} as LOCALITY,
{{ handle_null_val('RESTAURANT_ADDRESS') }} as  RESTAURANT_ADDRESS,
nvl(LATITUDE,0) as LATITUDE,
nvl(LONGITUDE,0) as LONGITUDE,
{{ handle_column_date('CREATEDDATE') }} AS CREATE_DATE,
'admin' as create_user,
{{ handle_column_date('MODIFIEDDATE') }} as CHANGE_DATE,
'admin' as change_user
from {{ source('STAGE','RESTAURANT') }}