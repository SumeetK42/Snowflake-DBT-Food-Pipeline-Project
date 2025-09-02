{{ 
    config(
        materialized = 'table',
        post_hook=[
            "{{ 
            add_table_pk_constraint(this,'DELIVERYAGENT_ID') 
            }}"
        ]
        )
}}

select 
DELIVERYAGENTID as DELIVERYAGENT_ID,
{{ handle_name('NAME') }} AS NAME,
{{ handle_phone_number('PHONE') }} as PHONE_NUMBER,
{{ handle_null_val('VEHICLETYPE') }} VEHICLETYPE,
LOCATIONID,
CASE 
  when TRIM(upper(STATUS)) IN ('ACTIVE','INACTIVE') then TRIM(upper(STATUS))
  else 'N/A'
END AGENT_STATUS,
{{ handle_gender('GENDER') }} as GENDER,
RATING,
cast ( CREATEDDATE as timestamp_ntz)  as create_date,
'admin' as create_user,
cast ( MODIFIEDDATE as timestamp_ntz)  as change_date,
'admin' as change_user
from {{ source('STAGE','DELIVERYAGENT') }}