{{ 
    config(
        materialized = 'table',
        post_hook=[
            "{{ 
            add_table_pk_constraint(this, 'CUSTOMER_ID') 
            }}"
        ]
        )
}}

select
"CUSTOMERID" as CUSTOMER_ID,
{{ handle_name('"Name"') }} as CUSTOMER_NAME,
{{ handle_phone_number('"Mobile"') }} AS PHONE_NUMBER, 
{{ handle_email('"Email"')}} as EMAIL_ADDRESS,
initcap("LoginByUsing") as LOGIN_BY_USING,
{{ handle_gender('"Gender"') }} as Gender, 
{{ handle_column_date('"DOB"') }} as DATE_OF_BIRTH, 
{{ handle_column_date('"Anniversary"') }} as Anniversary_DATE,
"Preferences":"CuisineTypes" as CuisineTypes_Pref, 
cast ("Preferences":"FoodPreference" as string(20)) as Foodtype_Pref,
{{ add_audit_columns() }} 
from 
{{ source('STAGE','CUSTOMERS') }}

