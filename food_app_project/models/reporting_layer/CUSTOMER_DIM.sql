select
{{ add_surrograte_key("CUSTOMER_ID","CUSTOMER_NAME","EMAIL_ADDRESS") }} as CUSTOMER_SK,
CUST.CUSTOMER_ID,
CUST.CUSTOMER_NAME,
CUST.PHONE_NUMBER,
CUST.EMAIL_ADDRESS,
CUST.LOGIN_BY_USING,
CUST.GENDER,
CUST.DATE_OF_BIRTH,
CUST.ANNIVERSARY_DATE,
CUST.CUISINETYPES_PREF,
CUST.FOODTYPE_PREF,
CUST.DBT_VALID_FROM as EFF_START_DATE,
CUST.DBT_VALID_TO AS EFF_END_DATE,
{{ handle_is_current("DBT_VALID_TO") }} as IS_CURRENT
from {{ ref('customer_snapshot') }} CUST

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