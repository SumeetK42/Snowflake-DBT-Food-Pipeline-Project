{{ 
    config(materialized = 'table')
}}

select 
{{ add_surrograte_key(MENU_ID,RESTAURANT_ID,MENU_ITEM_NAME) }} as MENU_SK,
MENU_ID,
RESTAURANT_ID,
MENU_ITEM_NAME,
DESCRIPTION,
PRICE,
CATEGORY,
IS_AVAILABLE_NOW,
EFFECTIVE_START_DATE,
EFFECTIVE_END_DATE,
IS_CURRENT
from {{ ref('menu') }}

/*


  Menu_Dim_HK NUMBER primary key comment 'Menu Dim HK (EDW)',                         -- Hash key generated for Menu Dim table
    Menu_ID INT NOT NULL comment 'Primary Key (Source System)',                       -- Unique and non-null Menu_ID
    Restaurant_ID_FK INT NOT NULL comment 'Restaurant FK (Source System)',                          -- Identifier for the restaurant
    Item_Name STRING,                            -- Name of the menu item
    Description STRING,                         -- Description of the menu item
    Price DECIMAL(10, 2),                       -- Price as a numeric value with 2 decimal places
    Category STRING,                            -- Food category (e.g., North Indian)
    Availability BOOLEAN,                       -- Availability status (True/False)
    Item_Type STRING,                           -- Dietary classification (e.g., Vegan)
    EFF_START_DATE TIMESTAMP_NTZ,               -- Effective start date of the record
    EFF_END_DATE TIMESTAMP_NTZ,                 -- Effective end date of the record
    IS_CURRENT BOOLEAN                         -- Flag to indicate if the record is current (True/False)

*/