--- Phase 1: Database Setup Expectations
CREATE DATABASE logistics_db;
USE logistics_db;
SHOW TABLES;

--- PHASE 2: Data Understanding & Validation
-- Table confirmation
	-- 1. customers
SELECT COUNT(*) FROM customers;
SELECT * FROM customers LIMIT 5;
	-- 2. drivers
SELECT COUNT(*) FROM drivers;
SELECT * FROM drivers LIMIT 5;
	-- 3. trucks
SELECT COUNT(*) FROM trucks;
SELECT * FROM trucks LIMIT 5;
	-- 4. trailers
SELECT COUNT(*) FROM trailers;
SELECT * FROM trailers LIMIT 5;
	-- 5. facilities
SELECT COUNT(*) FROM facilities;
SELECT * FROM facilities LIMIT 5;
	-- 6. routes
SELECT COUNT(*) FROM routes;
SELECT * FROM routes LIMIT 5;
	-- 7. loads
SELECT COUNT(*) FROM loads;
SELECT * FROM loads;
	-- 8. trips
SELECT COUNT(*) FROM trips;
SELECT * FROM trips LIMIT 5;
	-- 9. fuel_purchases
SELECT COUNT(*) FROM fuel_purchases;
SELECT * FROM fuel_purchases LIMIT 5;
	-- 10. maintenance_records
SELECT COUNT(*) FROM maintenance_records;
SELECT * FROM maintenance_records LIMIT 5;
	-- 11. delivery_events
SELECT COUNT(*) FROM delivery_events;
SELECT * FROM delivery_events LIMIT 5;
	-- 12. safety_incidents
SELECT COUNT(*) FROM safety_incidents;
SELECT * FROM safety_incidents LIMIT 5;

-- Aggregated tables
	-- 13. driver_monthly_metrics
SELECT COUNT(*) FROM driver_monthly_metrics;
SELECT * FROM driver_monthly_metrics LIMIT 5;
	-- 14. truck_utilization_metrics
SELECT COUNT(*) FROM truck_utilization_metrics;
SELECT * FROM truck_utilization_metrics LIMIT 5;

-- data validation
DESCRIBE customers;
DESCRIBE delivery_events;
DESCRIBE trips;
DESCRIBE drivers;
SELECT revenue
FROM loads
LIMIT 5;



--- Phase 3: Foundational Analysis Tasks
	-- 1. Total revenue from loads
SELECT SUM(revenue) FROM loads;

	-- 2. Total number of trucks and trailers
SELECT COUNT(*) FROM trucks;
SELECT COUNT(*) FROM trailers;

	-- 3. Number of drivers and customers
SELECT COUNT(*) FROM drivers;
SELECT COUNT(*) FROM customers;

	-- 4. Count of completed trips
SELECT COUNT(*) FROM trips WHERE trip_status = 'completed';

	-- Delivery event outcomes (on time, delayed, failed)
SELECT on_time_flag, COUNT(*) FROM delivery_events
GROUP BY on_time_flag; 



-- Phase 4: Driver and Performance Analysis

-- Top drivers by number of completed trips
SELECT 
	driver_id, 
    COUNT(*) AS completed_trips
FROM trips
WHERE trip_status = 'Completed'
GROUP BY driver_id
ORDER BY completed_trips DESC
LIMIT 5
OFFSET 1;

-- Monthly performance metrics across drivers
SELECT 
    report_month,
    AVG(trips_completed) AS avg_trips,
    AVG(total_miles) AS avg_miles,
    AVG(total_revenue) AS avg_revenue,
    AVG(on_time_delivery_rate) AS avg_on_time_rate
FROM driver_monthly_metrics
GROUP BY report_month
ORDER BY report_month;

-- Safety incident count by driver
SELECT 
    driver_id,
    COUNT(*) AS incident_count
FROM safety_incidents
GROUP BY driver_id
ORDER BY incident_count DESC;

-- Average delivery time per driver
SELECT 
    driver_id,
    AVG(actual_duration_hours) AS avg_delivery_time_hours
FROM trips
WHERE trip_status = 'Completed'
GROUP BY driver_id
ORDER BY avg_delivery_time_hours;



--- Phase 5: Vehicle and Maintenance Analysis

-- Count maintenance events by truck
SELECT 
    truck_id,
    COUNT(*) AS maintenance_events
FROM maintenance_records
GROUP BY truck_id
ORDER BY maintenance_events DESC;

-- Average downtime per maintenance type
SELECT 
    maintenance_type,
    AVG(downtime_hours) AS avg_downtime
FROM maintenance_records
GROUP BY maintenance_type
ORDER BY avg_downtime DESC;

-- Fuel purchase patterns by truck
SELECT 
    truck_id,
    SUM(gallons) AS total_gallons,
    SUM(total_cost) AS total_cost,
    AVG(price_per_gallon) AS avg_price_per_gallon
FROM fuel_purchases
GROUP BY truck_id
ORDER BY total_cost DESC;


-- Truck utilization rates across facilities
SELECT 
    truck_id,
    AVG(utilization_rate) AS avg_utilization
FROM truck_utilization_metrics
GROUP BY truck_id
ORDER BY avg_utilization DESC;



--- Phase 6: Route Analysis

-- Delivery outcomes by route (on-time vs delayed)
SELECT 
    l.route_id,
    SUM(CASE WHEN d.on_time_flag = 'TRUE' THEN 1 ELSE 0 END) AS on_time_deliveries,
    SUM(CASE WHEN d.on_time_flag = 'FALSE' THEN 1 ELSE 0 END) AS delayed_deliveries
FROM delivery_events d
JOIN loads l ON d.load_id = l.load_id
GROUP BY l.route_id
ORDER BY on_time_deliveries DESC;


-- Average distance and duration per route
SELECT 
    l.route_id,
    AVG(t.actual_distance_miles) AS avg_distance,
    AVG(t.actual_duration_hours) AS avg_duration
FROM trips t
JOIN loads l ON t.load_id = l.load_id
GROUP BY l.route_id
ORDER BY avg_duration DESC;


-- Most frequent routes by load count
SELECT 
    route_id,
    COUNT(load_id) AS total_loads
FROM loads
GROUP BY route_id
ORDER BY total_loads DESC;



--- Phase 7: Multi-Table Analytical Queries

-- Join trips with delivery events and loads
SELECT 
    t.trip_id,
    t.driver_id,
    t.truck_id,
    l.load_id,
    l.route_id,
    d.event_type,
    d.on_time_flag
FROM trips t
JOIN loads l ON t.load_id = l.load_id
JOIN delivery_events d ON t.trip_id = d.trip_id;

-- Combine customer locations with route performance
SELECT 
    c.customer_id,
    c.customer_name,
    r.origin_city AS customer_city,
    r.origin_state AS customer_state,
    l.route_id,
    SUM(CASE WHEN d.on_time_flag = 'TRUE' THEN 1 ELSE 0 END) AS on_time_deliveries,
    SUM(CASE WHEN d.on_time_flag = 'FALSE' THEN 1 ELSE 0 END) AS delayed_deliveries,
    COUNT(*) AS total_deliveries
FROM customers c
JOIN loads l ON c.customer_id = l.customer_id
JOIN routes r ON l.route_id = r.route_id
JOIN trips t ON l.load_id = t.load_id
JOIN delivery_events d ON t.trip_id = d.trip_id
GROUP BY 
    c.customer_id,
    c.customer_name,
    r.origin_city,
    r.origin_state,
    l.route_id
ORDER BY c.customer_id, l.route_id;

-- Analyze delivery success by customer segment
SELECT 
    c.customer_type,
    SUM(CASE WHEN d.on_time_flag = 'TRUE' THEN 1 ELSE 0 END) AS on_time_deliveries,
    SUM(CASE WHEN d.on_time_flag = 'FALSE' THEN 1 ELSE 0 END) AS delayed_deliveries,
    COUNT(*) AS total_deliveries
FROM customers c
JOIN loads l ON c.customer_id = l.customer_id
JOIN trips t ON l.load_id = t.load_id
JOIN delivery_events d ON t.trip_id = d.trip_id
GROUP BY c.customer_type;



--- Phase 8: Window Function Application

-- Rank drivers by delivery success rate
SELECT 
    driver_id,
    SUM(CASE WHEN d.on_time_flag = 'TRUE' THEN 1 ELSE 0 END) AS on_time_deliveries,
    COUNT(*) AS total_deliveries,
    RANK() OVER (ORDER BY SUM(CASE WHEN d.on_time_flag = 'TRUE' THEN 1 ELSE 0 END)/COUNT(*) DESC) AS delivery_success_rank
FROM trips t
JOIN delivery_events d ON t.trip_id = d.trip_id
GROUP BY driver_id;

-- Rank trucks by utilization
SELECT 
    truck_id,
    AVG(utilization_rate) AS avg_utilization,
    RANK() OVER (ORDER BY AVG(utilization_rate) DESC) AS utilization_rank
FROM truck_utilization_metrics
GROUP BY truck_id;

-- Compare monthly performance trends using window functions
SELECT 
    driver_id,
    report_month,
    trips_completed,
    SUM(trips_completed) OVER (PARTITION BY driver_id ORDER BY report_month) AS cumulative_trips,
    AVG(trips_completed) OVER (PARTITION BY driver_id ORDER BY report_month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_trips
FROM driver_monthly_metrics;



--- Phase 9: Conditional Logic and Operational Classification

-- Classify truck utilization into high, medium, low bands
SELECT 
    truck_id,
    CASE 
        WHEN utilization_rate >= 0.8 THEN 'High'
        WHEN utilization_rate >= 0.5 THEN 'Medium'
        ELSE 'Low'
    END AS utilization_category
FROM truck_utilization_metrics;

-- Tag drivers based on safety incident rates
SELECT 
    driver_id,
    CASE 
        WHEN COUNT(*) >= 5 THEN 'High Risk'
        WHEN COUNT(*) BETWEEN 2 AND 4 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS safety_category
FROM safety_incidents
GROUP BY driver_id;


--- Phase 10: Reporting and Business Insight Questions

-- Top 10 drivers by on-time delivery performance
SELECT 
    driver_id,
    SUM(CASE WHEN on_time_flag = 'TRUE' THEN 1 ELSE 0 END)/COUNT(*) AS on_time_rate
FROM trips t
JOIN delivery_events d ON t.trip_id = d.trip_id
GROUP BY driver_id
ORDER BY on_time_rate DESC
LIMIT 10;

-- Trucks with highest maintenance downtime
SELECT 
    truck_id,
    SUM(downtime_hours) AS total_downtime
FROM maintenance_records
GROUP BY truck_id
ORDER BY total_downtime DESC
LIMIT 10;

-- Routes with best and worst delivery success
SELECT 
    l.route_id,
    SUM(CASE WHEN d.on_time_flag = 'TRUE' THEN 1 ELSE 0 END)/COUNT(*) AS on_time_rate
FROM trips t
JOIN loads l ON t.load_id = l.load_id
JOIN delivery_events d ON t.trip_id = d.trip_id
GROUP BY l.route_id
ORDER BY on_time_rate DESC;

-- Impact of driver performance on customer satisfaction
SELECT 
    c.customer_id,
    c.customer_name,
    AVG(CASE WHEN d.on_time_flag = 'TRUE' THEN 1 ELSE 0 END) AS customer_on_time_rate
FROM customers c
JOIN loads l ON c.customer_id = l.customer_id
JOIN trips t ON l.load_id = t.load_id
JOIN delivery_events d ON t.trip_id = d.trip_id
GROUP BY c.customer_id, c.customer_name
ORDER BY customer_on_time_rate DESC;


SELECT DISTINCT on_time_flag FROM delivery_events;
