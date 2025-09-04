
use warehouse analytics_wh;
use database food_app_db;
use schema stage_layer;

list @initial_stage;

select 
T.$1 AS AddressID,
T.$2 AS CustomerID,
T.$3 AS FlatNo,
T.$4 AS HouseNo,
T.$5 AS Floor,
T.$6 AS Building,
T.$7 AS Landmark,
T.$8 AS Locality,
T.$9 AS City,
T.$10 AS State,
T.$11 AS Pincode,
T.$12 AS Coordinates,
T.$13 AS PrimaryFlag,
T.$14 AS AddressType,
T.$15 AS CreatedDate,
T.$16 AS ModifiedDate,
METADATA$FILENAME ,
METADATA$FILE_CONTENT_KEY,
METADATA$FILE_LAST_MODIFIED
from @initial_stage/customer_address/customer_address_book_initial.csv
(file_format => 'CSV_FF') T;

creATE table customer_address (
AddressID number,
CustomerID number,
FlatNo number,
HouseNo number,
Floor number,
Building text,
Landmark text,
Locality text,
City text,
State text,
Pincode number,Coordinates TEXT,PrimaryFlag text,AddressType text,
CreatedDate date,
ModifiedDate date,
stg_file_name text,stg_file_key text,stg_file_modified date , 
copy_ts timestamp default current_timestamp
)
comment = 'this table tracks the customer_address details';


create or replace stream customer_address_stream on table customer_address
append_only = true
comment = 'for CDC on customer_address';

copy into customer_address 
(AddressID,CustomerID,FlatNo,HouseNo,Floor,Building,Landmark,Locality,City,
State,Pincode,Coordinates,PrimaryFlag,AddressType,CreatedDate,ModifiedDate,
stg_file_name,stg_file_key,stg_file_modified)
from
(
    select 
T.$1 AS AddressID,
T.$2 AS CustomerID,
T.$3 AS FlatNo,
T.$4 AS HouseNo,
T.$5 AS Floor,
T.$6 AS Building,
T.$7 AS Landmark,
T.$8 AS Locality,
T.$9 AS City,
T.$10 AS State,
T.$11 AS Pincode,
T.$12 AS Coordinates,
T.$13 AS PrimaryFlag,
T.$14 AS AddressType,
T.$15 AS CreatedDate,
T.$16 AS ModifiedDate,
METADATA$FILENAME ,
METADATA$FILE_CONTENT_KEY,
METADATA$FILE_LAST_MODIFIED
from @initial_stage/customer_address/customer_address_book_initial.csv
(file_format => 'CSV_FF') T
) 
file_format = (format_name = 'CSV_FF')
on_error= 'CONTINUE';

drop schema FOOD_APP_DB.STAGE_LAYER_TRANFORM_LAYER;
drop schema FOOD_APP_DB.TRANFORM_LAYER;

SELECT * FROM customer_address;

show tables;
