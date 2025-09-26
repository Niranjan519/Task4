# Task 4: SQL for Data Analysis - Superstore Dataset

## Overview
This task involved performing various data analysis operations using SQL on the provided `Superstore.csv` dataset, demonstrating proficiency in foundational to advanced SQL concepts. The objective was to create a script that sets up the database, performs key analyses, and includes performance optimization techniques.

## Deliverables
1.  `superstore.sql`: Contains all MySQL Data Definition Language (DDL) and Data Manipulation Language (DML) commands.
2.  Output Tables: Simulated results for key analytical queries.

## SQL Concepts Demonstrated

The `superstore_analysis.sql` file includes examples as follows

| Concept | Description | Query Reference |
| :--- | :--- | :--- |
| **SELECT, WHERE, GROUP BY, ORDER BY, HAVING** | Fundamental data filtering and aggregation. | Query 1, 4 |
| **JOINS** | Used a **Self-JOIN** (INNER JOIN) on the single `Superstore_Orders` table to find customers who bought from multiple product categories. | Query 2 |
| **Subqueries** | Used a nested `SELECT` statement to calculate the overall average profit, and then filtered orders against that average. | Query 3 |
| **Aggregate Functions** | Used `SUM()` to calculate total sales/profit and `AVG()` for mean calculations. | Query 1, 3, 4, 5 |
| **Views** | Created a virtual table (`V_Quarterly_Performance`) to simplify complex, recurring time-series analysis (Year and Quarter performance). | Query 5 |
| **Indexes** | Created non-clustered indexes on high-cardinality columns (`Customer_ID`) and frequently used filter columns (`Region`, `Category`) to improve query execution speed. | Query 6 |

## Technology Used
* **Database:** MySQL
* **Dataset:** Superstore Sales Data (`Superstore.csv`)
