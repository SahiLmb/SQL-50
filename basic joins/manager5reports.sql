-- Table: Employee

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | name        | varchar |
-- | department  | varchar |
-- | managerId   | int     |
-- +-------------+---------+
-- id is the primary key (column with unique values) for this table.
-- Each row of this table indicates the name of an employee, their department, and the id of their manager.
-- If managerId is null, then the employee does not have a manager.
-- No employee will be the manager of themself.
 

-- Write a solution to find managers with at least five direct reports.

-- Return the result table in any order.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Employee table:
-- +-----+-------+------------+-----------+
-- | id  | name  | department | managerId |
-- +-----+-------+------------+-----------+
-- | 101 | John  | A          | null      |
-- | 102 | Dan   | A          | 101       |
-- | 103 | James | A          | 101       |
-- | 104 | Amy   | A          | 101       |
-- | 105 | Anne  | A          | 101       |
-- | 106 | Ron   | B          | 101       |
-- +-----+-------+------------+-----------+
-- Output: 
-- +------+
-- | name |
-- +------+
-- | John |
-- +------+


SELECT *
FROM Employee e1
INNER JOIN Employee e2
ON e1.managerId = e2.Id

-- Output
-- | id  | name  | department | managerId | id  | name | department | managerId |
-- | --- | ----- | ---------- | --------- | --- | ---- | ---------- | --------- |
-- | 106 | Ron   | B          | 101       | 101 | John | A          | null      |
-- | 105 | Anne  | A          | 101       | 101 | John | A          | null      |
-- | 104 | Amy   | A          | 101       | 101 | John | A          | null      |
-- | 103 | James | A          | 101       | 101 | John | A          | null      |
-- | 102 | Dan   | A          | 101       | 101 | John | A          | null      |

-- We got all the employees under manager 101 John

SELECT e2.name
FROM Employee e1
INNER JOIN Employee e2
ON e1.managerId = e2.Id
GROUP BY e2.name
HAVING COUNT(e1.id) >= 5;

-- Output
-- | name |
-- | ---- |
-- | John |

-- Although it's running successfully, it still does not pass all the use cases.
-- We have grouped by e2.name, there can be two johns as well so in output two johns can come.


SELECT e2.name
FROM Employee e1
INNER JOIN Employee e2
ON e1.managerId = e2.Id
GROUP BY e2.id, e2.name
HAVING COUNT(e1.id) >= 5;

-- Here we grouped by id and name as id is unique so no repeatation on john