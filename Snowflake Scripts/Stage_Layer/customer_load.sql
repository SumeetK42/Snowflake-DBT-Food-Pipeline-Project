use warehouse analytics_wh;
use database food_app_db;
use schema stage_layer;

list @initial_stage;

select  
T.$1 AS "CustomerID",
T.$2 AS "Name",
T.$3 AS "Mobile",
T.$4 AS "Email",
T.$5 AS "LoginByUsing",
T.$6 AS "Gender",
T.$7 AS "DOB",
T.$8 AS "Anniversary",
T.$9 AS "Preferences",
T.$10 AS "CreatedDate",
T.$11 AS "ModifiedDate",
METADATA$FILENAME,
METADATA$FILE_CONTENT_KEY,
METADATA$FILE_LAST_MODIFIED
from @initial_stage/customers/customers-initial.csv
(file_format => 'CSV_FF') T;

create table customers
(
CustomerID text,
"Name" text,
"Mobile" number,
"Email" text,
"LoginByUsing" text,
"Gender" text,
"DOB" date,
"Anniversary" date ,
"Preferences" variant,
"CreatedDate" date,
"ModifiedDate" date,
stg_file_name text,
stg_md5_file text,
stg_modified_date date
)
COMMENT = 'This table keeps the track of the customers';

select * from customers;

create or replace stream customer_stream
on table customers 
append_only = true
comment = 'to track the insert changes on the customer';

copy into customers 
FROM (
select  
T.$1 AS "CustomerID",
T.$2 AS "Name",
T.$3 AS "Mobile",
T.$4 AS "Email",
T.$5 AS "LoginByUsing",
T.$6 AS "Gender",
T.$7 AS "DOB",
T.$8 AS "Anniversary",
T.$9 AS "Preferences",
T.$10 AS "CreatedDate",
T.$11 AS "ModifiedDate",
METADATA$FILENAME,
METADATA$FILE_CONTENT_KEY,
METADATA$FILE_LAST_MODIFIED
from @initial_stage/customers/customers-initial.csv
(file_format => 'CSV_FF') T
)
FILE_FORMAT = (FORMAT_NAME = 'CSV_FF')
on_error = 'CONTINUE';

SELECT * FROM CUSTOMERS;
SELECT * FROM CUSTOMER_STREAM;