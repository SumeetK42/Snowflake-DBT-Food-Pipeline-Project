use warehouse analytics_wh;
use database food_app_db;
use schema stage_layer;

list @initial_stage;

select 
T.$1 AS RestaurantID,
T.$2 AS Name,
T.$3 AS CuisineType,
T.$4 AS Pricing_for_2,
T.$5 AS Restaurant_Phone,
T.$6 AS OperatingHours,
T.$7 AS LocationID,
T.$8 AS ActiveFlag,
T.$9 AS OpenStatus,
T.$10 AS Locality,
T.$11 AS Restaurant_Address,
T.$12 AS Latitude,
T.$13 AS Longitude,
T.$14 AS CreatedDate,
T.$15 AS ModifiedDate,
METADATA$FILENAME ,
METADATA$FILE_CONTENT_KEY,
METADATA$FILE_LAST_MODIFIED
from 
@initial_stage/restaurants/restaurant-delhi+NCR.csv
(file_format => 'CSV_FF') T;

create table Restaurant (
RestaurantID NUMBER,
Name TEXT,
CuisineType TEXT,
Pricing_for_2 NUMBER,
Restaurant_Phone NUMBER,
OperatingHours TEXT,
LocationID NUMBER,
ActiveFlag TEXT,
OpenStatus TEXT,
Locality TEXT,
Restaurant_Address TEXT,
Latitude NUMBER,
Longitude NUMBER,
CreatedDate DATE,
ModifiedDate DATE,
STG_FILE_NAME TEXT,
STG_FILE_KEY TEXT,
STG_FLE_LAST_MODIFIED DATE,
COPY_TS TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
)
COMMENT= 'Has the restaurant related details in the table';

CREATE OR REPLACE STREAM Restaurant_STRM
on table Restaurant
append_only = true
comment = 'This is to track the insert detail on Restaurant table';

copy into Restaurant
(RestaurantID,	Name	,CuisineType	,Pricing_for_2,	Restaurant_Phone,	OperatingHours,	LocationID,	ActiveFlag,	OpenStatus,	Locality,	Restaurant_Address,	Latitude,	
Longitude,	CreatedDate,	ModifiedDate,STG_FILE_NAME,STG_FILE_KEY, STG_FLE_LAST_MODIFIED 
)
from 
(
select 
T.$1 AS RestaurantID,
T.$2 AS Name,
T.$3 AS CuisineType,
T.$4 AS Pricing_for_2,
T.$5 AS Restaurant_Phone,
T.$6 AS OperatingHours,
T.$7 AS LocationID,
T.$8 AS ActiveFlag,
T.$9 AS OpenStatus,
T.$10 AS Locality,
T.$11 AS Restaurant_Address,
T.$12 AS Latitude,
T.$13 AS Longitude,
T.$14 AS CreatedDate,
T.$15 AS ModifiedDate,
METADATA$FILENAME ,
METADATA$FILE_CONTENT_KEY,
METADATA$FILE_LAST_MODIFIED
from 
@initial_stage/restaurants/restaurant-delhi+NCR.csv
(file_format => 'CSV_FF') T
)
FILE_FORMAT = (FORMAT_NAME = 'CSV_FF')
ON_ERROR = 'CONTINUE';

SELECT * FROM RESTAURANT;
