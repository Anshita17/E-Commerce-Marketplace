Create database MarketPlace;
use MarketPlace;

-- Check first few rows for each table to understand the structure and contents
SELECT * FROM Customers LIMIT 5;
SELECT * FROM geo_location LIMIT 5;
SELECT * FROM orders LIMIT 5;
SELECT * FROM order_Items LIMIT 5;
SELECT * FROM order_Payments LIMIT 5;
SELECT * FROM order_Review_Ratings LIMIT 5;
SELECT * FROM products LIMIT 5;
SELECT * FROM sellers LIMIT 5;
SET SQL_SAFE_UPDATES = 0;


-- Change Data Types ---
ALTER TABLE Orders
MODIFY COLUMN order_purchase_timestamp DATETIME,
MODIFY COLUMN order_approved_at DATETIME,
MODIFY COLUMN order_delivered_carrier_date DATETIME,
MODIFY COLUMN order_delivered_customer_date DATETIME,
MODIFY COLUMN order_estimated_delivery_date DATETIME;

-- TRIM --


UPDATE Orders
SET 
    order_purchase_timestamp = TRIM(order_purchase_timestamp),
    order_approved_at = TRIM(order_approved_at),
    order_delivered_carrier_date = TRIM(order_delivered_carrier_date),
    order_delivered_customer_date = TRIM(order_delivered_customer_date),
    order_estimated_delivery_date = TRIM(order_estimated_delivery_date);
    -- CHNAGE DATA TYPES --
    
    
UPDATE order_items
SET
    shipping_limit_date = STR_TO_DATE(shipping_limit_date, '%m/%d/%Y %H:%i');
    
ALTER TABLE order_items
MODIFY COLUMN shipping_limit_date DATETIME;
UPDATE order_items
set shipping_limit_date = TRIM(shipping_limit_date);

-- Change DATA TYPES --
UPDATE order_review_ratings
SET
    review_creation_date  = STR_TO_DATE(review_creation_date, '%m/%d/%Y %H:%i'),
    review_answer_timestamp = STR_TO_DATE(review_answer_timestamp, '%m/%d/%Y %H:%i');
ALTER TABLE order_review_ratings
MODIFY COLUMN review_creation_date  DATETIME,
MODIFY COLUMN review_answer_timestamp DATETIME;

UPDATE order_review_ratings
set review_creation_date = TRIM(review_creation_date),
 review_answer_timestamp = TRIM(review_answer_timestamp);
 

 -- Count NULLs in each column for Customers table
SELECT
    COUNT(*) - COUNT(customer_id) AS customer_id_nulls,
    COUNT(*) - COUNT(customer_unique_id) AS customer_unique_id_nulls,
    COUNT(*) - COUNT(customer_zip_code_prefix) AS zip_code_nulls,
    COUNT(*) - COUNT(customer_city) AS city_nulls,
    COUNT(*) - COUNT(customer_state) AS state_nulls
FROM customers;

SELECT 
COUNT(*) - COUNT(geolocation_zip_code_prefix) AS zip_code_prefix_nulls,
count(*) - count(geolocation_lat) AS lat_nulls,
count(*) - count(geolocation_lng) AS lng_nulls,
count(*) - count(geolocation_city) AS city_nulls,
count(*) - count(geolocation_state) AS state_nulls
from geo_location;

SELECT 
    COUNT(*) - COUNT(order_id) AS order_id_nulls,
    COUNT(*) - COUNT(customer_id) AS customer_id_nulls,
    COUNT(*) - COUNT(order_status) AS order_status_nulls,
    COUNT(*) - COUNT(order_purchase_timestamp) AS order_purchase_timestamp_nulls,
    COUNT(*) - COUNT(order_approved_at) AS order_approved_at_nulls,
    COUNT(*) - COUNT(order_delivered_carrier_date) AS order_delivered_carrier_date_nulls,
    COUNT(*) - COUNT(order_delivered_customer_date) AS order_delivered_customer_date_nulls,
    COUNT(*) - COUNT(order_estimated_delivery_date) AS order_estimated_delivery_date_nulls
FROM orders;

SELECT 
    COUNT(*) - COUNT(order_id) AS order_id_nulls,
    COUNT(*) - COUNT(order_item_id) AS order_item_id_nulls,
    COUNT(*) - COUNT(product_id) AS product_id_nulls,
    COUNT(*) - COUNT(seller_id) AS seller_id_nulls,
    COUNT(*) - COUNT(shipping_limit_date) AS shipping_limit_date_nulls,
    COUNT(*) - COUNT(price) AS price_nulls,
    COUNT(*) - COUNT(freight_value) AS freight_value_nulls
FROM Order_Items;

SELECT 
    COUNT(*) - COUNT(order_id) AS order_id_nulls,
    COUNT(*) - COUNT(payment_sequential) AS payment_sequential_nulls,
    COUNT(*) - COUNT(payment_type) AS payment_type_nulls,
    COUNT(*) - COUNT(payment_installments) AS payment_installments_nulls,
    COUNT(*) - COUNT(payment_value) AS payment_value_nulls
FROM Order_Payments;

SELECT 
    COUNT(*) - COUNT(review_id) AS review_id_nulls,
    COUNT(*) - COUNT(order_id) AS order_id_nulls,
    COUNT(*) - COUNT(review_score) AS review_score_nulls,
    COUNT(*) - COUNT(review_creation_date) AS review_creation_date_nulls,
    COUNT(*) - COUNT(review_answer_timestamp) AS review_answer_time_nulls
FROM order_review_ratings;

SELECT 
    COUNT(*) - COUNT(product_id) AS product_id_nulls,
    COUNT(*) - COUNT(product_category_name) AS product_category_name_nulls,
    COUNT(*) - COUNT(product_name_lenght) AS product_name_length_nulls,
    COUNT(*) - COUNT(product_description_lenght) AS product_description_length_nulls,
    COUNT(*) - COUNT(product_photos_qty) AS product_photos_qty_nulls,
    COUNT(*) - COUNT(product_weight_g) AS product_weight_g_nulls,
    COUNT(*) - COUNT(product_length_cm) AS product_length_cm_nulls,
    COUNT(*) - COUNT(product_height_cm) AS product_height_cm_nulls,
    COUNT(*) - COUNT(product_width_cm) AS product_width_cm_nulls
FROM Products;

SELECT 
    COUNT(*) - COUNT(seller_id) AS seller_id_nulls,
    COUNT(*) - COUNT(seller_zip_code_prefix) AS seller_zip_code_prefix_nulls,
    COUNT(*) - COUNT(seller_city) AS seller_city_nulls,
    COUNT(*) - COUNT(seller_state) AS seller_state_nulls
FROM Sellers;

-- Check for duplicate customer_id in Customers table
SELECT customer_id, COUNT(*) AS count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT 
    customer_id, 
    customer_unique_id, 
    customer_zip_code_prefix, 
    customer_city, 
    customer_state, 
    COUNT(*) AS count
FROM Customers
GROUP BY 
    customer_id, 
    customer_unique_id, 
    customer_zip_code_prefix, 
    customer_city, 
    customer_state
HAVING COUNT(*) > 1;

SELECT 
    order_id, 
    customer_id, 
    order_status, 
    order_purchase_timestamp, 
    order_approved_at, 
    order_delivered_carrier_date, 
    order_delivered_customer_date, 
    order_estimated_delivery_date, 
    COUNT(*) AS count
FROM Orders
GROUP BY 
    order_id, 
    customer_id, 
    order_status, 
    order_purchase_timestamp, 
    order_approved_at, 
    order_delivered_carrier_date, 
    order_delivered_customer_date, 
    order_estimated_delivery_date
HAVING COUNT(*) > 1;


SELECT 
    review_id, 
    order_id, 
    review_score, 
    review_creation_date, 
    review_answer_timestamp, 
    COUNT(*) AS count
FROM order_review_ratings
GROUP BY 
    review_id, 
    order_id, 
    review_score, 
    review_creation_date, 
    review_answer_timestamp
HAVING COUNT(*) > 1;

SELECT 
    product_id, 
    product_category_name, 
    product_name_lenght, 
    product_description_lenght, 
    product_photos_qty, 
    product_weight_g, 
    product_length_cm, 
    product_height_cm, 
    product_width_cm, 
    COUNT(*) AS count
FROM Products
GROUP BY 
    product_id, 
    product_category_name, 
    product_name_lenght, 
    product_description_lenght, 
    product_photos_qty, 
    product_weight_g, 
    product_length_cm, 
    product_height_cm, 
    product_width_cm
HAVING COUNT(*) > 1;

SELECT 
    seller_id, 
    seller_zip_code_prefix, 
    seller_city, 
    seller_state, 
    COUNT(*) AS count
FROM Sellers
GROUP BY 
    seller_id, 
    seller_zip_code_prefix, 
    seller_city, 
    seller_state
HAVING COUNT(*) > 1;



-- Check statistics for price in Order_Items
SELECT
    MIN(price) AS min_price,
    MAX(price) AS max_price,
    AVG(price) AS avg_price
FROM Order_Items;


-- Check statistics for freight_value in Order_Items
SELECT
    MIN(freight_value) AS min_freight,
    MAX(freight_value) AS max_freight,
    AVG(freight_value) AS avg_freight
FROM Order_Items;

-- Check statistics for payment_value in Order_Payments
SELECT
    MIN(payment_value) AS min_payment,
    MAX(payment_value) AS max_payment,
    AVG(payment_value) AS avg_payment
FROM Order_Payments;

-- Total Revenue --
SELECT SUM(payment_value) AS total_revenue FROM Order_Payments;
-- Total quantity  --
SELECT SUM(order_item_id) AS total_quantity FROM Order_Items;
-- Total Products --
SELECT COUNT(DISTINCT product_id) AS total_products FROM Products;

-- Total Categories
SELECT COUNT(DISTINCT product_category_name) AS total_categories FROM Products;

-- Total Sellers
SELECT COUNT(DISTINCT seller_id) AS total_sellers FROM Sellers;

-- Total Locations (using zip code as a proxy for unique locations)
SELECT COUNT(DISTINCT geolocation_zip_code_prefix) AS total_locations FROM Geo_Location;

-- Total PAyment methods 

SELECT COUNT(DISTINCT payment_type) AS total_payment_methods FROM Order_Payments;


-- 1. Customer Acquisition Trends --
SELECT
    DATE_FORMAT(order_purchase_timestamp, '%m') AS month,
    DATE_FORMAT(order_purchase_timestamp, '%Y') AS year,
    COUNT(DISTINCT customer_id) AS new_customers
FROM Orders
GROUP BY year, month
ORDER BY year, month;
-- 2. Customer Retention Analysis --
WITH MonthlyOrders AS (
    SELECT 
        customer_id,
        DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS order_month
    FROM Orders
    GROUP BY customer_id, order_month
),
RetainedCustomers AS (
    SELECT 
        order_month,
        COUNT(DISTINCT customer_id) AS retained_customers
    FROM MonthlyOrders
    GROUP BY order_month
)
SELECT * FROM RetainedCustomers ORDER BY order_month;






-- 3. Revenue from Existing vs. New Customers (Month on Month) --
    
WITH FirstOrder AS (
    SELECT 
        customer_id,
        MIN(DATE_FORMAT(order_purchase_timestamp, '%Y-%m')) AS first_order_month
    FROM Orders
    GROUP BY customer_id
),
MonthlyRevenue AS (
    SELECT 
        DATE_FORMAT(O.order_purchase_timestamp, '%Y-%m') AS order_month,
        CASE 
            WHEN F.first_order_month = DATE_FORMAT(O.order_purchase_timestamp, '%Y-%m') 
            THEN 'New' 
            ELSE 'Existing' 
        END AS customer_type,
        SUM(OI.price) AS revenue
    FROM Orders O
    JOIN Order_Items OI ON O.order_id = OI.order_id
    JOIN FirstOrder F ON O.customer_id = F.customer_id
    GROUP BY order_month, customer_type
)
SELECT * FROM MonthlyRevenue ORDER BY order_month, customer_type;

-- 4. Sales Seasonality & Trends --

SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS month,
    DATE_FORMAT(order_purchase_timestamp, '%W') AS day_of_week,
    DATE_FORMAT(order_purchase_timestamp, '%H') AS hour,
    SUM(OI.price) AS total_sales
FROM Orders O
JOIN Order_Items OI ON O.order_id = OI.order_id
GROUP BY month, day_of_week, hour
ORDER BY month, day_of_week, hour;



-- 5. Popular Products and Categories --
-- Popular Products by Month
SELECT
    DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS month,
    product_id,
    COUNT(*) AS product_sales
FROM Orders O
JOIN Order_Items OI ON O.order_id = OI.order_id
GROUP BY month, product_id
ORDER BY month, product_sales DESC
LIMIT 10;

-- Popular Products by Month, Seller, State, and Category
SELECT 
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
    s.seller_id,
    s.seller_state,
    p.product_category_name,
    oi.product_id,
    COUNT(oi.product_id) AS product_count
FROM Orders o
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Sellers s ON oi.seller_id = s.seller_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY month, s.seller_id, s.seller_state, p.product_category_name, oi.product_id
ORDER BY product_count DESC
LIMIT 10;


-- Popular Categories by State --
SELECT
    customer_state,
    product_category_name,
    COUNT(*) AS category_sales
FROM Orders O
JOIN Order_Items OI ON O.order_id = OI.order_id
JOIN Products P ON OI.product_id = P.product_id
JOIN Customers C ON O.customer_id = C.customer_id
GROUP BY customer_state, product_category_name
ORDER BY category_sales DESC
LIMIT 10;

-- 6. Top 10 Most Expensive Products --
SELECT
    order_items.product_id,
    price,
    product_category_name 
FROM Order_Items
JOIN products on  order_items.product_id = products.product_id
ORDER BY product_category_name ,price DESC
LIMIT 10;


-- 7. Customer and Seller Segmentation by Revenue --
-- Customer Segmentation
WITH CustomerRevenue AS (
    SELECT 
        customer_id,
        SUM(price) AS total_revenue
    FROM Orders O
    JOIN Order_Items OI ON O.order_id = OI.order_id
    GROUP BY customer_id
)
SELECT 
    customer_id,
    CASE 
        WHEN total_revenue >= 10000 THEN 'High Value'
        WHEN total_revenue >= 5000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM CustomerRevenue;

-- SEller Segmentation

-- CTE to Group Sellers by Revenue
WITH SellerRevenue AS (
    SELECT 
        s.seller_id,
        SUM(oi.price) AS total_revenue
    FROM Sellers s
    JOIN Order_Items oi ON s.seller_id = oi.seller_id
    GROUP BY s.seller_id
)

-- Segment Sellers Based on Revenue
SELECT 
    seller_id,
    total_revenue,
    CASE 
        WHEN total_revenue >= 100000 THEN 'High Revenue'
        WHEN total_revenue >= 50000 AND total_revenue < 100000 THEN 'Medium Revenue'
        ELSE 'Low Revenue'
    END AS revenue_group
FROM SellerRevenue
ORDER BY total_revenue DESC;


-- 8. Cross-Selling Analysis --

SELECT 
    oi1.product_id AS product_1,
    oi2.product_id AS product_2,
    COUNT(*) AS combo_count
FROM Order_Items oi1
JOIN Order_Items oi2 ON oi1.order_id = oi2.order_id
WHERE oi1.product_id < oi2.product_id
GROUP BY product_1, product_2
ORDER BY combo_count DESC
LIMIT 10;



-- Payment Behavior: How Customers Are Paying
SELECT 
    payment_type,
    COUNT(*) AS payment_count
FROM Order_Payments
GROUP BY payment_type
ORDER BY payment_count DESC;




-- Channels Used by Most Customers
SELECT 
    payment_type,
    SUM(payment_value) AS total_payment_value,
    COUNT(DISTINCT order_id) AS unique_transactions
FROM Order_Payments
GROUP BY payment_type
ORDER BY total_payment_value DESC;


-- Top and Bottom Rated Categories
SELECT 
    p.product_category_name,
    AVG(rr.review_score) AS avg_rating
FROM Order_Review_Ratings rr
JOIN Order_Items oi ON rr.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY avg_rating DESC
LIMIT 10;  -- Modify for bottom ratings



SELECT 
    p.product_category_name,
    AVG(rr.review_score) AS avg_rating
FROM Order_Review_Ratings rr
JOIN Order_Items oi ON rr.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY avg_rating asc
LIMIT 10;  


-- Top and Bottom Rated Products
 SELECT 
    oi.product_id,
    p.product_category_name,
    AVG(rr.review_score) AS avg_rating
FROM Order_Review_Ratings rr
JOIN Order_Items oi ON rr.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY oi.product_id, p.product_category_name
ORDER BY avg_rating DESC
LIMIT 10;



-- Bottom --


SELECT 
    oi.product_id,
    p.product_category_name,
    AVG(rr.review_score) AS avg_rating
FROM Order_Review_Ratings rr
JOIN Order_Items oi ON rr.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY oi.product_id
ORDER BY avg_rating asc
LIMIT 10;


-- Average Rating by Location, Seller, Product, Category, and Month
SELECT 
    s.seller_state,
    s.seller_id,
    p.product_id,
    p.product_category_name,
    DATE_FORMAT(rr.review_creation_date, '%Y-%m') AS month,
    AVG(rr.review_score) AS avg_rating
FROM Order_Review_Ratings rr
JOIN Order_Items oi ON rr.order_id = oi.order_id
JOIN Sellers s ON oi.seller_id = s.seller_id
JOIN Products p ON oi.product_id = p.product_id
GROUP BY s.seller_state, s.seller_id, p.product_id, p.product_category_name, month
ORDER BY avg_rating DESC;

-- Top 5 Products by Revenue in Eachh month  --

WITH RankedProducts AS (
    SELECT 
        oi.product_id,
        p.product_category_name,
        SUM(oi.price ) AS total_revenue,
        RANK() OVER (PARTITION BY p.product_category_name ORDER BY SUM(oi.price ) DESC) AS product_rank
    FROM 
        Order_Items oi
    JOIN 
        Products p ON oi.product_id = p.product_id
    GROUP BY 
        oi.product_id, p.product_category_name
)
SELECT 
    product_id, 
    product_category_name, 
    total_revenue, 
    product_rank
FROM 
    RankedProducts
WHERE 
    product_rank <= 5
ORDER BY 
    product_category_name, product_rank;

-- Find Top 5 Sellers by Monthly Sales --

WITH MonthlySales AS (
    SELECT 
        seller_id,
        DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS month,
        SUM(oi.price ) AS monthly_sales
    FROM 
        Orders o
    JOIN 
        Order_Items oi ON o.order_id = oi.order_id
    GROUP BY 
        seller_id, month
),
RankedSellers AS (
    SELECT 
        seller_id,
        month,
        monthly_sales,
        RANK() OVER (PARTITION BY month ORDER BY monthly_sales DESC) AS seller_rank
    FROM 
        MonthlySales
)
SELECT 
    seller_id,
    month,
    monthly_sales,
    seller_rank
FROM 
    RankedSellers
WHERE 
    seller_rank <= 5
ORDER BY month, seller_rank;
    
    
    -- Monthly and Cumulative Revenue --
    
WITH MonthlyRevenue AS (
    SELECT 
        DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS month,
        SUM(oi.price ) AS monthly_revenue
    FROM 
        Orders o
    JOIN 
        Order_Items oi ON o.order_id = oi.order_id
    GROUP BY 
        month
)

SELECT 
    month,
    monthly_revenue,
    SUM(monthly_revenue) OVER (ORDER BY month) AS cumulative_revenue
FROM 
    MonthlyRevenue
ORDER BY 
    month;


-- Running Total of Quantity --
SELECT 
    oi.product_id,
    o.order_id,
    SUM(oi.price) OVER (PARTITION BY oi.product_id ORDER BY o.order_purchase_timestamp 
                         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_revenue
FROM 
    Orders o
JOIN 
    Order_Items oi ON o.order_id = oi.order_id
ORDER BY 
    oi.product_id, o.order_purchase_timestamp;



-- 3-Month Moving Average of Revenue --
WITH Monthly_Revenue AS (
    SELECT 
        DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS month,
        SUM(oi.price) AS monthly_revenue
    FROM 
        Orders o
    JOIN 
        Order_Items oi ON o.order_id = oi.order_id
    GROUP BY 
        month
)
SELECT 
    month,
    monthly_revenue,
    AVG(monthly_revenue) OVER (ORDER BY month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_revenue
FROM 
    Monthly_Revenue
ORDER BY 
    month;
    
    
    -- Customer Purchase Frequency --
    
    WITH CustomerPurchaseFrequency AS (
    SELECT 
        customer_id,
        DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS month,
        COUNT(order_id) AS total_purchases,
        RANK() OVER (PARTITION BY DATE_FORMAT(order_purchase_timestamp, '%Y-%m') ORDER BY COUNT(order_id) DESC) AS purchase_frequency_rank
    FROM 
        Orders
    GROUP BY 
        customer_id, 
        month
)
SELECT 
    customer_id, 
    month, 
    total_purchases, 
    purchase_frequency_rank
FROM 
    CustomerPurchaseFrequency
WHERE 
    purchase_frequency_rank <= 5
ORDER BY 
    month, 
    purchase_frequency_rank;
    -- Percentile Analysis for Product Prices --
SELECT oi.product_id,
       p.product_category_name,
       oi.price,
       PERCENT_RANK() OVER (PARTITION BY p.product_category_name ORDER BY oi.price) AS price_percentile
FROM Order_Items oi
JOIN Products p ON oi.product_id = p.product_id;

--  Revenue Contribution by Top Customers --

WITH Customer_Revenue AS (
    SELECT o.customer_id,
           SUM(oi.price ) AS total_revenue
    FROM Orders o
    JOIN Order_Items oi ON o.order_id = oi.order_id
    GROUP BY o.customer_id
),
Revenue_Rank AS (
    SELECT customer_id,
           total_revenue,
           NTILE(10) OVER (ORDER BY total_revenue DESC) AS decile
    FROM Customer_Revenue
)
SELECT decile,
       SUM(total_revenue) AS revenue_contribution,
       (SUM(total_revenue) * 100.0 / (SELECT SUM(total_revenue) FROM Customer_Revenue)) AS percentage_contribution
FROM Revenue_Rank
WHERE decile = 1  -- This selects the top 10% customers
GROUP BY decile;

-- Monthly New Customer Count --
SELECT DATE_FORMAT(first_purchase_date, '%Y-%m') AS month, COUNT(customer_id) AS new_customers
FROM (
    SELECT customer_id, MIN(order_purchase_timestamp) AS first_purchase_date
    FROM Orders
    GROUP BY customer_id
) AS first_purchases
GROUP BY month;

-- Top 10 Revenue-Generating Products by Category --

SELECT product_id, product_category_name, total_revenue
FROM (
    SELECT oi.product_id,
           p.product_category_name,
           SUM(oi.price ) AS total_revenue,
           RANK() OVER (PARTITION BY p.product_category_name ORDER BY SUM(oi.price ) DESC) AS revenue_rank
    FROM Order_Items AS oi
    JOIN Products AS p ON oi.product_id = p.product_id
    GROUP BY oi.product_id, p.product_category_name
) AS ranked_products
WHERE revenue_rank <= 10;


-- Most Expensive Products Sold by Each Seller --
SELECT oi.seller_id, oi.product_id, oi.price
FROM Order_Items AS oi
JOIN (
    SELECT seller_id, MAX(price) AS max_price
    FROM Order_Items
    GROUP BY seller_id
) AS max_prices ON oi.seller_id = max_prices.seller_id AND oi.price = max_prices.max_price;

--  Top 5 Locations with Highest Average Order Value --

SELECT c.customer_city AS location,
       AVG(order_value) AS avg_order_value
FROM (
    SELECT o.customer_id,
           oi.order_id,
           SUM(oi.price) AS order_value
    FROM Orders AS o
    JOIN Order_Items AS oi ON o.order_id = oi.order_id
    GROUP BY o.customer_id, oi.order_id
) AS customer_orders
JOIN Customers AS c ON customer_orders.customer_id = c.customer_id
GROUP BY c.customer_city
ORDER BY avg_order_value DESC
LIMIT 5;
-- Percentage of Orders Delivered on Time --

SELECT (COUNT(
CASE 
WHEN order_delivered_customer_date <= order_estimated_delivery_date 
THEN 1 
END) * 100.0 
/ COUNT(*)) AS on_time_delivery_percentage
FROM Orders;

--  Names Starting with a Specific Letter
SELECT customer_id,customer_city
FROM Customers
WHERE customer_city LIKE 'A%';
-- Ending--
SELECT customer_id,customer_city
FROM Customers
WHERE customer_city LIKE '%A';

SELECT product_category_name
FROM Products
WHERE product_category_name LIKE '%To%';




