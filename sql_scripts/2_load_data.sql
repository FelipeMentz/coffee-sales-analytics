-- check is the data is standardized

SELECT DISTINCT(hour_of_day) 
FROM sales
ORDER BY 1;  -- OK! They work from 6am to 10pm (no duplicate values)

SELECT DISTINCT(cash_type) 
FROM sales; -- Only 1 item returned > all the purchases were paid by card

SELECT DISTINCT(coffee_name) 
FROM sales; -- Ok! 8 different types of coffee.

SELECT DISTINCT(Time_of_Day) 
FROM sales; -- ok

SELECT DISTINCT(Weekday) 
FROM sales; -- Ok! They are open all week long

SELECT Weekday, Weekdaysort
FROM sales
GROUP BY Weekday, Weekdaysort
ORDER BY 2; -- Monday = 1, Sunday = 7. No inconsistencies

-- checking if the open/close times were different on different weekdays
SELECT Weekdaysort, MIN(`Time`), MAX(`Time`) 
FROM sales
GROUP BY Weekdaysort
ORDER BY Weekdaysort; -- Apparently, they have the same working hours across the week

SELECT DISTINCT(Month_name) 
FROM sales; -- ok

SELECT Month_name, Monthsort
FROM sales
GROUP BY Month_name, Monthsort
ORDER BY 2; -- all correct

