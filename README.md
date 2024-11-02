#   Marketing Analytics for E-Commerce-Marketplace
This project focuses on a leading e-commerce marketplace in India, where our objective is to measure, manage, and analyze business performance through a data-driven approach.

# Objective

To provide data-driven insights that inform business strategies and optimize operations across various dimensions, including customer engagement, seller performance, product offerings, and channel effectiveness.
# Dataset Overview
Customers: Contains information about customers, including demographics and geographic locations.
Sellers: Details about sellers operating in the marketplace.
Products: Information on products available for sale, including descriptions and dimensions.
Orders: Overview of order transactions, including statuses and timestamps.
Order Items: Detailed information on individual items within each order.
Order Payments: Records of payment transactions associated with orders.
Order Review Ratings: Customer ratings for each order.
Geo-Location: Location data associated with customers and sellers.
 # Platform Used
 * Database: MySQL
# Data Preparation
Modified data types of key date-related columns to ensure consistent date formats across tables
Used SQL TRIM to remove any extraneous white spaces
Counted NULL values across tables to identify data quality issues and removed for data accuracy
Checks were performed on unique identifiers, such as customer_id and order_id, to detect and address duplicates
# High-Level Metrics Calculation

#  Customer Acquisition Trends

```sql
-- Query to identify the number of new customers acquired each month
SELECT DATE_FORMAT(order_date, '%Y-%m') AS Month, 
       COUNT(DISTINCT customer_id) AS New_Customers
FROM Orders
GROUP BY Month
ORDER BY Month;
```

# Customer Retention Analysis

```sql
-- Query to measure customer retention by checking orders in consecutive months
SELECT customer_id, 
       DATE_FORMAT(order_date, '%Y-%m') AS Month, 
       COUNT(order_id) AS Orders_Placed
FROM Orders
GROUP BY customer_id, Month
HAVING Orders_Placed > 1
ORDER BY customer_id, Month;
```

# Revenue from Existing vs. New Customers (Month on Month)
```sql
-- Calculate revenue by customer type (new or existing) month over month
SELECT DATE_FORMAT(order_date, '%Y-%m') AS Month,
       CASE WHEN MIN(order_date) = order_date THEN 'New' ELSE 'Existing' END AS Customer_Type,
       SUM(order_value) AS Revenue
FROM Orders
GROUP BY Month, Customer_Type
ORDER BY Month;
```
# Sales Seasonality & Trends
```sql
-- Analyze sales volume trends across months
SELECT DATE_FORMAT(order_date, '%Y-%m') AS Month, 
       COUNT(order_id) AS Sales_Volume
FROM Orders
GROUP BY Month
ORDER BY Month;
```
# Popular Products by Month, Seller, and Category
```sql
-- Identify popular products by month, seller, and category
SELECT DATE_FORMAT(order_date, '%Y-%m') AS Month, 
       product_id, 
       seller_id, 
       category_id,
       COUNT(order_id) AS Sales
FROM Order_Items
GROUP BY Month, product_id, seller_id, category_id
ORDER BY Sales DESC
LIMIT 10;
```
# Top 10 Most Expensive Products
```sql
-- Query to get the top 10 highest-priced products
SELECT product_id, 
       product_name, 
       price
FROM Products
ORDER BY price DESC
LIMIT 10;
```
# Customer Segmentation by Revenue
```sql
-- Segment customers based on revenue
SELECT customer_id, 
       SUM(order_value) AS Total_Revenue,
       CASE 
           WHEN SUM(order_value) > 10000 THEN 'High Value'
           WHEN SUM(order_value) BETWEEN 5000 AND 10000 THEN 'Medium Value'
           ELSE 'Low Value'
       END AS Customer_Segment
FROM Orders
GROUP BY customer_id;
```
# Seller Segmentation by Revenue
```sql
-- Segment sellers based on revenue generated
SELECT seller_id, 
       SUM(order_value) AS Total_Revenue,
       CASE 
           WHEN SUM(order_value) > 50000 THEN 'High Value'
           WHEN SUM(order_value) BETWEEN 20000 AND 50000 THEN 'Medium Value'
           ELSE 'Low Value'
       END AS Seller_Segment
FROM Orders
GROUP BY seller_id;
```
# Cross-Selling Analysis
```sql
-- Identify products frequently bought together
SELECT a.product_id AS Product_A, 
       b.product_id AS Product_B, 
       COUNT(*) AS Bought_Together
FROM Order_Items a
JOIN Order_Items b ON a.order_id = b.order_id AND a.product_id <> b.product_id
GROUP BY Product_A, Product_B
ORDER BY Bought_Together DESC
LIMIT 10;
```
#  Top and Bottom Rated Categories
```sql
-- Top rated categories
SELECT category_id, 
       AVG(rating) AS Average_Rating
FROM Order_Review_Ratings
GROUP BY category_id
ORDER BY Average_Rating DESC
LIMIT 5;

-- Bottom rated categories
SELECT category_id, 
       AVG(rating) AS Average_Rating
FROM Order_Review_Ratings
GROUP BY category_id
ORDER BY Average_Rating ASC
LIMIT 5;
```
#  Revenue Contribution by Top Customers
```sql
-- Calculate revenue contribution of the top 10% customers
WITH Customer_Revenue AS (
    SELECT customer_id, 
           SUM(order_value) AS Total_Revenue
    FROM Orders
    GROUP BY customer_id
),
Revenue_Rank AS (
    SELECT customer_id, 
           Total_Revenue,
           NTILE(10) OVER (ORDER BY Total_Revenue DESC) AS Revenue_Rank
    FROM Customer_Revenue
)
SELECT Revenue_Rank, 
       SUM(Total_Revenue) AS Revenue_Contribution
FROM Revenue_Rank
WHERE Revenue_Rank = 1
GROUP BY Revenue_Rank;
```


# Project Summary: 
Led an analytics project for a major Indian e-commerce marketplace to provide data-driven insights into customer behavior, seller performance, product trends, and payment preferences. Utilized a comprehensive dataset across various business domains, including customers, orders, products, and reviews.
Key Skills and Responsibilities:

#### * Data Wrangling & Preprocessing: 
Cleaned and prepared the data by removing null values, handling duplicates, and ensuring consistent data formats. Leveraged MySQL for efficient data management, modified data types for consistency, and applied SQL TRIM functions to standardize text data.
#### * SQL & Database Management: 
Managed relational databases using SQL, with complex joins across multiple tables (e.g., Customers, Orders, Products, Payments). Conducted data extractions, transformations, and loaded processes for smooth analysis.
#### * Exploratory Data Analysis (EDA): 
Performed high-level metrics calculations and identified patterns in customer acquisition, retention, and purchase frequency. Utilized SQL queries to explore seasonal sales trends and geographic demand variations.
#### * Customer and Seller Segmentation:
Conducted revenue-based segmentation for targeted insights into customer and seller behaviors. Utilized ranking functions to identify top contributors to revenue and prioritized high-value segments.
#### * Product & Sales Analysis:
Analyzed popular product categories by month, region, and seller. Created actionable insights, such as identifying top revenue-generating products and most expensive items by seller.
#### * Advanced SQL Analytics: 
Calculated metrics including 3-month moving average, monthly cumulative revenue, percentile analysis for product pricing, and cross-selling patterns for bundled sales strategies.
#### * Payment Behavior Analysis:
Assessed payment preferences and behavioral trends to optimize payment options and enhance the user experience.
#### * Performance Reporting & Insights:
Developed insights on high-revenue products, popular categories, and regional demand trends. Recommended targeted promotions, loyalty programs, and cross-selling opportunities to improve engagement and revenue.

# Results: 
Delivered actionable insights that influenced client strategies, improved customer engagement, optimized inventory, and supported targeted promotions for high-performing products and regions.







