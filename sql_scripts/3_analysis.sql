-- ANALYSIS

-- 1) SALES BY MONTH

-- First attempt
WITH Monthly_Rev AS (
	SELECT 
		Month_name, 
		ROUND(SUM(Money), 2) AS Monthly_Revenue
	FROM sales
	GROUP BY Month_name
)	
SELECT 
	ROW_NUMBER() OVER(ORDER BY Monthly_Revenue DESC) AS `Rank`, 
	Month_name, 
    Monthly_Revenue 
FROM Monthly_Rev
ORDER BY Monthly_Revenue DESC;    -- March seems to be an outlier


-- checking if the the dates are evenly distributed
SELECT MIN(`Date`), MAX(`Date`)
FROM sales; -- the entries start on 3/1/2024 and end on 3/23/2025, which means March is being counted twice

-- New monthly revenue, only counting the year between 3/2024 - 2/2025
WITH Monthly_Rev AS (
	SELECT 
		Month_name, 
		ROUND(SUM(Money), 2) AS Monthly_Revenue
	FROM sales
    WHERE `Date` < '2025-03-01'
	GROUP BY Month_name
)	
SELECT 
	ROW_NUMBER() OVER(ORDER BY Monthly_Revenue DESC) AS `Rank`, 
	Month_name, 
    Monthly_Revenue 
FROM Monthly_Rev
ORDER BY Monthly_Revenue DESC;     -- Now every month is counted only once. March went from 1st to 11th on the list!





-- 2) SALES BY WEEKDAY

-- first CTE > Group all the sales from each day
WITH Dayly_Revenue AS (
		SELECT 
			`Weekday`,
			`Date`,
			SUM(Money) AS Dayly_Sales
        FROM sales
        GROUP BY `Weekday`, `Date`
),

-- second CTE > Group the same weekdays into a "weekday average"
Weekday_Revenue AS (
	SELECT 
		`Weekday`,
        ROUND(AVG(Dayly_Sales), 2) AS Average_Revenue
	FROM Dayly_Revenue
    GROUP BY `Weekday`
)
SELECT 
	ROW_NUMBER() OVER(ORDER BY Average_Revenue DESC) AS `Rank`,
	`Weekday`,
    Average_Revenue
FROM Weekday_Revenue;       -- we can see that weekdays (Mon-Fri) have a much higher Revenue than weekeds.
    
    
    
    
    
-- 3) SALES BY TIME OF DAY (Morning, Afternoon, Night)

-- check the time limits for each "Time_of_Day"
SELECT 
	Time_of_Day,
	MIN(`hour_of_day`),
    MAX(`hour_of_day`)
FROM sales
GROUP BY Time_of_Day; -- Morning = 6-12, Afternoon = 12-17, Night = 17-23


-- first CTE > Group all the sales from each period and each day
WITH Time_of_Day_Rev AS (
		SELECT 
        `Time_of_Day`,
        `Date`,
		SUM(Money) AS Time_of_Day_Sales
        FROM sales
        GROUP BY `Time_of_Day`, `Date`
),

-- second CTE > Group the same periods into a "Time of day average"
Period_Rev AS (
	SELECT 
		`Time_of_Day`,
        ROUND(AVG(Time_of_Day_Sales), 2) AS Average_Revenue
	FROM Time_of_Day_Rev
    GROUP BY `Time_of_Day`
)
SELECT 
	ROW_NUMBER() OVER(ORDER BY Average_Revenue DESC) AS `Rank`,
	`Time_of_Day` Period,
    Average_Revenue
    FROM Period_Rev; 
    


    

-- 4) SALES BY HOUR

-- 4.1) Sales by hour (ranked)
-- first CTE > Group all the sales from each hour and each day of the year
WITH Revenue_by_hour AS (
		SELECT 
        `hour_of_day`,
        `Date`,
		SUM(Money) AS rev_by_hour
        FROM sales
        GROUP BY `hour_of_day`, `Date`
),
-- second CTE > Group every hour into an "hourly sales average"
Hourly_Sales AS (
	SELECT 
		`hour_of_day`,
        ROUND(AVG(rev_by_hour), 2) AS Average_Revenue
	FROM Revenue_by_hour
    GROUP BY `hour_of_day`
)
SELECT 
	ROW_NUMBER() OVER(ORDER BY Average_Revenue DESC) AS `Rank`,
	`hour_of_day` AS `Hour`,
    Average_Revenue
    FROM Hourly_Sales; 
    
    
    
-- 4.2) Sales by hour (time series)

-- CTE > Group all the sales from each hour and each day of the year
WITH Revenue_by_hour AS (
	SELECT 
        `hour_of_day`,
        `Date`,
		SUM(Money) AS rev_by_hour
	FROM sales
	GROUP BY `hour_of_day`, `Date`
)

SELECT 
	`hour_of_day` AS `Hour`,
	ROUND(AVG(rev_by_hour), 2) AS Average_Revenue
FROM Revenue_by_hour
GROUP BY `hour_of_day`
ORDER BY `hour_of_day`;





-- 5) SALES BY COFFEE TYPE

WITH coffee_type AS (
	SELECT
		coffee_name,
        SUM(Money) AS coffee_rev
	FROM sales
    GROUP BY coffee_name
)
SELECT
	ROW_NUMBER() OVER(ORDER BY coffee_rev DESC) AS `Rank`,
    coffee_name,
    ROUND(coffee_rev, 2) AS Total_Sales
FROM coffee_type;
  


