
# Ecommerce SQL Data Analysis - Task 3

## Project Overview

This project demonstrates effective data analysis on an Ecommerce database using SQL. It covers fundamental SQL concepts such as filtering, joins, subqueries, aggregation, views, and indexing to enable efficient data retrieval and reporting.

---

## Dataset Description

The database contains the following key tables:

- **customers**: Customer details including location and account creation date.
- **products**: Product information and categories.
- **orders**: Customer orders with order metadata.
- **order_items**: Items and quantities included in each order.
- **categories**: Classification of products into different groups.

---

## Query Explanations

### a. Basic Queries: SELECT, WHERE, ORDER BY, GROUP BY

**Query 1: List customers from India sorted by their account creation date**

sql
SELECT * FROM customers
WHERE country = 'India'
ORDER BY created_at;
`

*Explanation:*
Retrieves all customers located in India and sorts them chronologically by when their accounts were created. This helps analyze the customer base growth over time in the Indian market.

---

**Query 2: Count total orders per customer**

sql
SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id;


*Explanation:*
Groups orders by each customer and counts how many orders each has placed. This identifies frequent buyers and customer engagement levels.

---

### b. Joins: INNER JOIN, LEFT JOIN, RIGHT JOIN

**Query 3: Retrieve orders along with customer names (INNER JOIN)**

sql
SELECT o.order_id, c.customer_name, o.order_date, o.order_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;


*Explanation:*
Fetches orders and associated customer names, showing only orders that have matching customers, ensuring data integrity in results.

---

**Query 4: List all customers with their orders if any (LEFT JOIN)**

sql
SELECT c.customer_id, c.customer_name, o.order_id, o.order_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;


*Explanation:*
Displays every customer, including those who haven’t placed any orders. Customers without orders will have NULL values in order-related fields.

---

**Query 5: Show all orders with customer info where available (RIGHT JOIN)**

sql
SELECT c.customer_id, c.customer_name, o.order_id, o.order_amount
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;


*Explanation:*
Lists all orders, even if the corresponding customer information is missing, which can highlight possible data inconsistencies.

---

### c. Subqueries

**Query 6: Identify customers with orders above average order amount**

sql
SELECT * FROM customers
WHERE customer_id IN (
    SELECT customer_id FROM orders
    WHERE order_amount > (SELECT AVG(order_amount) FROM orders)
);


*Explanation:*
Uses a nested query to find customers who have placed at least one order that exceeds the average order value, indicating high-spending customers.

---

### d. Aggregate Functions: SUM, AVG

**Query 7: Calculate total revenue per product category**

sql
SELECT p.category, SUM(oi.quantity * oi.item_price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category;


*Explanation:*
Aggregates sales revenue by multiplying quantity and price for each product, grouped by category, to identify the most profitable product groups.

---

**Query 8: Compute average order value per customer**

sql
SELECT customer_id, AVG(order_amount) AS avg_order_value
FROM orders
GROUP BY customer_id;


*Explanation:*
Calculates the mean spending per order for each customer, useful for segmenting customers based on purchasing behavior.

---

### e. Views for Reusability

**Query 9: Create a view for completed orders**

sql
CREATE VIEW completed_orders_view AS
SELECT * FROM orders WHERE order_status = 'Completed';


*Explanation:*
Defines a reusable view to simplify access to completed orders without repeatedly specifying the filter.

---

**Query 10: Create a view for total revenue per customer**

sql
CREATE VIEW customer_revenue_view AS
SELECT c.customer_id, c.customer_name, SUM(o.order_amount) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;


*Explanation:*
Aggregates and stores total revenue per customer to streamline reporting on customer value.

---

### f. Index Optimization

**Query 11: Add indexes to improve join and filter efficiency**

sql
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);
```

Explanation:
Indexes on frequently used columns speed up query execution by allowing faster data lookups during joins and filters.

---

## Usage Instructions

* Run the queries sequentially to build insights from the dataset.
* Utilize the created views to simplify complex queries and reporting.
* Apply indexing to boost performance, especially for large-scale data.
* Customize and extend queries as needed for further analysis.

---

## Visual Output

Included screenshots provide sample query results and visualization of insights.

---

## Conclusion

This analysis leverages SQL’s core features to extract meaningful business insights from ecommerce data while ensuring performance through indexing and reusable views. It forms a solid base for data-driven decision-making.

---
