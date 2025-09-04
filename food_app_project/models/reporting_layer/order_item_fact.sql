select 
{{ add_surrograte_key("oti.ORDER_ITEM_ID","oti.order_id",1) }} as order_item_fact_sk,
oti.ORDER_ITEM_ID AS ORDER_ITEM_ID,
oti.order_id AS ORDER_ID,
C.CUSTOMER_ID AS CUSTOMER_DIM_KEY,
CA.ADDRESS_ID AS CUSTOMER_ADDRESS_DIM_KEY,
R.RESTAURANT_ID AS RESTAURANT_DIM_KEY,
RL.LOCATION_ID AS RESTAURANT_LOCATION_DIM_KEY,
M.MENU_ID AS MENU_DIM_KEY,
DA.DELIVERYAGENT_ID AS DELIVERYAGENT_DIM_KEY,
D.DATE_ID AS DATE_DIM_KEY,
O.ORDER_STATUS,
OTI.QUANTITY,
OTI.PRICE,
OTI.SUBTOTAL,
O.PAYMENT_METHOD,
DL.DELIVERY_STATUS,
DL.ESTIMATED_TIME_MINUTES
from 
{{ ref('order_items') }} oti
join {{ ref('orders') }} o on oti.order_id = o.order_id
join {{ ref('delivery') }} DL on DL.order_id = o.order_id
join {{ ref('CUSTOMER_DIM') }} C on C.CUSTOMER_ID = o.CUSTOMER_ID
join {{ ref('CUSTOMER_ADDRESS_DIM') }} CA on CA.CUSTOMER_ID = C.CUSTOMER_ID
join {{ ref('restaurant_dim') }} R on R.RESTAURANT_ID = o.RESTAURANT_ID
join {{ ref('menu_dim') }} M on M.MENU_ID = oti.MENU_ID
join {{ ref('restaurant_location_dim') }} RL on RL.LOCATION_ID = R.LOCATION_ID
join {{ ref('delivery_agent_dim') }} DA on DA.DELIVERYAGENT_ID = DL.DELIVERYAGENT_ID
join {{ ref('date_dim') }} D on D.CALENDER_DATE = o.order_date