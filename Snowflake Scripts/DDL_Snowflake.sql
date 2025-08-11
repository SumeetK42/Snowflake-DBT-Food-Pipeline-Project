use warehouse analytics_wh;
use database FOOD_APP_DB;

Create SCHEMA STAGE_LAYER;
Create SCHEMA LOAD_LAYER;
Create SCHEMA TRANSFORM_LAYER;
Create SCHEMA REPORTING_LAYER;

USE SCHEMA FOOD_APP_DB.STAGE_LAYER;

-- Create Stage 

create stage initial_stage
directory = (enable = true)
comment = 'This Staging Layer is for the Initial Data Load from CSV';

create stage delta_stage
directory = (enable= true)
comment = 'This is Staging for Delta/Incremental Load from CSV';

--- Create File format for staging the data

create or replace file format csv_ff
type = 'CSV',
FIELD_DELIMITER=",",
SKIP_HEADER=1
record_delimiter = '\n'
field_optionally_enclosed_by = '"';

SHOW FILE FORMATS;

DESC FILE FORMAT csv_ff;

--- Loaded Manually from snowsight UI
s
---  we query the inital stage location file

list @initial_stage;

---  we query the delta stage location file


list @delta_stage;

