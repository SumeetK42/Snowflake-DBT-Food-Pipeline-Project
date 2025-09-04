with all_dates as (
SELECT delivery_date as all_date FROM {{ ref('delivery') }} a
join {{ ref('orders') }} b on a.order_id = b.order_id
union
SELECT order_date FROM {{ ref('delivery') }} a
join {{ ref('orders') }} b on a.order_id = b.order_id
) select 
row_number() over (order by all_date) as DATE_ID,
all_date AS CALENDER_DATE,
YEAR(all_date) AS YEAR,
MONTH(all_date) AS MONTH,
DAY(all_date) AS DAY_OF_MONTH,
dayname(all_date) as DAY_NAME,
dayofyear(all_date) AS DAY_OF_YEAR,
dayofweek(all_date) AS DAY_OF_WEEK,
WEEK(all_date)  AS WEEK_OF_YEAR,
QUARTER(All_date) as Quarter
from all_dates