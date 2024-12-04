-- Table: Sales

-- +-------------+-------+
-- | Column Name | Type  |
-- +-------------+-------+
-- | sale_id     | int   |
-- | product_id  | int   |
-- | year        | int   |
-- | quantity    | int   |
-- | price       | int   |
-- +-------------+-------+
-- (sale_id, year) is the primary key (combination of columns with unique values) of this table.
-- product_id is a foreign key (reference column) to Product table.
-- Each row of this table shows a sale on the product product_id in a certain year.
-- Note that the price is per unit.
 

-- Table: Product

-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | product_id   | int     |
-- | product_name | varchar |
-- +--------------+---------+
-- product_id is the primary key (column with unique values) of this table.
-- Each row of this table indicates the product name of each product.
 

-- Write a solution to select the product id, year, quantity, and price for the first year of every product sold.

-- Return the resulting table in any order.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Sales table:
-- +---------+------------+------+----------+-------+
-- | sale_id | product_id | year | quantity | price |
-- +---------+------------+------+----------+-------+ 
-- | 1       | 100        | 2008 | 10       | 5000  |
-- | 2       | 100        | 2009 | 12       | 5000  |
-- | 7       | 200        | 2011 | 15       | 9000  |
-- +---------+------------+------+----------+-------+
-- Product table:
-- +------------+--------------+
-- | product_id | product_name |
-- +------------+--------------+
-- | 100        | Nokia        |
-- | 200        | Apple        |
-- | 300        | Samsung      |
-- +------------+--------------+
-- Output: 
-- +------------+------------+----------+-------+
-- | product_id | first_year | quantity | price |
-- +------------+------------+----------+-------+ 
-- | 100        | 2008       | 10       | 5000  |
-- | 200        | 2011       | 15       | 9000  |
-- +------------+------------+----------+-------+

-- STEP 1 
-- Product of 1st year sale
SELECT product_id, MIN(year) AS first_year
FROM Sales
GROUP BY product_id

-- Output
-- | product_id | first_year |
-- | ---------- | ---------- |
-- | 100        | 2008       |
-- | 200        | 2011       |

SELECT s.*, T.first_year
FROM Sales s
LEFT JOIN
(SELECT product_id, MIN(year) AS first_year
FROM Sales
GROUP BY product_id) T
ON s.product_id = T.product_id

-- | sale_id | product_id | year | quantity | price | first_year |
-- | ------- | ---------- | ---- | -------- | ----- | ---------- |
-- | 1       | 100        | 2008 | 10       | 5000  | 2008       |
-- | 2       | 100        | 2009 | 12       | 5000  | 2008       |
-- | 7       | 200        | 2011 | 15       | 9000  | 2011       |

-- STEP 2
-- TO keep year = first_year
SELECT s.*, T.first_year
FROM Sales s
LEFT JOIN
(SELECT product_id, MIN(year) AS first_year
FROM Sales
GROUP BY product_id) T
ON s.product_id = T.product_id
WHERE s.year = T.first_year -- added line

-- # STEP 3
-- get required columns

SELECT s.product_id, T.first_year, s.quantity, s.price
FROM Sales s
LEFT JOIN
(SELECT product_id, MIN(year) AS first_year
FROM Sales
GROUP BY product_id) T
ON s.product_id = T.product_id
WHERE s.year = T.first_year




-- second solution
SELECT product_id, year AS first_year, quantity, price
FROM Sales
WHERE (product_id, year) IN
( SELECT product_id, MIN(year)
FROM Sales
GROUP BY product_id
)
