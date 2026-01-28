-- =====================================================
-- E-COMMERCE PROJECT - KPI QUERIES
-- Author: Your Name
-- Description: SQL queries to analyze sales, customers, 
--              products, and orders for portfolio
-- =====================================================

-- ==========================
-- KPI 1: Net Revenue over time
-- Business Question: What is the total revenue generated over time?
-- ==========================
SELECT
    ROUND(SUM(net_revenue)::numeric, 2) AS total_revenue
FROM fact_sales
WHERE order_status = 'Delivered';

-- ==========================
-- KPI 2: Average Order Value
-- Business Question: What is the average value of a completed (delivered) order?
-- ==========================
SELECT
    ROUND(AVG(order_total)::numeric, 2) AS AOV
FROM fact_orders
WHERE order_status = 'Delivered';

-- ==========================
-- KPI 3: Average Order Value trend over time
-- Business Question 1: How does the average order value (AOV) trend month over month for delivered orders?
-- ==========================
SELECT
    d.year,
    d.month,
    ROUND(AVG(order_totals.order_total)::numeric, 2) AS avg_order_value
FROM (
    SELECT DISTINCT
        fs.order_id,
        fs.date_id,
        fs.order_total
    FROM fact_sales fs
    WHERE fs.order_status = 'Delivered'
) order_totals
JOIN dim_date d
    ON order_totals.date_id = d.date_id
GROUP BY d.year, d.month
ORDER BY d.year, d.month;

-- Business Question 2: Which Months and years have the highest and lowest average order values (AOV)?
WITH monthly_aov AS (
    SELECT
        d.year,
        d.month,
        ROUND(AVG(order_totals.order_total)::numeric, 2) AS avg_order_value
    FROM (
        SELECT DISTINCT
            fs.order_id,
            fs.date_id,
            fs.order_total
        FROM fact_sales fs
        WHERE fs.order_status = 'Delivered'
    ) order_totals
    JOIN dim_date d
        ON order_totals.date_id = d.date_id
    GROUP BY d.year, d.month
)
SELECT *
FROM monthly_aov
WHERE avg_order_value = (SELECT MAX(avg_order_value) FROM monthly_aov)
   OR avg_order_value = (SELECT MIN(avg_order_value) FROM monthly_aov);

-- ==========================
-- KPI 4: Top Product Categories by Revenue
-- Business Question: What are the top product categories by net revenue from delivered orders?
-- ==========================
SELECT
    p."Category",
    ROUND(SUM(fs."net_revenue")::numeric, 2) AS total_revenue
FROM fact_sales fs
JOIN dim_product p
    ON fs."Product_ID" = p."Product_ID"
WHERE fs."order_status" = 'Delivered'
GROUP BY p."Category"
ORDER BY total_revenue DESC;

-- ==========================
-- KPI 5: Top Customers by Lifetime Revenue
-- Business Question: Who are the top 10 customers contributing the most net revenue from delivered orders?
-- ==========================
SELECT
    fs."User_ID",
    c."customer_country",
    c."customer_age_group",
    ROUND(SUM(fs."net_revenue")::numeric, 2) AS lifetime_revenue,
    COUNT(DISTINCT fs."order_id") AS total_orders
FROM fact_sales fs
JOIN dim_customer c
    ON fs."User_ID" = c."User_ID"
WHERE fs."order_status" = 'Delivered'
GROUP BY fs."User_ID", c."customer_country", c."customer_age_group"
ORDER BY lifetime_revenue DESC
LIMIT 10;

-- ==========================
-- KPI 6: Discount Impact on Revenue
-- Business Question 1: Which discount ranges lead to higher or lower revenue, broken down by product category?
-- ==========================
SELECT
    p."Category",
    CASE
        WHEN fs."Discount_Percent" = 0 THEN '0%'
        WHEN fs."Discount_Percent" BETWEEN 1 AND 10 THEN '1-10%'
        WHEN fs."Discount_Percent" BETWEEN 11 AND 25 THEN '11-25%'
        WHEN fs."Discount_Percent" BETWEEN 26 AND 50 THEN '26-50%'
        ELSE '50%+'
    END AS discount_band,
    ROUND(SUM(fs."net_revenue")::numeric, 2) AS total_revenue,
    COUNT(DISTINCT fs."order_id") AS total_orders
FROM fact_sales fs
JOIN dim_product p
    ON fs."Product_ID" = p."Product_ID"
WHERE fs."order_status" = 'Delivered'
GROUP BY p."Category", discount_band
ORDER BY total_revenue DESC;

-- Business Question 2: Which discount bands and product categories generate the highest revenue and order volume, and how does average revenue per order vary across discount levels?
SELECT
    CASE
        WHEN fs."Discount_Percent" = 0 THEN '0%'
        WHEN fs."Discount_Percent" BETWEEN 1 AND 10 THEN '1-10%'
        WHEN fs."Discount_Percent" BETWEEN 11 AND 25 THEN '11-25%'
        WHEN fs."Discount_Percent" BETWEEN 26 AND 50 THEN '26-50%'
        ELSE '50%+'
    END AS discount_band,
    ROUND(SUM(fs."net_revenue")::numeric, 2) AS total_revenue,
    ROUND(AVG(fs."net_revenue")::numeric, 2) AS avg_revenue_per_order,
    COUNT(DISTINCT fs."order_id") AS total_orders
FROM fact_sales fs
WHERE fs."order_status" = 'Delivered'
GROUP BY discount_band
ORDER BY total_revenue DESC;

-- ==========================
-- KPI 7: Top Payment Methods
-- Business Question: Which payment methods generate the most revenue and have the highest number of delivered orders?
-- ==========================
SELECT
    fs."Payment_Method",
    ROUND(SUM(fs."net_revenue")::numeric, 2) AS total_revenue,
    COUNT(DISTINCT fs."order_id") AS total_orders,
    ROUND(AVG(fs."net_revenue")::numeric, 2) AS avg_revenue_per_order
FROM fact_sales fs
WHERE fs."order_status" = 'Delivered'
GROUP BY fs."Payment_Method"
ORDER BY total_revenue DESC;

-- ==========================
-- KPI 8: Revenue Trend by Month and Category
-- Business Question: How does revenue evolve over time for each product category, and which months are most profitable?
-- ==========================
SELECT
    d.year,
    d.month,
    p."Category",
    ROUND(SUM(fs."net_revenue")::numeric, 2) AS total_revenue,
    COUNT(DISTINCT fs."order_id") AS total_orders,
    ROUND(AVG(fs."net_revenue")::numeric, 2) AS avg_revenue_per_order
FROM fact_sales fs
JOIN dim_product p
    ON fs."Product_ID" = p."Product_ID"
JOIN dim_date d
    ON fs."date_id" = d."date_id"
WHERE fs."order_status" = 'Delivered'
GROUP BY d.year, d.month, p."Category"
ORDER BY d.year, d.month, total_revenue DESC;

-- Business Question 2: Top-performing category per month
WITH monthly_category_revenue AS (
    SELECT
        d.year,
        d.month,
        p."Category",
        ROUND(SUM(fs."net_revenue")::numeric, 2) AS total_revenue,
        COUNT(DISTINCT fs."order_id") AS total_orders,
        ROUND(AVG(fs."net_revenue")::numeric, 2) AS avg_revenue_per_order
    FROM fact_sales fs
    JOIN dim_product p
        ON fs."Product_ID" = p."Product_ID"
    JOIN dim_date d
        ON fs."date_id" = d."date_id"
    WHERE fs."order_status" = 'Delivered'
    GROUP BY d.year, d.month, p."Category"
),
ranked_categories AS (
    SELECT *,
        RANK() OVER (PARTITION BY year, month ORDER BY total_revenue DESC) AS rank_month
    FROM monthly_category_revenue
)
SELECT *
FROM ranked_categories
WHERE rank_month = 1
ORDER BY year, month;

-- ==========================
-- KPI 9: Customer Segment Analysis by Revenue and Order Volume
-- Business Question: Which customer segments (by age group and country) contribute most to revenue, order volume, and average revenue per order?
-- Part 1: By Revenue
SELECT
    c.customer_country,
    c.customer_age_group,
    ROUND(SUM(fs."net_revenue")::numeric, 2) AS total_revenue
FROM fact_sales fs
JOIN dim_customer c
    ON fs."User_ID" = c."User_ID"
WHERE fs."order_status" = 'Delivered'
GROUP BY c.customer_country, c.customer_age_group
ORDER BY total_revenue DESC;

-- Part 2: By Number of Orders
SELECT
    c.customer_country,
    c.customer_age_group,
    COUNT(DISTINCT fs."order_id") AS total_orders
FROM fact_sales fs
JOIN dim_customer c
    ON fs."User_ID" = c."User_ID"
WHERE fs."order_status" = 'Delivered'
GROUP BY c.customer_country, c.customer_age_group
ORDER BY total_orders DESC;

-- Part 3: By Average Revenue Per Order
SELECT
    c.customer_country,
    c.customer_age_group,
    ROUND(AVG(fs."net_revenue")::numeric, 2) AS avg_revenue_per_order
FROM fact_sales fs
JOIN dim_customer c
    ON fs."User_ID" = c."User_ID"
WHERE fs."order_status" = 'Delivered'
GROUP BY c.customer_country, c.customer_age_group
ORDER BY avg_revenue_per_order DESC;
