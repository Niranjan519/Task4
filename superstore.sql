
-- Task 4: SQL for Data Analysis (Superstore Dataset)

-- 1. DATABASE SETUP
CREATE TABLE superstore (
    Row_ID INT,
    Order_ID VARCHAR(20),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(20),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Postal_Code VARCHAR(20),
    Region VARCHAR(50),
    Product_ID VARCHAR(20),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name TEXT,
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(10,2)
);


LOAD DATA INFILE '/path/to/Superstore.csv'
INTO TABLE superstore
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- 2. ANALYTICAL QUERIES

-- a. Use SELECT, WHERE, ORDER BY, GROUP BY
-- QUERY 1: Calculate total Sales and Profit for each Region,
-- showing only high-volume regions and ordering by Profit.
SELECT
    Region,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM
    Superstore_Orders
WHERE
    Category = 'Technology' -- Filter data (WHERE)
GROUP BY
    Region                      -- Group results (GROUP BY)
HAVING
    SUM(Sales) > 100000         -- Filter grouped results (HAVING)
ORDER BY
    Total_Profit DESC;          -- Order results (ORDER BY)


-- b. Use JOINS (Self-JOIN for a flat file)
-- QUERY 2: Find the Customer Names who have purchased from BOTH 'Technology' and 'Furniture' categories.
SELECT DISTINCT
    T1.Customer_Name
FROM
    Superstore_Orders AS T1
INNER JOIN                          -- INNER JOIN
    Superstore_Orders AS T2
    ON T1.Customer_ID = T2.Customer_ID -- Join on Customer ID
WHERE
    T1.Category = 'Technology'
    AND T2.Category = 'Furniture';


-- c. Write subqueries
-- QUERY 3: Find the average Sales of orders whose Profit is above the overall average Profit.
SELECT
    AVG(Sales) AS Avg_Sales_for_High_Profit_Orders
FROM
    Superstore_Orders
WHERE
    Profit > (SELECT AVG(Profit) FROM Superstore_Orders); -- Subquery finds the global average profit


-- d. Use aggregate functions (SUM, AVG, MIN, MAX)
-- QUERY 4: Identify the Top 5 States with the largest total loss (negative profit).
SELECT
    State,
    SUM(Profit) AS Total_Profit_Loss
FROM
    Superstore_Orders
GROUP BY
    State
HAVING
    SUM(Profit) < 0 -- Ensure we only look at states with a loss
ORDER BY
    Total_Profit_Loss ASC -- Ascending order puts largest losses (most negative) at the top
LIMIT 5;


-- e. Create views for analysis
-- QUERY 5: Create a view for easy Year/Quarter performance tracking.
CREATE VIEW V_Quarterly_Performance AS
SELECT
    YEAR(Order_Date) AS Order_Year,
    CONCAT('Q', QUARTER(Order_Date)) AS Order_Quarter,
    Category,
    SUM(Sales) AS Quarterly_Sales,
    SUM(Profit) AS Quarterly_Profit
FROM
    Superstore_Orders
GROUP BY
    Order_Year, Order_Quarter, Category;

-- Example use of the View
SELECT * FROM V_Quarterly_Performance WHERE Order_Year = 2014;


-- f. Optimize queries with indexes
-- QUERY 6: Create Indexes on commonly filtered/joined columns to improve query performance.
CREATE INDEX idx_customer_id ON Superstore_Orders (Customer_ID);
CREATE INDEX idx_category_profit ON Superstore_Orders (Category, Profit); -- Used for filtering by category and ordering/aggregating profit
CREATE INDEX idx_region ON Superstore_Orders (Region);
