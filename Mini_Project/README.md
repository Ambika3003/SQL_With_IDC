# 🍕 The Great Pizza Analytics Challenge

*A Mini SQL Project – Data Analysis Using Pizza Sales Data*

 A hands-on mini project where I take on the role of *a Data Analyst at The Great Pizza (IDC Pizza).*
 My goal in this project is to explore, clean, and analyze pizza sales data to uncover meaningful business insights using SQL.

## 🎯 Project Objective
The goal of this project is to analyze raw pizza sales data and answer a structured set of business questions using SQL.
You will:
- Explore datasets
- Clean and filter data
- Analyze sales trends
- Perform aggregations
- Join tables

## 🧰 Skills & SQL Concepts Used
- SQL(PostgreSql)
- Database creation & import
- SELECT, WHERE, IN, BETWEEN, LIKE
- Sorting and filtering
- Data cleaning (DISTINCT, COALESCE, NULL handling)
- Aggregations: SUM, AVG, COUNT, MIN, MAX
- Grouping & filtering groups: GROUP BY, HAVING
- Table joins

## 🗃️ About Dataset 
This project uses four relational tables:
 1. pizza_types -  pizza_type_id, name, category, ingredients
 2. pizzas - pizza_id, pizza_type_id, size, price
 3. orders - order_id, date, time
 4. order_details - order_details_id, order_id, pizza_id, quantity

## Phase 1: Foundation & Inspection
 1. Install IDC_Pizza.dump as IDC_Pizza server
 2. List all unique pizza categories (`DISTINCT`).
 3. Display `pizza_type_id`, `name`, and ingredients, replacing NULL ingredients with `"Missing Data"`. Show first 5 rows.
 4. Check for pizzas missing a price (`IS NULL`).

## Phase 2: Filtering & Exploration
 1. Orders placed on `'2015-01-01'` (`SELECT` + `WHERE`).
 2. List pizzas with `price` descending.
 3. Pizzas sold in sizes `'L'` or `'XL'`.
 4. Pizzas priced between $15.00 and $17.00.
 5. Pizzas with `"Chicken"` in the name.
 6. Orders on `'2015-02-15'` or placed after 8 PM.

## Phase 3: Sales Performance
 1. Total quantity of pizzas sold (`SUM`).
 2. Average pizza price (`AVG`).
 3. Total order value per order (`JOIN`, `SUM`, `GROUP BY`).
 4. Total quantity sold per pizza category (`JOIN`, `GROUP BY`).
 5. Categories with more than 5,000 pizzas sold (`HAVING`).
 6. Pizzas never ordered (`LEFT/RIGHT JOIN`).
 7. Price differences between different sizes of the same pizza (`SELF JOIN`).

## 🏷️ About the SQL Answers
This mini project includes a structured set of questions divided across three phases — covering data inspection, filtering, exploration, and sales performance analysis.
All SQL queries/answers for every question are provided separately in a dedicated SQL file inside this folder.
 👉 [click here to see](https://github.com/Ambika3003/SQL_With_IDC/blob/main/Mini_Project/Mini_Project.sql)

## 🚀 Why This Mini Project Matters
*This project strengthens my query-writing, data interpretation, and analytical thinking skills.*

This challenge helps to:
- Understand business questions
- Explore the data
- Build clean SQL queries
- Derive insights


