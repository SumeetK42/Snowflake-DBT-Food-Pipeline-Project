{{ 
    config(materialized = 'table')
}}

select 
{{ add_surrograte_key (ADDRESS_ID,CUSTOMER_ID,HOUSE_NO) }} as ADDRESS_SK,
ADDRESS_ID,
CUSTOMER_ID,
FLAT_NO,
HOUSE_NO,
FLOOR_NO,
BUILDING_NAME,
LANDMARK,
LOCALITY,
CITY,
STATE,
PINCODE,
LATITUDE,
LONGITUDE,
PRIMARY_FLAG,
ADDRESS_TYPE
from {{ ref('customer_address') }}