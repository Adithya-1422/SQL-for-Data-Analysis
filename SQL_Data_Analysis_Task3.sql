
-- Task 3: SQL for Data Analysis using Ecommerce_SQL_Database

-- a. SELECT, WHERE, ORDER BY, GROUP BY
-- 1. List all customers from 'India' ordered by creation date
SELECT * FROM customers
WHERE country = 'India'
ORDER BY created_at;

-- 2. Count number of orders per customer
SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id;

-- b. JOINS (INNER, LEFT, RIGHT)
-- 3. INNER JOIN: List all orders with customer names
SELECT o.order_id, c.customer_name, o.order_date, o.order_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

-- 4. LEFT JOIN: List all customers and their orders (including those who didn’t order)
SELECT c.customer_id, c.customer_name, o.order_id, o.order_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

-- 5. RIGHT JOIN: List all orders and customer info (some DBs may not support RIGHT JOIN like SQLite)
-- For MySQL/PostgreSQL:
SELECT c.customer_id, c.customer_name, o.order_id, o.order_amount
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;

-- c. Subqueries
-- 6. List customers who have made orders above average order amount
SELECT * FROM customers
WHERE customer_id IN (
    SELECT customer_id FROM orders
    WHERE order_amount > (SELECT AVG(order_amount) FROM orders)
);

-- d. Aggregate functions (SUM, AVG)
-- 7. Total revenue by product category
SELECT p.category, SUM(oi.quantity * oi.item_price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category;

-- 8. Average order amount per customer
SELECT customer_id, AVG(order_amount) AS avg_order_value
FROM orders
GROUP BY customer_id;

-- e. Create views for analysis
-- 9. Create a view for completed orders
CREATE VIEW completed_orders_view AS
SELECT * FROM orders WHERE order_status = 'Completed';

-- 10. View: revenue per customer
CREATE VIEW customer_revenue_view AS
SELECT c.customer_id, c.customer_name, SUM(o.order_amount) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- f. Optimize queries with indexes
-- 11. Add index to speed up lookup by customer_id and product_id
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);
