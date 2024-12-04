-- Table: Accounts

-- +-------------+------+
-- | Column Name | Type |
-- +-------------+------+
-- | account_id  | int  |
-- | income      | int  |
-- +-------------+------+
-- account_id is the primary key (column with unique values) for this table.
-- Each row contains information about the monthly income for one bank account.
 

-- Write a solution to calculate the number of bank accounts for each salary category. The salary categories are:

-- "Low Salary": All the salaries strictly less than $20000.
-- "Average Salary": All the salaries in the inclusive range [$20000, $50000].
-- "High Salary": All the salaries strictly greater than $50000.
-- The result table must contain all three categories. If there are no accounts in a category, return 0.

-- Return the result table in any order.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Accounts table:
-- +------------+--------+
-- | account_id | income |
-- +------------+--------+
-- | 3          | 108939 |
-- | 2          | 12747  |
-- | 8          | 87709  |
-- | 6          | 91796  |
-- +------------+--------+
-- Output: 
-- +----------------+----------------+
-- | category       | accounts_count |
-- +----------------+----------------+
-- | Low Salary     | 1              |
-- | Average Salary | 0              |
-- | High Salary    | 3              |
-- +----------------+----------------+
-- Explanation: 
-- Low Salary: Account 2.
-- Average Salary: No accounts.
-- High Salary: Accounts 3, 6, and 8.

SELECT *, CASE WHEN income < 20000 THEN 'Low Salary'
WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
ELSE 'High Salary' END AS category
FROM Accounts

-- | account_id | income | category    |
-- | ---------- | ------ | ----------- |
-- | 3          | 108939 | High Salary |
-- | 2          | 12747  | Low Salary  |
-- | 8          | 87709  | High Salary |
-- | 6          | 91796  | High Salary |

SELECT *
FROM (SELECT 'Low Salary' AS category UNION SELECT 'Average Salary'
UNION SELECT 'High Salary') cat
LEFT JOIN
(SELECT *, CASE WHEN income < 20000 THEN 'Low Salary'
WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
ELSE 'High Salary' END AS category
FROM Accounts) T
ON cat.category = T.category

-- | category       | account_id | income | category    |
-- | -------------- | ---------- | ------ | ----------- |
-- | Low Salary     | 2          | 12747  | Low Salary  |
-- | Average Salary | null       | null   | null        |
-- | High Salary    | 6          | 91796  | High Salary |
-- | High Salary    | 8          | 87709  | High Salary |
-- | High Salary    | 3          | 108939 | High Salary |

SELECT cat.category, COUNT(T.account_id) AS accounts_count
FROM (SELECT 'Low Salary' AS category UNION SELECT 'Average Salary'
UNION SELECT 'High Salary') cat
LEFT JOIN
(SELECT *, CASE WHEN income < 20000 THEN 'Low Salary'
WHEN income BETWEEN 20000 AND 50000 THEN 'Average Salary'
ELSE 'High Salary' END AS category
FROM Accounts) T
ON cat.category = T.category
GROUP BY cat.category

-- | category       | accounts_count |
-- | -------------- | -------------- |
-- | Low Salary     | 1              |
-- | Average Salary | 0              |
-- | High Salary    | 3              |

-- Another solution
SELECT "Low Salary" as category, sum(if(income<20000,1,0)) AS accounts_count FROM Accounts
union
SELECT "Average Salary" as category, sum(if(income>=20000 and income<=50000,1,0)) AS accounts_count FROM Accounts
union
SELECT "High Salary" as category, sum(if(income>50000,1,0)) AS accounts_count FROM Accounts