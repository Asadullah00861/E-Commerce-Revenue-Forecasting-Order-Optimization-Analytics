# E-Commerce Revenue Optimization: End-to-End Analytics

## Problem Statement
How can an e-commerce company increase revenue and improve customer retention by understanding purchasing behavior and predicting future order value?

## Project Overview
In the modern e-commerce landscape, the ability to convert raw transactional data into high-impact business strategy is a primary competitive advantage. This project chronicles the journey of taking a disorganized e-commerce dataset and transforming it into a predictive powerhouse.

The core goal was to move beyond simple reporting and answer a fundamental business question:  
**"How can we increase revenue and improve customer retention by understanding purchasing behavior and predicting future order value?"**  

By bridging the gap between SQL-based descriptive metrics and Python-powered Machine Learning, this project provides a direct roadmap for increasing revenue and improving operational efficiency.

## Business Objectives
The analysis was structured around three pillars of company growth:

### 1. Revenue Intelligence
Establishing a validated "Single Source of Truth" for financial performance.

### 2. Operational Risk Mitigation
Predicting order fulfillment success to minimize logistics waste.

### 3. Strategic Marketing
Evaluating if current discount structures drive growth or merely erode margins.

## Technical Methodology

### 1. Dimensional Modeling (Python-Based ETL)
Rather than working with raw, flat files, I implemented a **Star Schema** to optimize the data for professional-grade analytics. Using Python, I engineered:

- **Fact Tables**: `fact_orders` and `fact_sales` to capture quantitative transactional measures like orders and revenue.  
- **Dimension Tables**: `dim_customer`, `dim_product`, `dim_date`, and `dim_payment` to provide descriptive attributes like product details and customer status.

### 2. SQL Analytics Layer (The KPI Framework)
Using the file `Solved_Business_Problems_(KPIs).sql`, I established business context and validated data integrity through essential health metrics:

- **Total & Net Revenue**: Monitoring top-line growth and actual earnings.  
- **Order Volume**: Tracking transaction density.  
- **Performance Tracking**: Validating data integrity before moving into predictive phases.

### 3. Predictive Analytics & Machine Learning
Developed in a hybrid **Jupyter Notebook** and **VS Code** environment, the predictive layer focuses on:

- **Net Revenue Prediction (Regression)**: Predicting the expected value of an order to assist with financial and logistical forecasting.  
- **Order Status Prediction (Classification)**: Predicting whether an order will be successfully completed.  
- **Analytical Judgment**: Prioritized business utility over algorithmic complexity. Where predictive performance was limited, I evaluated the limitations to ensure analytical maturity.

#### Model Performance (For Net Revenue Prediction)
| Metric | Value |
|--------|-------|
| MAE    | 79.99 |
| RMSE   | 114.66 |
| R² Score | 0.815 |

These results indicate that the model predicts order revenue with strong accuracy and reliability. On average, predictions deviate by about 80 units (MAE), and larger errors are limited (RMSE = 114.66), while an R² score of 0.815 shows that the model explains over 81% of the variation in revenue. Together, these metrics demonstrate that the model can effectively support business decisions such as revenue planning, discount strategy evaluation, and operational forecasting, providing actionable insights to increase revenue and optimize resources.

---

## Requirements & Setup
This project requires **Python 3.x** and the following core libraries:

- **Pandas & NumPy**: For data manipulation and Dimensional Modeling.  
- **Scikit-Learn**: For training and evaluating predictive models.  
- **Matplotlib & Seaborn**: For visualizing trends and analysis outputs.

## Author
**Muhammad Arslan Arshad**
