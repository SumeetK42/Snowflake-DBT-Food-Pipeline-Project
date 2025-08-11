{{ 
    config(materialized = 'table')
}}

select 
 LOCATIONID AS LOCATION_ID,
 {{ handle_null_val('CITY') }} as CITY,
 {{ get_city_tier('CITY') }} as city_tier,
 {{ handle_null_val('STATE') }} as STATE,
 {{ is_union_territory('STATE') }} as is_union_territory,
 TO_NUMBER(ZIPCODE) AS zip_code,
 case 
 when upper(trim(ACTIVEFLAG)) = 'YES' then TRUE
 else FALSE
 end as IS_ACTIVE, 
 {{ handle_column_date('CREATEDDATE') }} as CREATE_DATE,
 'admin' as create_user,
 {{ handle_column_date('MODIFIEDDATE') }} as CHANGE_DATE,
 'admin' as change_user
from {{ source('STAGE','LOCATION') }}