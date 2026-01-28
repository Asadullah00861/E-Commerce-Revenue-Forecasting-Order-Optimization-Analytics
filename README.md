Problem Statement: How can an e-commerce company increase revenue and improve customer retention by understanding purchasing behavior and predicting future order value?


📖 Project Overview
This project addresses the challenge of converting large volumes of transactional e-commerce data into actionable business intelligence. It integrates SQL-based descriptive analytics with Python-based predictive modeling to optimize revenue tracking and operational efficiency.

The workflow spans the entire analytics pipeline: from raw data ingestion and Dimensional Modeling in Python to Predictive Machine Learning for financial and logistical forecasting.

🏗️ Technical Methodology
Dimensional Modeling (Python)
To transform raw data into an analytical format, I performed dimensional modeling using Python. This involved merging and engineering multiple transactional datasets into:

Fact Tables: Capturing quantitative measures (orders, revenue).

Dimension Tables: Capturing descriptive context (product attributes, status). The resulting order-level features serve as the foundation for both the SQL KPI layer and the Machine Learning models.

SQL Analytics Layer (KPIs)
I utilized SQL to establish business context and validate data integrity. This layer focuses on establishing the "Single Source of Truth" for the following KPIs:

Total Revenue & Net Revenue: Monitoring top-line growth.

Order Volume: Tracking transaction density.

Discount Metrics: Analyzing the impact of promotions on final margins.

Machine Learning & Predictive Analytics
The project leverages Python (Jupyter Notebooks & VS Code) to execute two primary predictive tracks:

1. Net Revenue per Order (Regression)

Objective: Predict the expected net revenue of an order.

Business Value: Facilitates more accurate financial forecasting and cash flow management.

Insight: In cases where predictive performance was weak, I utilized analytical judgment to evaluate the model’s limitations rather than forcing a low-accuracy fit.

2. Order Status Prediction (Classification)

Objective: Predict whether an order will be successfully completed.

Business Value: Identifies potential logistical failures early, allowing for operational intervention.

📈 Analytical Highlights
Discount Effectiveness Analysis
Rather than assuming discounts drive positive growth, I conducted a descriptive ML analysis to examine the correlation between discount levels and actual revenue retention. This prevents margin erosion caused by inefficient promotional strategies.

Revenue Trend & Seasonality
I performed time-based analysis to identify seasonal patterns. These insights support:

Strategic budgeting.

Inventory planning.

Campaign timing.

🧰 Tools & Skills Demonstrated
Environment: VS Code, Jupyter Notebooks.

Data Engineering: Dimensional modeling and feature engineering in Python.

Database: SQL for KPI calculation and data validation.

Machine Learning: Regression, Classification, and Descriptive ML (Discount Analysis).

Judgment: Evaluating model performance versus business heuristics.

Project Structure

├── data/
│   ├── ecommerce_dataset_updated.csv        # Primary raw dataset
│   ├── dim_customer.csv                     # Dimension table: Customer details
│   ├── dim_product.csv                      # Dimension table: Product attributes
│   ├── dim_date.csv                         # Dimension table: Time attributes
│   ├── dim_payment.csv                      # Dimension table: Payment methods
│   ├── fact_orders.csv                      # Fact table: Order-level metrics
│   ├── fact_sales.csv                       # Fact table: Transactional sales data
│   ├── discount_effectiveness_summary.csv   # Analysis output: Discount impact
│   ├── monthly_revenue_trend.csv            # Analysis output: Monthly growth
│   └── revenue_seasonality.csv              # Analysis output: Seasonal patterns
├── notebooks/
│   ├── Ecommerce_ETL_Pipeline.ipynb         # Python-based Dimensional Modeling
│   ├── ML_predict_net_revenue.ipynb         # Regression modeling (Revenue)
│   ├── ML_order_status_prediction.ipynb     # Classification modeling (Status)
│   ├── ML_discount_bands.ipynb              # Descriptive ML for discount analysis
│   └── revenue_time_based_analysis.ipynb    # Seasonality and trend analysis
├── sql/
│   └── Solved_Business_Problems_(KPIs).sql  # SQL queries for primary business KPIs
└── README.md

⚙️ Requirements & Setup
This project requires Python 3.x and the following libraries:

pandas & numpy: Data manipulation and Dimensional Modeling.

scikit-learn: Predictive modeling (Regression/Classification).

matplotlib & seaborn: Trend and seasonality visualizations.




