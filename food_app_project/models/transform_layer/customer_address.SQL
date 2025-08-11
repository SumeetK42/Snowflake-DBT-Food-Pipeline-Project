{{ 
    config(
        materialized = 'table',
        post_hook=[
            "{{ 
            add_table_pk_constraint(this, 'ADDRESS_ID') 
            }}"
        ]
        )
}}

select 
ADDRESSID as ADDRESS_ID,
CUSTOMERID as CUSTOMER_ID,
cast ({{ handle_null_val('FLATNO') }} as number) as FLAT_NO,
cast ({{ handle_null_val('HOUSENO') }} as number) AS HOUSE_NO,
cast ({{ handle_null_val('FLOOR') }}  as number)  AS FLOOR_NO,
{{ handle_null_val('BUILDING') }} AS BUILDING_NAME,
{{ handle_null_val('LANDMARK') }}  AS LANDMARK,
{{ handle_null_val('LOCALITY') }} AS LOCALITY,
{{ handle_null_val('CITY') }} AS CITY,
{{ handle_null_val('STATE') }} AS STATE,
cast ({{ handle_null_val('PINCODE') }} as number ) AS PINCODE,
round(split(COORDINATES,',')[0]) as LATITUDE,
round(split(COORDINATES,',')[1]::float,4) as LONGITUDE,
CASE 
  WHEN NVL(PRIMARYFLAG,'N') = 'N' THEN 'N'
  else 'Y'
END AS PRIMARY_FLAG,
CASE   
WHEN upper(TRIM(ADDRESSTYPE)) = 'WORK' THEN 'WORK'
WHEN upper(TRIM(ADDRESSTYPE)) = 'HOME' THEN 'HOME'
ELSE 'OTHERS'
END AS ADDRESS_TYPE,
 {{ handle_column_date('CREATEDDATE') }} as create_date,
 'admin' as create_user,
 {{ handle_column_date('MODIFIEDDATE') }} as modified_date,
 'admin' as change_user
from {{ source('STAGE','CUSTOMER_ADDRESS') }}