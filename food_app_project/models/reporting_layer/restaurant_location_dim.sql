select 
{{ add_surrograte_key("LOCATION_ID","CITY","ZIP_CODE") }} as RESTAURANT_LOCATION_SK,
LOCATION_ID,
CITY,
CITY_TIER,
STATE,
IS_UNION_TERRITORY,
ZIP_CODE,
IS_ACTIVE,
DBT_VALID_FROM AS EFF_START_DATE,
DBT_VALID_TO AS EFF_END_DATE,
{{ handle_is_current("DBT_VALID_TO") }} as IS_CURRENT
from {{ ref('restaurant_location_snapshot') }}