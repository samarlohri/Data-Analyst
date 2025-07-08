create database uber;

use uber;
select * from new_uber_data;

-- 1.total request by status
SELECT Status, COUNT(*) AS Total_Requests
FROM new_uber_data
GROUP BY Status;

-- 2. Request by pickuppoint
SELECT Pickup_point, COUNT(*) AS Total_Requests
FROM new_uber_data
GROUP BY Pickup_point;

-- 3. hourly demand
SELECT HOUR(Request_timestamp) AS Hour, COUNT(*) AS Total_Requests
FROM new_uber_data
GROUP BY Hour
ORDER BY Hour;

-- 4 suppy vs demand

SELECT 
  HOUR(Request_timestamp) AS Hour,
  COUNT(*) AS Total_Requests,
  SUM(CASE WHEN Status = 'Trip Completed' THEN 1 ELSE 0 END) AS Completed_Trips,
  ROUND(
    SUM(CASE WHEN Status = 'Trip Completed' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 
    2
  ) AS Fulfillment_Rate
FROM new_uber_data
GROUP BY Hour;

-- 5. status distribution by pickup point'
SELECT Pickup_point, Status, COUNT(*) AS Count
FROM new_uber_data
GROUP BY Pickup_point, Status;

-- 6. day wise analysis
 SELECT Day, COUNT(*) AS Total_Requests
FROM new_uber_data
GROUP BY Day
ORDER BY Total_Requests DESC;