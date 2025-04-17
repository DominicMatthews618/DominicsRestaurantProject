--KPI’s
--Total Revenue
SELECT SUM(total_price) AS Total_Revenue FROM DominicRestuarant_test

--Average Order Value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_order_Value FROM DominicRestuarant_test
 
 --Total Food Sold
SELECT SUM(quantity) AS Total_food_sold FROM DominicRestuarant_test
 
 --Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM DominicRestuarant_test
 
--Average Menu Items Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2))
AS Avg_Menu_Items_per_order
FROM DominicRestuarant_test
 
 -------------------------------------------------------------------------------------------------------------
--Hourly Trend for Total Menu Items Sold
/*SELECT DATEPART(HOUR, order_time) as order_hours, SUM(quantity) as total_menu_items_sold
from DominicRestuarant_test
group by DATEPART(HOUR, order_time)
order by DATEPART(HOUR, order_time)*/

SELECT 
    CASE 
        WHEN DATEPART(HOUR, CAST(order_time AS TIME)) = 0 THEN '12 AM'
        WHEN DATEPART(HOUR, CAST(order_time AS TIME)) < 12 THEN 
            CAST(DATEPART(HOUR, CAST(order_time AS TIME)) AS VARCHAR) + ' AM'
        WHEN DATEPART(HOUR, CAST(order_time AS TIME)) = 12 THEN '12 PM'
        ELSE 
            CAST(DATEPART(HOUR, CAST(order_time AS TIME)) - 12 AS VARCHAR) + ' PM'
    END AS order_hours,
    SUM(quantity) AS total_menu_items_sold
FROM DominicRestuarant_test
GROUP BY 
    CASE 
        WHEN DATEPART(HOUR, CAST(order_time AS TIME)) = 0 THEN '12 AM'
        WHEN DATEPART(HOUR, CAST(order_time AS TIME)) < 12 THEN 
            CAST(DATEPART(HOUR, CAST(order_time AS TIME)) AS VARCHAR) + ' AM'
        WHEN DATEPART(HOUR, CAST(order_time AS TIME)) = 12 THEN '12 PM'
        ELSE 
            CAST(DATEPART(HOUR, CAST(order_time AS TIME)) - 12 AS VARCHAR) + ' PM'
    END
ORDER BY MIN(DATEPART(HOUR, CAST(order_time AS TIME)))

 

--Weekly Trend for Orders
SELECT 
    DATEPART(ISO_WEEK, order_date) AS WeekNumber,
    YEAR(order_date) AS Year,
    COUNT(DISTINCT order_id) AS Total_orders
FROM 
    DominicRestuarant_test
GROUP BY 
    DATEPART(ISO_WEEK, order_date),
    YEAR(order_date)
ORDER BY 
    Year, WeekNumber;

          

-- % of Sales by Menu Category
SELECT menu_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from DominicRestuarant_test) AS DECIMAL(10,2)) AS PCT
FROM DominicRestuarant_test
GROUP BY menu_category

 
-- % of Sales by Menu Type
SELECT menu_type, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from DominicRestuarant_test) AS DECIMAL(10,2)) AS PCT
FROM DominicRestuarant_test
GROUP BY menu_type
ORDER BY menu_type

 

--Total Menu Items Sold by Menu Category
SELECT menu_category, SUM(quantity) as Total_Quantity_Sold
FROM DominicRestuarant_test
WHERE MONTH(order_date) = 2
GROUP BY menu_category
ORDER BY Total_Quantity_Sold DESC
-------------------------------------------------------------------------------
--Top 5 Menu Items by Revenue
SELECT Top 5 food_name, SUM(total_price) AS Total_Revenue
FROM DominicRestuarant_test
GROUP BY food_name
ORDER BY Total_Revenue DESC
 
--Bottom 5 Menu Items by Revenue
SELECT Top 5 food_name, SUM(total_price) AS Total_Revenue
FROM DominicRestuarant_test
GROUP BY food_name
ORDER BY Total_Revenue ASC
 
--Top 5 Menu Items by Quantity
SELECT Top 5 food_name, SUM(quantity) AS Total_Sold
FROM DominicRestuarant_test
GROUP BY food_name
ORDER BY Total_Sold DESC

--Bottom 5 Menu Items by Quantity
SELECT TOP 5 food_name, SUM(quantity) AS Total_Sold
FROM DominicRestuarant_test
GROUP BY food_name
ORDER BY Total_Sold ASC

 
--Top 5 Menu Items by Total Orders
SELECT Top 5 food_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM DominicRestuarant_test
GROUP BY food_name
ORDER BY Total_Orders DESC
 
--Bottom 5 Menu Items by Total Orders
SELECT Top 5 food_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM DominicRestuarant_test
GROUP BY food_name
ORDER BY Total_Orders ASC



