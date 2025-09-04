use warehouse analytics_wh;
use database food_app_db;
use schema stage_layer;

list @initial_stage;

select 
T.$1 AS DeliveryID,
T.$2 AS OrderID,
T.$3 AS DeliveryAgentID,
T.$4 AS DeliveryStatus,
T.$5 AS EstimatedTime,
T.$6 AS DeliveryAddress,
T.$7 AS DeliveryDate,
T.$8 AS CreatedDate,
T.$9 AS ModifiedDate,
METADATA$FILENAME ,
METADATA$FILE_CONTENT_KEY,
METADATA$FILE_LAST_MODIFIED
from @initial_stage/delivery/delivery-initial-load.csv
(FILE_FORMAT => 'CSV_FF') T;

CREATE TABLE DELIVERY (
DeliveryID NUMBER,
OrderID NUMBER,DeliveryAgentID NUMBER,DeliveryStatus TEXT,EstimatedTime TEXT,DeliveryAddress NUMBER,DeliveryDate DATE,CreatedDate DATE,ModifiedDate DATE, stg_file_name TEXT,stg_file_key TEXT,stg_modified_date DATE
)
COMMENT = 'to track the delivery details of the orders';

CREATE OR REPLACE STREAM DELIVERY_STRM ON table  DELIVERY
append_only = true
comment = 'to track CDC for Delivery table';


copy into delivery (DeliveryID,OrderID,DeliveryAgentID,DeliveryStatus,EstimatedTime,
DeliveryAddress,DeliveryDate,CreatedDate,ModifiedDate,stg_file_name,stg_file_key,stg_modified_date)
from 
(
select 
T.$1 AS DeliveryID,
T.$2 AS OrderID,
T.$3 AS DeliveryAgentID,
T.$4 AS DeliveryStatus,
T.$5 AS EstimatedTime,
T.$6 AS DeliveryAddress,
T.$7 AS DeliveryDate,
T.$8 AS CreatedDate,
T.$9 AS ModifiedDate,
METADATA$FILENAME ,
METADATA$FILE_CONTENT_KEY,
METADATA$FILE_LAST_MODIFIED
from @initial_stage/delivery/delivery-initial-load.csv
(FILE_FORMAT => 'CSV_FF') T
)
FILE_FORMAT = (FORMAT_NAME = 'CSV_FF')
ON_ERROR = 'CONTINUE';

SELECT * FROM DELIVERY;


