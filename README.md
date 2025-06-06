# Ecommerce SQL Data Analysis - Task 3

## Project Overview

This project demonstrates data analysis on an Ecommerce database using SQL. It covers fundamental SQL operations such as filtering, joining tables, subqueries, aggregation, creating views, and indexing to optimize performance.


## Dataset Description

The database contains tables like:

- *customers*: Customer details
- *products*: Product information
- *orders*: Customer orders
- *order_items*: Items in each order
- *categories*: Product categories

---

## Detailed Explanation of Queries

### a. SELECT, WHERE, ORDER BY, GROUP BY

*Query 1: List customers from India ordered by account creation date*


SELECT * FROM customers
WHERE country = 'India'
ORDER BY created_at;

Explanation:
Filters customers located in India and sorts them by the date their accounts were created, helping analyze customer growth in that region.

---

*Query 2: Count number of orders per customer*


SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id;

Explanation:
Groups orders by customer and counts the number of orders for each. Useful for identifying frequent buyers.

---

### b. JOINS (INNER, LEFT, RIGHT)

*Query 3: Retrieve orders with customer names (INNER JOIN)*

SELECT o.order_id, c.customer_name, o.order_date, o.order_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

Explanation:
Fetches orders alongside customer names. INNER JOIN ensures only orders with matching customers are shown.

---

*Query 4: List all customers and their orders (LEFT JOIN)*

SELECT c.customer_id, c.customer_name, o.order_id, o.order_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

Explanation:
Includes all customers, showing their orders if any. Customers without orders appear with NULL in order columns.

---

*Query 5: List all orders and customer info (RIGHT JOIN)*

SELECT c.customer_id, c.customer_name, o.order_id, o.order_amount
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;

Explanation:
Includes all orders even if the customer info is missing (which may indicate data inconsistency). RIGHT JOIN is the inverse of LEFT JOIN.

---

### c. Subqueries

*Query 6: Customers with orders above average order amount*

SELECT * FROM customers
WHERE customer_id IN (
    SELECT customer_id FROM orders
    WHERE order_amount > (SELECT AVG(order_amount) FROM orders)
);

Explanation:
Finds customers who placed at least one order exceeding the average order value, highlighting high-value customers.

---

### d. Aggregate Functions (SUM, AVG)

*Query 7: Total revenue by product category*

SELECT p.category, SUM(oi.quantity * oi.item_price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category;

Explanation:
Calculates total sales revenue for each product category, useful for identifying best performing categories.

---

*Query 8: Average order amount per customer*

SELECT customer_id, AVG(order_amount) AS avg_order_value
FROM orders
GROUP BY customer_id;

Explanation:
Computes the average spending per order by each customer, helpful for customer segmentation.

---

### e. Views for Analysis

*Query 9: Create a view of completed orders*

CREATE VIEW completed_orders_view AS
SELECT * FROM orders WHERE order_status = 'Completed';

Explanation:
Simplifies queries by creating a reusable view containing only completed orders.

---

*Query 10: Create a view for total revenue per customer*

CREATE VIEW customer_revenue_view AS
SELECT c.customer_id, c.customer_name, SUM(o.order_amount) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

Explanation:
Aggregates total revenue per customer, facilitating quick access to customer revenue data.

---

### f. Index Optimization

*Query 11: Create indexes to improve query performance*

CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);

Explanation:
Indexes speed up queries filtering or joining on these columns by allowing faster data retrieval.

---

## Usage Instructions

* Run the queries sequentially to analyze data and create helpful views and indexes.
## Conclusion

This set of queries provides a solid foundation for analyzing ecommerce data effectively with SQL, leveraging key concepts and optimization techniques.

---
* Use the views to simplify reporting queries.
* Modify indexes or add new ones depending on query patterns.

---

