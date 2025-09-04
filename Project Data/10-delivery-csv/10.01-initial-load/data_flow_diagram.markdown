# Data Flow Diagram for Snowflake and DBT Stacks

## Overview
This diagram outlines the data transformation process, separating the Snowflake data warehouse and DBT transformation/reporting layers into modular components.

## Snowflake Stack
- **Stage Layer**
  - `STAGE_LAYER.CUSTOMERS`
  - `STAGE_LAYER.CUSTOMER_ADDRESS`
  - `STAGE_LAYER.DELIVERY`
  - `STAGE_LAYER.DELIVERYAGENT`
  - `STAGE_LAYER.LOCATION`
  - `STAGE_LAYER.LOGIN_AUDIT`
  - `STAGE_LAYER.MENU`
  - `STAGE_LAYER.ORDERS`
  - `STAGE_LAYER.ORDER_ITEMS`
  - `STAGE_LAYER.RESTAURANT`

## DBT Stack
- **Transform Layer**
  - `TRANSFORM_LAYER.customer` → `REPORTING_LAYER.CUSTOMER_DIM`
  - `TRANSFORM_LAYER.customer_address` → `REPORTING_LAYER.CUSTOMER_ADDRESS_DIM`
  - `TRANSFORM_LAYER.delivery` → (No reporting layer mapping)
  - `TRANSFORM_LAYER.delivery_agent` → `REPORTING_LAYER.delivery_agent_dim`
  - `TRANSFORM_LAYER.restaurant_location` → `REPORTING_LAYER.restaurant_location_dim`
  - `TRANSFORM_LAYER.cust_Login_detail` → `REPORTING_LAYER.CUSTOMER_login_DIM`
  - `TRANSFORM_LAYER.menu` → `REPORTING_LAYER.menu_dim`
  - `TRANSFORM_LAYER.orders` → `REPORTING_LAYER.order_item_fact`
  - `TRANSFORM_LAYER.order_item` → `REPORTING_LAYER.order_item_fact`
  - `TRANSFORM_LAYER.restaurant` → `REPORTING_LAYER.RESTAURANT_DIM`

## Notes
- Snowflake serves as the data warehouse for the Stage Layer.
- DBT handles transformations in the Transform Layer and builds the Reporting Layer.