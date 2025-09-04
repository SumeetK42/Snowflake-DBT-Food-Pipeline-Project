use warehouse analytics_wh;
use database food_app_db;
use schema stage_layer;

list @initial_stage;

select 
T.$1 AS LoginID,
T.$2 AS CustomerID,
T.$3 AS LoginType,
T.$4 AS DeviceInterface,
T.$5 AS MobileDeviceName,
T.$6 AS WebInterface,
T.$7 AS LastLogin,
METADATA$FILENAME ,
METADATA$FILE_CONTENT_KEY,
METADATA$FILE_LAST_MODIFIED
from @initial_stage/login/login-audit-initial.csv
(file_format => 'CSV_FF') T;

creATE table login_audit (
LoginID number,CustomerID number,LoginType text,DeviceInterface text,MobileDeviceName text,
WebInterface text,LastLogin date,
stg_file_name text,stg_file_key text,stg_file_modified date , 
copy_ts timestamp default current_timestamp
)
comment = 'this table tracks the audit details for login';

create or replace stream login_stream on table login_audit
append_only = true
comment = 'for CDC on login audit';

copy into login_audit 
(LoginID,CustomerID,LoginType,DeviceInterface,MobileDeviceName,WebInterface,LastLogin,
stg_file_name,stg_file_key,stg_file_modified)
from
(select 
T.$1 AS LoginID,
T.$2 AS CustomerID,
T.$3 AS LoginType,
T.$4 AS DeviceInterface,
T.$5 AS MobileDeviceName,
T.$6 AS WebInterface,
T.$7 AS LastLogin,
METADATA$FILENAME ,
METADATA$FILE_CONTENT_KEY,
METADATA$FILE_LAST_MODIFIED
from @initial_stage/login/login-audit-initial.csv
(file_format => 'CSV_FF') T
) 
file_format = (format_name = 'CSV_FF');



SELECT * FROM login_audit;

