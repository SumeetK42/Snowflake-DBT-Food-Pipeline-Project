{{ 
    config(
        materialized = 'table',
        post_hook=[
            "{{ 
            add_table_pk_constraint(this,'LOGIN_ID') 
            }}"
        ]
        )
}}

select 
LOGINID as LOGIN_ID,
CUSTOMERID AS CUSTOMER_ID,
UPPER({{ handle_null_val('LOGINTYPE') }}) AS LOGIN_TYPE,
UPPER({{ handle_null_val('DEVICEINTERFACE') }}) AS DEVICE_INTERFACE,
UPPER({{ handle_null_val('MOBILEDEVICENAME') }}) as MOBILE_DEVICENAME,
upper({{ handle_null_val('WEBINTERFACE') }}) as WEB_INTERFACE,
LASTLOGIN as LAST_LOGIN,
{{ add_audit_columns () }}
from {{ source('STAGE','LOGIN_AUDIT') }}