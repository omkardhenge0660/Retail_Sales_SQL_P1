#  Retail Sales Analysis using MySQL

##  Project Overview

This project is a beginner-friendly SQL data analysis project based on a Retail Sales dataset. The main goal of this project is to perform data cleaning, data exploration, and business analysis using MySQL queries.

In this project, I imported a retail sales dataset into MySQL, cleaned missing values, explored the data, and solved different business problems using SQL queries.

This project helped me improve my understanding of:

* SQL Queries
* Data Cleaning
* Aggregate Functions
* Window Functions
* Group By Operations
* Business Data Analysis
* MySQL Database Handling

---

#  Dataset Information

The dataset contains retail sales transaction details such as:

| Column Name     | Description           |
| --------------- | --------------------- |
| transactions_id | Unique transaction ID |
| sale_date       | Date of sale          |
| sale_time       | Time of sale          |
| customer_id     | Unique customer ID    |
| gender          | Customer gender       |
| age             | Customer age          |
| category        | Product category      |
| quantiy         | Quantity purchased    |
| price_per_unit  | Price per product     |
| cogs            | Cost of goods sold    |
| total_sale      | Total sale amount     |

Total Records: **2000**

---

# Tools & Technologies Used

* MySQL
* MySQL Workbench
* CSV Dataset
* SQL

---

#  Database & Table Creation

```sql
CREATE DATABASE sql_project_1;

USE sql_project_1;

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(20),
    age INT,
    category VARCHAR(50),
    quantiy INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

---

#  Data Cleaning

Checked the dataset for null values in important columns.

```sql
SELECT * FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantiy IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```

---

#  Data Exploration

Some basic exploration queries performed in this project:

### Total Sales Records

```sql
SELECT COUNT(*) AS total_sales
FROM retail_sales;
```

### Unique Customers

```sql
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM retail_sales;
```

### Product Categories

```sql
SELECT DISTINCT category
FROM retail_sales;
```

---

#  Business Problems Solved

##  Sales made on a specific date

```sql
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';
```

---

##  Clothing transactions with quantity greater than 4 in November 2022

```sql
SELECT *
FROM retail_sales
WHERE category = 'clothing'
AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
AND quantiy >= 4;
```

---

##  Total sales and total orders for each category

```sql
SELECT category,
SUM(total_sale) AS net_sales,
COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
```

---

##  Average age of customers who purchased Beauty products

```sql
SELECT AVG(age) AS avg_age
FROM retail_sales
WHERE category = 'beauty';
```

---

##  Transactions where total sales are greater than 1000

```sql
SELECT *
FROM retail_sales
WHERE total_sale >= 1000;
```

---

##  Total transactions by gender in each category

```sql
SELECT gender,
category,
COUNT(*) AS transactions
FROM retail_sales
GROUP BY gender, category;
```

---

##  Best selling month in each year

```sql
SELECT * FROM
(
    SELECT
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale,
        RANK() OVER(
            PARTITION BY YEAR(sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS sale_rank
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS t1
WHERE sale_rank = 1;
```

---

##  Top 5 customers based on highest sales

```sql
SELECT customer_id,
SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

---

##  Unique customers from each category

```sql
SELECT category,
COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;
```

---

##  Sales shift analysis (Morning, Afternoon, Evening)

```sql
WITH hourly_sales AS
(
    SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift_time
    FROM retail_sales
)
SELECT shift_time,
COUNT(*) AS total_orders
FROM hourly_sales
GROUP BY shift_time;
```

---

#  Key Learnings

Through this project, I learned:

* How to create databases and tables in MySQL
* How to import CSV data into MySQL
* How to clean missing data
* How to use aggregate functions like SUM(), AVG(), COUNT()
* How to use GROUP BY and ORDER BY
* How to write business problem-solving SQL queries
* How to use Window Functions like RANK()
* How to analyze retail sales data effectively

---
#  Conclusion

Through this project, I gained hands-on experience in MySQL by working with a retail sales dataset and solving real business problems using SQL queries. The analysis helped uncover valuable insights related to sales performance, customer behavior, and product categories. This project enhanced my skills in data cleaning, querying, aggregation, and business analysis, making it an important step in my journey toward Data Analytics.

---

#  Project Files

* `SQL1 - Retail Sales Analysis_utf.csv` → Dataset file
* `sql_p1.sql` → SQL queries used in the project

---

#  About Me

I am currently learning SQL and Data Analytics, and this project is part of my hands-on practice to improve my skills in database management and business data analysis.THANK YOU.

---



