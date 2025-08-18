{{ 
    config(materialized = 'table')
}}

with customer_snap as (
    select * from {{ ref('customer_snapshot') }}
)

select
{{ add_surrograte_key(CUSTOMER_ID,CUSTOMER_NAME,EMAIL_ADDRESS) }} as CUSTOMER_SK,
CUSTOMER_ID,
CUSTOMER_NAME,
PHONE_NUMBER,
EMAIL_ADDRESS,
LOGIN_BY_USING,
GENDER,
DATE_OF_BIRTH,
ANNIVERSARY_DATE
CUISINETYPES_PREF
FOODTYPE_PREF
from customer_snap



/*

 CUSTOMER_HK NUMBER PRIMARY KEY,               -- Surrogate key for the customer
    CUSTOMER_ID STRING NOT NULL,                                 -- Natural key for the customer
    NAME STRING(100) NOT NULL,                                   -- Customer name
    MOBILE STRING(15) WITH TAG (common.pii_policy_tag = 'PII'),                                           -- Mobile number
    EMAIL STRING(100) WITH TAG (common.pii_policy_tag = 'EMAIL'),                                           -- Email
    LOGIN_BY_USING STRING(50),                                   -- Method of login
    GENDER STRING(10) WITH TAG (common.pii_policy_tag = 'PII'),                                           -- Gender
    DOB DATE WITH TAG (common.pii_policy_tag = 'PII'),                                                    -- Date of birth
    ANNIVERSARY DATE,                                            -- Anniversary
    PREFERENCES STRING,                                          -- Preferences
    EFF_START_DATE TIMESTAMP_TZ,                                 -- Effective start date
    EFF_END_DATE TIMESTAMP_TZ,                                   -- Effective end date (NULL if active)
    IS_CURRENT BOOLEAN   

*/