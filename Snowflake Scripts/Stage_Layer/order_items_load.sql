use warehouse analytics_wh;
use database food_app_db;
use schema stage_layer;

list @initial_stage;
SELECT 
T.$1 AS OrderItemID,
T.$2 AS OrderID,
T.$3 AS MenuID,
T.$4 AS Quantity,
T.$5 AS Price,
T.$6 AS Subtotal,
T.$7 AS CreatedDate,
T.$8 AS ModifiedDate,
METADATA$FILENAME,
METADATA$FILE_CONTENT_KEY,
METADATA$FILE_LAST_MODIFIED
FROM @initial_stage/order_items/order-Item-initial.csv
(FILE_FORMAT => 'CSV_FF') T ;

CREATE TABLE ORDER_ITEMS (
OrderItemID NUMBER,
OrderID NUMBER,
MenuID NUMBER,Quantity NUMBER,Price NUMBER,Subtotal NUMBER,CreatedDate DATE,ModifiedDate DATE,
STG_FILENAME TEXT,STG_FILE_KEY TEXT,STG_LAST_MODIFIED DATE,COPY_TS TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)
COMMENT = 'TO Track the order items corresponding to order id';

CREATE OR REPLACE STREAM ORDER_ITEM_STREAM ON TABLE ORDER_ITEMS;

COPY INTO ORDER_ITEMS 
(OrderItemID,OrderID,MenuID,Quantity,Price,Subtotal,CreatedDate,ModifiedDate,
STG_FILENAME,STG_FILE_KEY,STG_LAST_MODIFIED)
FROM 
(
SELECT 
T.$1 AS OrderItemID,
T.$2 AS OrderID,
T.$3 AS MenuID,
T.$4 AS Quantity,
T.$5 AS Price,
T.$6 AS Subtotal,
T.$7 AS CreatedDate,
T.$8 AS ModifiedDate,
METADATA$FILENAME,
METADATA$FILE_CONTENT_KEY,
METADATA$FILE_LAST_MODIFIED
FROM @initial_stage/order_items/order-Item-initial.csv
(FILE_FORMAT => 'CSV_FF') T 
)
FILE_FORMAT = (FORMAT_NAME = 'CSV_FF')
ON_ERROR= 'CONTINUE';

SELECT * FROM ORDER_ITEMS;

