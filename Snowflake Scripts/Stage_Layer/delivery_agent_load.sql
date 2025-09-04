use warehouse analytics_wh;
use database food_app_db;
use schema stage_layer;

list @initial_stage;

select 
T.$1 AS DeliveryAgentID,
T.$2 AS Name,
T.$3 AS Phone,
T.$4 AS VehicleType,
T.$5 AS LocationID,
T.$6 AS Status,
T.$7 AS Gender,
T.$8 AS Rating,
T.$9 AS CreatedDate,
T.$10 AS ModifiedDate,
METADATA$FILENAME ,
METADATA$FILE_CONTENT_KEY,
METADATA$FILE_LAST_MODIFIED
from @initial_stage/delivery_agent/delivery-agent-initial.csv
(file_format => 'CSV_FF') T;

creATE table DeliveryAgent (
DeliveryAgentID number,
Name text,
Phone number,
VehicleType text,
LocationID number,
Status text,
Gender text,
Rating number,
CreatedDate date,
ModifiedDate date,
stg_file_name text,stg_file_key text,stg_file_modified date , 
copy_ts timestamp default current_timestamp
)
comment = 'this table tracks the delivery agent details';

create or replace stream delivery_agent_stream on table DeliveryAgent
append_only = true
comment = 'for CDC on DeliveryAgent';

copy into DeliveryAgent 
(DeliveryAgentID,Name,Phone,VehicleType,LocationID,Status,Gender,Rating,CreatedDate,ModifiedDate,
stg_file_name,stg_file_key,stg_file_modified)
from
(
select 
T.$1 AS DeliveryAgentID,
T.$2 AS Name,
T.$3 AS Phone,
T.$4 AS VehicleType,
T.$5 AS LocationID,
T.$6 AS Status,
T.$7 AS Gender,
T.$8 AS Rating,
T.$9 AS CreatedDate,
T.$10 AS ModifiedDate,
METADATA$FILENAME ,
METADATA$FILE_CONTENT_KEY,
METADATA$FILE_LAST_MODIFIED
from @initial_stage/delivery_agent/delivery-agent-initial.csv
(file_format => 'CSV_FF') T
) 
file_format = (format_name = 'CSV_FF');



SELECT * FROM DeliveryAgent;

