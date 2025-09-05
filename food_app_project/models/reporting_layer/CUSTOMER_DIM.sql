With Login_details as (
select customer_id, 
split ( listagg(distinct login_type,','),',') as LOGIN_TYPE,
split ( listagg(distinct DEVICE_INTERFACE,','),',') as DEVICE_INTERFACE,
split ( listagg(distinct MOBILE_DEVICENAME,','),',') as MOBILE_DEVICENAME,
split ( listagg(distinct WEB_INTERFACE,','),',') as WEB_INTERFACE,
max(last_login) as last_login
from {{ ref('cust_login_detail') }}
group by customer_id
ORDER BY customer_id
) select 
{{ add_surrograte_key("CUST.CUSTOMER_ID","CUSTOMER_NAME","EMAIL_ADDRESS") }} as CUSTOMER_SK,
CUST.CUSTOMER_ID,
CUST.CUSTOMER_NAME,
CUST.PHONE_NUMBER,
CUST.EMAIL_ADDRESS,
CUST.LOGIN_BY_USING,
LG.LOGIN_TYPE,
LG.DEVICE_INTERFACE,
LG.MOBILE_DEVICENAME,
LG.WEB_INTERFACE,
CUST.GENDER,
CUST.DATE_OF_BIRTH,
CUST.ANNIVERSARY_DATE,
CUST.CUISINETYPES_PREF,
CUST.FOODTYPE_PREF,
CUST.DBT_VALID_FROM as EFF_START_DATE,
CUST.DBT_VALID_TO AS EFF_END_DATE,
{{ handle_is_current("DBT_VALID_TO") }} as IS_CURRENT
from {{ ref('customer_snapshot') }}  cust
left join login_details lg on cust.customer_id = lg.customer_id