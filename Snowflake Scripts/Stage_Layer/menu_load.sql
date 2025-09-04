use warehouse analytics_wh;
use database food_app_db;
use schema stage_layer;

list @initial_stage;

select 
T.$1 AS MenuID,
T.$2 AS RestaurantID,
T.$3 AS ItemName,
T.$4 AS Description,
T.$5 AS Price,
T.$6 AS Category,
T.$7 AS Availability,
T.$8 AS ItemType,
T.$9 AS CreatedDate,
T.$10 AS ModifiedDate,
METADATA$FILENAME,
METADATA$FILE_CONTENT_KEY,
METADATA$FILE_LAST_MODIFIED
from 
@initial_stage/Menu/menu-initial-load.csv
(file_format => 'CSV_FF') T;

CREATE TABLE MENU (
MenuID NUMBER,
RestaurantID NUMBER,
ItemName TEXT,
Description TEXT,
Price NUMBER,
Category TEXT,
Availability TEXT,
ItemType TEXT,
CreatedDate DATE,
ModifiedDate DATE,
stg_file_name TEXT,
stg_file_key TEXT,
stg_modified_date DATE,
copy_ts timestamp default current_timestamp
)
COMMENT = 'To load all the menu details';

create stream menu_strm on table menu
append_only = true
comment = 'to capture the menu CDC';

COPY INTO MENU 
(MenuID,RestaurantID,ItemName,Description,Price,Category,Availability,ItemType,CreatedDate,ModifiedDate
,stg_file_name,stg_file_key,stg_modified_date)
FROM 
(
select 
T.$1 AS MenuID,
T.$2 AS RestaurantID,
T.$3 AS ItemName,
T.$4 AS Description,
T.$5 AS Price,
T.$6 AS Category,
T.$7 AS Availability,
T.$8 AS ItemType,
T.$9 AS CreatedDate,
T.$10 AS ModifiedDate,
METADATA$FILENAME,
METADATA$FILE_CONTENT_KEY,
METADATA$FILE_LAST_MODIFIED
from 
@initial_stage/Menu/menu-initial-load.csv
(file_format => 'CSV_FF') T
) 
FILE_FORMAT = (FORMAT_NAME = 'CSV_FF')
ON_ERROR = 'CONTINUE';

SELECT * FROM MENU;
