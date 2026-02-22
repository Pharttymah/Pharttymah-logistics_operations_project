# Pharttymah-logistics_operations_project
End-to-end logistics operations analytics project using MySQL. Designed and implemented a relational database to transform raw transportation data into structured insights on driver performance, trip efficiency, revenue, and on-time delivery metrics.

# Logistics Operations SQL Analysis

## 📌 Project Overview

This project analyzes the operational performance of a logistics company using SQL. The objective is to evaluate key operational areas such as driver performance, fleet utilization, route profitability, fuel efficiency, maintenance impact, safety metrics, and customer revenue.

The analysis is built on a fully designed relational database created from raw CSV files. The database contains 14 interconnected tables representing drivers, fleet assets, trips, customers, fuel purchases, maintenance records, and delivery performance events across end-to-end transportation operations.

This project demonstrates intermediate-level SQL skills including joins, aggregations, subqueries, window functions, ranking, and performance-based analysis.

---

## 🗂 Database Structure

The database includes the following core tables:

- **Drivers** – Driver demographics and employment information  
- **Trucks** – Fleet equipment details  
- **Trailers** – Trailer inventory  
- **Customers** – Customer accounts and contract types  
- **Facilities** – Terminal and warehouse locations  
- **Routes** – Origin-destination lanes and distances  
- **Loads** – Shipment details and revenue  
- **Trips** – Execution-level trip data  
- **Fuel_Purchases** – Fuel transactions per trip  
- **Maintenance_Records** – Service and repair costs  
- **Delivery_Events** – Pickup/delivery timestamps and on-time status  
- **Safety_Incidents** – Accident and violation records  
- **Driver_Monthly_Metrics** – Aggregated driver KPIs  
- **Truck_Utilization_Metrics** – Aggregated fleet KPIs  

---

## 🔗 Key Relationships

- Loads belong to Customers and Routes  
- Trips are assigned to Drivers, Trucks, and Trailers  
- Fuel purchases and safety incidents are linked to Trips  
- Maintenance records are linked to Trucks  
- Delivery events track on-time performance per trip  

---

## 🎯 Business Questions Answered

1. Who are the top-performing drivers based on completed trips and on-time rates?  
2. Which routes generate the highest revenue?  
3. What is the average fuel efficiency (MPG) by driver and truck?  
4. Which trucks incur the highest maintenance cost per mile?  
5. What is the company-wide on-time delivery rate?  
6. Which customers generate the most revenue?  
7. What is the safety incident rate per driver?  
8. How does fleet utilization vary by month?  

---

## 🛠 SQL Techniques Used

- SELECT statements  
- WHERE filtering  
- GROUP BY and HAVING  
- Multi-table INNER JOIN  
- Aggregate functions (SUM, COUNT, AVG)  
- CASE statements  
- Subqueries  
- Window functions (RANK, DENSE_RANK)  
- Date grouping and formatting  

---

## 🏁 Analysis Phases

### **Phase 1 – Database Creation**
- Created all tables based on CSV files  
- Defined proper data types (corrected BOOLEAN/text issues after import)  
- Set primary and foreign key relationships in design  
/Images/Phase 1_Database creation and tables.png


### **Phase 2 – Data Understanding & Validation**
- Reviewed column definitions and data types  
- Identified missing values in critical fields (trip times, delivery outcomes)  
- Validated relationships across tables using keys (driver_id, truck_id, route_id)  
- **Deliverables:** Data dictionary, SQL queries for nulls/duplicates, data quality notes  
/Images/Phase 2_Sample View_columns from customers.png
/Images/Phase 2_Sample-Review column definitions and data types.png


### **Phase 3 – Foundational Analysis**
- Total trucks: 120, trailers: 180, drivers: 150, customers: 200  
- Count of completed trips: 1,646  
- Delivery outcomes (on-time vs delayed): 918 / 734  
- Total revenue from loads: 347,404.64  
- **Deliverables:** SQL queries + one-two sentence interpretations per metric
/Images/Phase 3_ Sample of Foundational Analysis.png
  

### **Phase 4 – Driver & Performance Analysis**
- Top drivers by completed trips  
- Monthly driver performance metrics  
- Safety incidents count by driver  
- Average delivery time per driver  
- **Deliverables:** SQL queries + tables + brief insights  
/Images/Phase 4 sample_Top 5 drivers by number of completed trips.png
/Images/Phase 4 sample_Monthly performance metrics across drivers.png


### **Phase 5 – Vehicle Maintenance Analysis**
- Maintenance events count by truck/trailer  
- Average downtime per maintenance type  
- Fuel purchase patterns by truck  
- Truck utilization rates across facilities  
- **Deliverables:** SQL queries + tables + insights on fleet performance
  /Images/Phase 5 sample_Fuel purchase patterns by truck.png
/Images/Phase 5 sample_Count maintenance events by truck or trailer.png
 

### **Phase 6 – Route Analysis**
- Delivery outcomes by route (on-time vs delayed)  
- Average distance & duration per route (via load → route join)  
- Most frequent routes by load count  
- **Deliverables:** SQL queries + tables + interpretation
  /Images/Phase 6 sample_Delivery outcomes by route (on-time vs delayed).png

### **Phase 7 – Multi-Table Analytical Queries**
- Join trips, delivery events, and loads for integrated insights  
- Combine customer locations with route performance (origin_city/state from routes)  
- Analyze delivery performance by customer segment  
- **Deliverables:** SQL queries + integrated tables + insights
  /Images/Phase 7 sample_Multi-Table Analytical Queries.png

### **Phase 8 – Window Function Application**
- Rank drivers by delivery success rate  
- Rank trucks by utilization  
- Compare monthly performance trends (cumulative trips, moving averages)  
- **Deliverables:** SQL queries + tables + insights  
/Images/Phase 8 sample_ Rank drivers by delivery success rate.png

### **Phase 9 – Conditional Logic & Operational Classification**
- Categorize deliveries by timeliness: On Schedule / Slight Delay / Major Delay  
- Classify truck utilization: High / Medium / Low  
- Tag drivers by safety incident rate: Low / Medium / High Risk  
- **Deliverables:** SQL queries using CASE + tables showing categories  
/Images/Phase 9 sample_Conditional Logic and Operational Classification.png
/Images/Phase 9 sample_Conditional Logic and Operational Classification.png

### **Phase 10 – Reporting & Business Insights**
- Top 10 drivers by on-time delivery performance  
- Trucks with highest maintenance downtime  
- Routes with best and worst delivery services  
- Impact of driver performance on customer satisfaction  
- **Deliverables:** Final reporting queries, clean output for dashboards, written insights  
/Images/Phase 10. Reporting and Business Insight.png
/Images/Phase 10_Reporting and Business Insight.png


---

## 🛠 SQL Techniques Used
- SELECT statements  
- WHERE filtering  
- GROUP BY & HAVING  
- INNER JOIN & multiple table joins  
- Aggregate functions: SUM, COUNT, AVG  
- CASE statements for classification  
- Subqueries & nested queries  
- Window functions: RANK, DENSE_RANK, moving averages  
- Date grouping and formatting  

---

## 📊 Key Insights (Example)
- Top 5 drivers contributed X% of total revenue  
- Certain routes consistently have higher on-time rates  
- Older trucks show higher maintenance cost per mile  
- High-value customers experience higher service reliability  

---

## 🚀 Tools Used
- MySQL Workbench  
- SQL  
- CSV files for raw data  
- GitHub for version control & documentation  

---

## 📌 Conclusion

This analysis provides actionable operational insights into fleet performance, driver productivity, cost efficiency, and service reliability. The findings support strategic decisions related to route planning, maintenance scheduling, driver performance management, and customer prioritization.
