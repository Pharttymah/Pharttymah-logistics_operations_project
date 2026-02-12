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

## 📊 Key Insights

- Top 5 drivers contributed X% of total revenue.  
- Route A → B generated the highest margin.  
- Average fuel efficiency was X MPG.  
- Trucks older than X years showed higher maintenance cost per mile.  
- Overall on-time delivery rate was X%.  
- Customer X contributed the highest revenue share.  

*(Update with actual findings after query execution.)*

---

## 🚀 Tools Used

- MySQL Workbench  
- SQL  
- CSV data files  
- GitHub for documentation  

---

## 📌 Conclusion

This analysis provides actionable operational insights into fleet performance, driver productivity, cost efficiency, and service reliability. The findings support strategic decisions related to route planning, maintenance scheduling, driver performance management, and customer prioritization.
