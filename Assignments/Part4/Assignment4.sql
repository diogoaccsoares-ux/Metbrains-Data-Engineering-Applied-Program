
-- create
CREATE TABLE CUSTOMERS (
  customer_Id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  city TEXT NOT NULL
);

CREATE TABLE ORDERS (
  order_Id INTEGER PRIMARY KEY,
  customer_Id INTEGER NOT NULL,
  date DATE NOT NULL,
  amount INTEGER
);

ALTER TABLE ORDERS
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_Id)
REFERENCES CUSTOMERS(customer_Id);

-- insert
INSERT INTO CUSTOMERS (customer_Id, name, city) VALUES
(1, 'Diogo', 'Coimbra'),
(2, 'Pedro', 'Paris'),
(3, 'Maria', 'London'),
(4, 'Neeraj', 'Delhi'),
(5, 'Simon', 'Delhi'),
(6, 'Etubi', 'Abuja'),
(7, 'Ester', 'Sao Paulo'),
(8, 'Peter', 'New York'),
(9, 'John', 'Delhi'),
(10, 'Gabriel', 'Lisbon');

INSERT INTO ORDERS (order_Id, customer_Id, date, amount) VALUES
(1, 2, '2026-01-01', 300),
(2, 3, '2026-02-02', 500),
(3, 4, '2026-03-03', 20),
(4, 8, '2026-03-04', 1000),
(5, 2, '2026-01-05', 1500),
(6, 3, '2026-03-06', 679),
(7, 5, '2026-04-07', 556),
(8, 5, '2026-05-08', 125),
(9, 8, '2026-06-09', 60),
(10, 9, '2026-07-10', 2000),
(11, 4, '2026-08-11', 179),
(12, 3, '2026-10-12', 800),
(13, 5, '2026-10-13', 10),
(14, 9, '2026-11-14', 78),
(15, 4, '2026-12-15', 900);


-- fetch 
-- 1. Retrieve all customers from the city "Delhi".

SELECT * FROM CUSTOMERS
WHERE city='Delhi';

-- 2. Find total number of orders placed.
SELECT COUNT(*) AS total_orders
FROM ORDERS;

-- 3. Find customers who have never placed an order (use LEFT JOIN).
SELECT c.customer_Id, c.name, c.city
FROM CUSTOMERS c
LEFT JOIN ORDERS o
    ON c.customer_Id = o.customer_Id
WHERE o.order_Id IS NULL;

-- 4. Calculate total amount spent by each customer.
SELECT 
    c.customer_Id, 
    c.name, 
    c.city, 
    COALESCE(SUM(o.amount), 0) AS total_spent
FROM CUSTOMERS c
LEFT JOIN ORDERS o
    ON c.customer_Id = o.customer_Id
GROUP BY c.customer_Id, c.name, c.city
ORDER BY total_spent DESC;

-- 5. Retrieve top 3 highest order amounts.
SELECT *
FROM ORDERS
ORDER BY amount DESC
LIMIT 3;

-- 6. Find the monthly sales trends (GROUP BY month).
SELECT 
    DATE_FORMAT(date, '%m') AS month,
    SUM(amount) AS total_sales,
    COUNT(*) AS orders_count
FROM ORDERS
GROUP BY month
ORDER BY month;

-- 7. Write a query to categorize orders:
-- o amount < 500 → "Low"
-- o 500–1000 → "Medium"
-- o 1000 → "High"
SELECT 
    order_Id,
    customer_Id,
    date,
    amount,
    CASE
        WHEN amount < 500 THEN 'Low'
        WHEN amount >= 500 AND amount < 1000 THEN 'Medium'
        WHEN amount >= 1000 THEN 'High'
    END AS order_category
FROM ORDERS
ORDER BY amount DESC;
