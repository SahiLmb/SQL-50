-- Table: Products

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | product_id    | int     |
-- | new_price     | int     |
-- | change_date   | date    |
-- +---------------+---------+
-- (product_id, change_date) is the primary key (combination of columns with unique values) of this table.
-- Each row of this table indicates that the price of some product was changed to a new price at some date.
 

-- Write a solution to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.

-- Return the result table in any order.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Products table:
-- +------------+-----------+-------------+
-- | product_id | new_price | change_date |
-- +------------+-----------+-------------+
-- | 1          | 20        | 2019-08-14  |
-- | 2          | 50        | 2019-08-14  |
-- | 1          | 30        | 2019-08-15  |
-- | 1          | 35        | 2019-08-16  |
-- | 2          | 65        | 2019-08-17  |
-- | 3          | 20        | 2019-08-18  |
-- +------------+-----------+-------------+
-- Output: 
-- +------------+-------+
-- | product_id | price |
-- +------------+-------+
-- | 2          | 50    |
-- | 1          | 35    |
-- | 3          | 10    |
-- +------------+-------+

-- Get the diffrence from the date specified.
SELECT *,DATEDIFF('2019-08-16',change_date) AS diff
FROM Products ;

-- | product_id | new_price | change_date | diff |
-- | ---------- | --------- | ----------- | ---- |
-- | 1          | 20        | 2019-08-14  | 2    |
-- | 2          | 50        | 2019-08-14  | 2    |
-- | 1          | 30        | 2019-08-15  | 1    |
-- | 1          | 35        | 2019-08-16  | 0    |
-- | 2          | 65        | 2019-08-17  | -1   |
-- | 3          | 20        | 2019-08-18  | -2   |

--find minimum diff that is not less than zero
WITH data AS
(SELECT *,DATEDIFF('2019-08-16',change_date) AS diff
FROM Products)

SELECT product_id, MIN(diff) AS min_diff
FROM data
WHERE diff >= 0
GROUP BY product_id

-- for product id 1 the change was made on 16-08-2019
-- for product id 2 the change was made on 14-08-2019
-- | product_id | min_diff |
-- | ---------- | -------- |
-- | 1          | 0        |
-- | 2          | 2        |


WITH data AS
(SELECT *,DATEDIFF('2019-08-16',change_date) AS diff
FROM Products)

SELECT data.*, d2.min_diff
FROM data
LEFT JOIN
(SELECT product_id, MIN(diff) AS min_diff
FROM data
WHERE diff >= 0
GROUP BY product_id) d2
ON data.product_id = d2.product_id

-- | product_id | new_price | change_date | diff | min_diff |
-- | ---------- | --------- | ----------- | ---- | -------- |
-- | 1          | 20        | 2019-08-14  | 2    | 0        |
-- | 2          | 50        | 2019-08-14  | 2    | 2        |
-- | 1          | 30        | 2019-08-15  | 1    | 0        |
-- | 1          | 35        | 2019-08-16  | 0    | 0        |
-- | 2          | 65        | 2019-08-17  | -1   | 2        |
-- | 3          | 20        | 2019-08-18  | -2   | null     |


WITH data AS
(SELECT *,DATEDIFF('2019-08-16',change_date) AS diff
FROM Products)

-- used case when to get the price when diffrences are equal
SELECT data.*, d2.min_diff, CASE WHEN data.diff = d2.min_diff
THEN new_price WHEN data.diff <> d2.min_diff THEN 0 ELSE NULL
END AS price
FROM data
LEFT JOIN
(SELECT product_id, MIN(diff) AS min_diff
FROM data
WHERE diff >= 0
GROUP BY product_id) d2
ON data.product_id = d2.product_id

-- | product_id | new_price | change_date | diff | min_diff | price |
-- | ---------- | --------- | ----------- | ---- | -------- | ----- |
-- | 1          | 20        | 2019-08-14  | 2    | 0        | 0     |
-- | 2          | 50        | 2019-08-14  | 2    | 2        | 50    |
-- | 1          | 30        | 2019-08-15  | 1    | 0        | 0     |
-- | 1          | 35        | 2019-08-16  | 0    | 0        | 35    |
-- | 2          | 65        | 2019-08-17  | -1   | 2        | 0     |
-- | 3          | 20        | 2019-08-18  | -2   | null     | null  |

-- Group by product_id and get sum of each id As price and if null replcae with 10
WITH data AS
(SELECT *,DATEDIFF('2019-08-16',change_date) AS diff
FROM Products)

SELECT T.product_id, IFNULL(SUM(T.price),10) AS price
FROM (SELECT data.*, d2.min_diff, CASE WHEN data.diff = d2.min_diff
THEN new_price WHEN data.diff <> d2.min_diff THEN 0 ELSE NULL
END AS price
FROM data
LEFT JOIN
(SELECT product_id, MIN(diff) AS min_diff
FROM data
WHERE diff >= 0
GROUP BY product_id) d2
ON data.product_id = d2.product_id) T
GROUP BY T.product_id

-- | product_id | price |
-- | ---------- | ----- |
-- | 1          | 35    |
-- | 2          | 50    |
-- | 3          | 10    |
