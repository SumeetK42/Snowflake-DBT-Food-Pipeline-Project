use warehouse analytics_wh;
use database food_app_db;
use schema stage_layer;

list @initial_stage;

select
O.$1::NUMBER AS OrderID,
O.$2::NUMBER AS CustomerID,
O.$3::NUMBER AS RestaurantID,
O.$4::TEXT AS OrderDate,
O.$5::NUMBER AS TotalAmount,
O.$6::TEXT AS Status,
O.$7::TEXT AS PaymentMethod,
O.$8::TEXT AS CreatedDate,
O.$9::TEXT AS ModifiedDate,
METADATA$FILE_CONTENT_KEY as stg_md5_key,
METADATA$filename as stg_file_name,
METADATA$file_last_modified as stg_last_modified
from @initial_stage/order/orders-initial.csv
( file_format => 'CSV_FF') O;

-- create table
create table orders (
OrderID number,
CustomerID number,
RestaurantID number,
OrderDate text,
TotalAmount number,
Status text,
PaymentMethod text,
CreatedDate text,
ModifiedDate text,
stg_md5_key text,
stg_file_name text,
stg_file_modified date,
copy_load_ts timestamp default current_timestamp
) 
comment = 'The Table for all orders details are added here';

create stream order_stream on table orders
append_only = true
comment = 'CDC for orders table in staging';

copy into orders(OrderID,CustomerID,RestaurantID,OrderDate,TotalAmount,Status,
PaymentMethod,CreatedDate,ModifiedDate,
stg_md5_key,stg_file_name,stg_file_modified )
from (
select
O.$1::NUMBER AS OrderID,
O.$2::NUMBER AS CustomerID,
O.$3::NUMBER AS RestaurantID,
O.$4::TEXT AS OrderDate,
O.$5::NUMBER AS TotalAmount,
O.$6::TEXT AS Status,
O.$7::TEXT AS PaymentMethod,
O.$8::TEXT AS CreatedDate,
O.$9::TEXT AS ModifiedDate,
METADATA$FILE_CONTENT_KEY as stg_md5_key,
METADATA$filename as stg_file_name,
METADATA$file_last_modified as stg_last_modified
from @initial_stage/order/orders-initial.csv
( file_format => 'CSV_FF') O)
file_format = (format_name = 'CSV_FF')
on_error = 'CONTINUE';

SELECT * FROM ORDERS;
select * from order_stream;