SELECT * FROM Sales;

-- 1.Total Sales by Month

SELECT Month ,SUM(Sales) as total_sale 
FROM Sales 
GROUP BY Month 
ORDER BY Month ASC ; 


-- 2. Top 5 Selling Products by Quantity

SELECT TOP 5 Product, SUM([Quantity Ordered]) AS Total_Quantity
FROM Sales
GROUP BY Product
ORDER BY Total_Quantity DESC;


-- 3. Total Sales by City

SELECT City ,SUM(Sales) as Total_Sales
FROM Sales
GROUP BY City;


-- 4. Peak Purchase Hours

SELECT Product , Count(Hour) as Times
FROM Sales
GROUP BY Product , Hour 
Order BY Times DESC;

-- 5. Best Sales Day for Each Product

SELECT Product , [Order Date] , SUM(Sales) as Total_Sales  FROM Sales
GROUP BY Product , [Order Date],Sales
ORDER BY Sales DESC;



-- 6.  Average Order Value by City

SELECT  City  , AVG([Quantity Ordered])  as Average_Order 
FROM Sales
GROUP BY City ;


--7. Monthly Growth in Sales



WITH MonthlySales AS (
    SELECT 
        [Month], 
        SUM(Sales) AS Total_SalesPerMonth
    FROM Sales
    GROUP BY [Month]
)


SELECT 
    [Month],
    Total_SalesPerMonth,
    Total_SalesPerMonth - LAG(Total_SalesPerMonth) OVER (ORDER BY [Month]) AS Growth_Sales
FROM MonthlySales
ORDER BY [Month] DESC;


-- 8. Most Popular Product in Each City

SELECT 
    Product, 
    City, 
    SUM([Quantity Ordered]) AS Total_Order
FROM Sales
GROUP BY Product, City
ORDER BY Total_Order DESC;


-- 9 . Top 3 Cities by Number of Orders

SELECT TOP 3 City , [Quantity Ordered] , COUNT([Quantity Ordered]) as Total_Order FROM Sales
GROUP BY City ,[Quantity Ordered] 
ORDER BY [Quantity Ordered] ;




-- 10. Product with Highest Revenue
SELECT TOP 3 Product , SUM(Sales) as Total_Revenue  FROM Sales
GROUP BY Product 
ORDER BY Total_Revenue DESC;




-- 11. Hour with Least Sales
SELECT Hour , SUM(Sales) as Total_sales
FROM Sales
GROUP BY Hour
ORDER BY Total_sales ASC;



-- 12. Percentage of Sales by City

SELECT
    City,
    ROUND(
        SUM(Sales) * 100.0
        / SUM(SUM(Sales)) OVER ()   
    , 2) AS Sales_Percentage
FROM Sales
GROUP BY City
ORDER BY Sales_Percentage DESC;
