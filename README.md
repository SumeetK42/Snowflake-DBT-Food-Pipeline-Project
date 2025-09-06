# 🍴 Food Delivery Data Engineering Pipeline  

## 📌 Project Overview  
This project demonstrates an **end-to-end Data Engineering pipeline** built with **Snowflake** and **dbt**.  
It ingests raw CSVs, stages them in Snowflake, applies transformations with **dbt**, implements **SCD Type 2** with dbt snapshots, and builds a **Reporting Layer with Star Schema + KPI Views** for analytics dashboards.  

## 🚀 Tech Stack  
- **Snowflake** – Data warehouse & staging  
- **dbt** – Transformations, macros, snapshots  
- **Snowflake Streams** – CDC handling  
- **Snowsight** – Dashboards & reporting  

---

## 🔑 Key Features  
- End-to-end ELT flow from raw → reporting  
- **CDC with Streams**  
- **SCD Type 2** with dbt snapshots  
- Cleaned, enriched, and standardized data  
- **Star Schema for BI**  
- KPI-based dashboards  
---

## 🏗️ High-Level Architecture  


**Flow:**  
1. **Data Ingestion** → Raw CSV files → Snowflake Stage  
2. **Stage Layer** → Data staged with **Streams** for CDC in Staging layer tables
3. **Transform Layer** → dbt models clean, enrich & standardize with help of macros 
4. **Snapshot Layer** → dbt **SCD2 Snapshots** for history tracking  
5. **Reporting Layer** → Star Schema (Facts & Dimensions) + KPI Views  
6. **Dashboards** → Snowflake Snowsight  


<img src="Project Docs/high level architecture.png" alt="high level architecture" width="700"/>


## 🗄️ Data Pipeline Layers  

<img src="Project Docs/Entity_flow_daigram.png" alt="Entity_flow_daigram" width="1000"/>

## 📊 Data Model  

### Entity-Relationship (Star Schema)  

<img src="Project Docs\STAR_SCHEMA.png" alt="STAR_SCHEMA" width="800"/>  

### dbt Lineage Graph  

<img src="Project Docs/Pipeline_Lineage.png" alt="Pipeline_Lineage" width="1000"/>
---

## 📈 Dashboard  

### KPI Dashboards in Snowsight  
- **Monthly Revenue**  
- **Monthly Order KPIs (Revenue per Restaurant, Avg Order Value)**  
- **Yearly KPIs (Revenue, Revenue per Customer, Revenue per Restaurant)**  
<img src="Project Docs/KPIs dashboard.png" alt="KPIs" width="700"/>

---
## 👨‍💻 Author  
**Sumeet Karmankar**  
📌 Data Engineering & Analytics Enthusiast  
