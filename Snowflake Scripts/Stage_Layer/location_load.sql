use warehouse analytics_wh;
use database FOOD_APP_DB;
USE schema stage_layer;

select 
t.$1::number as LocationID,
t.$2::text as City, 
t.$3::text as State , 
t.$4::number as ZipCode, 
t.$5 as ActiveFlag, 
t.$6::date as CreatedDate ,
t.$7::date as ModifiedDate,
metadata$filename as FILE_LOADED,
metadata$file_content_key as MD5_KEY,
metadata$file_last_modified as last_modified
from @initial_stage/location/location-5rows.csv
( FILE_FORMAT => 'CSV_FF') t;

--- Create table to data load

create table location (
LocationID number,
City text,
State text,
ZipCode number,
ActiveFlag text,
CreatedDate date,
ModifiedDate date,
stg_file_loaded text,
stg_modifed_date text,
stg_md5_key text,
copy_data_ts timestamp default current_timestamp
); 

-- create a stream for that table

create or replace stream location_stream on table location
append_only = true
comment ="This is for CDC on location table";

-- copy into command for snowflake

copy into location
(LocationID,City,State,ZipCode,ActiveFlag,CreatedDate,
ModifiedDate,stg_file_loaded,stg_modifed_date,stg_md5_key)
from 
( select 
t.$1::number as LocationID,
t.$2::text as City, 
t.$3::text as State , 
t.$4::number as ZipCode, 
t.$5 as ActiveFlag, 
t.$6::date as CreatedDate ,
t.$7::date as ModifiedDate,
metadata$filename as FILE_LOADED,
metadata$file_last_modified as last_modified,
metadata$file_content_key as MD5_KEY
from @initial_stage/location/location-5rows.csv
( FILE_FORMAT => 'CSV_FF') t
)
file_format = (format_name = 'CSV_FF')
on_error = 'CONTINUE';

SELECT * FROM LOCATION LIMIT 5;

