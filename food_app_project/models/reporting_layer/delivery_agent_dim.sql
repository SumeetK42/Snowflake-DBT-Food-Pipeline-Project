select
{{ add_surrograte_key("DELIVERYAGENT_ID","NAME","PHONE_NUMBER") }} as  DELIVERYAGENT_SK,
DELIVERYAGENT_ID,
NAME,
PHONE_NUMBER,
VEHICLETYPE,
LOCATIONID,
AGENT_STATUS,
GENDER,
RATING,
DBT_VALID_FROM AS EFF_START_DATE,
DBT_VALID_TO AS EFF_END_DATE,
{{ handle_is_current("DBT_VALID_TO") }} AS IS_CURRENT
from {{ ref('delivery_agent_snapshot') }}

/*
  delivery_agent_hk number primary key comment 'Delivery Agend Dim HK (EDW)',               -- Hash key for unique identification
    delivery_agent_id NUMBER not null comment 'Primary Key (Source System)',               -- Business key
    name STRING NOT NULL,                   -- Delivery agent name
    phone STRING UNIQUE,                    -- Phone number, unique
    vehicle_type STRING,                    -- Type of vehicle
    location_id_fk NUMBER NOT NULL comment 'Location FK (Source System)',                     -- Location ID
    status STRING,                          -- Current status of the delivery agent
    gender STRING,                          -- Gender
    rating NUMBER(4,2),                     -- Rating with one decimal precision
    eff_start_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Effective start date
    eff_end_date TIMESTAMP,                 -- Effective end date (NULL for active record)
    is_current BOOLEAN DEFAULT TRUE

*/    