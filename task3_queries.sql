
-- 1. Select all customers
SELECT * FROM customers;

-- 2. List all orders with customer names
SELECT o.order_id, c.name, o.order_date, o.total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- 3. Total spending per customer
SELECT c.name, SUM(o.total_amount) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.name;

-- 4. Orders above a threshold
SELECT * FROM orders WHERE total_amount > 200;

-- 5. Average order amount
SELECT AVG(total_amount) AS average_order_value FROM orders;

-- 6. Create a view for customer order summary
CREATE VIEW customer_order_summary AS
SELECT c.customer_id, c.name, COUNT(o.order_id) AS total_orders, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

-- 7. Customers with highest spending using subquery
SELECT name FROM customers 
WHERE customer_id IN (
  SELECT customer_id FROM orders GROUP BY customer_id 
  HAVING SUM(total_amount) = (
    SELECT MAX(total_spent) FROM (
      SELECT customer_id, SUM(total_amount) AS total_spent FROM orders GROUP BY customer_id
    ) AS spending
  )
);

-- 8. Create index on order_date for optimization (optional)
CREATE INDEX idx_order_date ON orders(order_date);
