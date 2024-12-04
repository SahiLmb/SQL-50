-- Table: Users

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | user_id     | int     |
-- | user_name   | varchar |
-- +-------------+---------+
-- user_id is the primary key (column with unique values) for this table.
-- Each row of this table contains the name and the id of a user.
 

-- Table: Register

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | contest_id  | int     |
-- | user_id     | int     |
-- +-------------+---------+
-- (contest_id, user_id) is the primary key (combination of columns with unique values) for this table.
-- Each row of this table contains the id of a user and the contest they registered into.
 

-- Write a solution to find the percentage of the users registered in each contest rounded to two decimals.

-- Return the result table ordered by percentage in descending order. In case of a tie, order it by contest_id in ascending order.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Users table:
-- +---------+-----------+
-- | user_id | user_name |
-- +---------+-----------+
-- | 6       | Alice     |
-- | 2       | Bob       |
-- | 7       | Alex      |
-- +---------+-----------+
-- Register table:
-- +------------+---------+
-- | contest_id | user_id |
-- +------------+---------+
-- | 215        | 6       |
-- | 209        | 2       |
-- | 208        | 2       |
-- | 210        | 6       |
-- | 208        | 6       |
-- | 209        | 7       |
-- | 209        | 6       |
-- | 215        | 7       |
-- | 208        | 7       |
-- | 210        | 2       |
-- | 207        | 2       |
-- | 210        | 7       |
-- +------------+---------+
-- Output: 
-- +------------+------------+
-- | contest_id | percentage |
-- +------------+------------+
-- | 208        | 100.0      |
-- | 209        | 100.0      |
-- | 210        | 100.0      |
-- | 215        | 66.67      |
-- | 207        | 33.33      |
-- +------------+------------+
-- Explanation: 
-- All the users registered in contests 208, 209, and 210. The percentage is 100% and we sort them in the answer table by contest_id in ascending order.
-- Alice and Alex registered in contest 215 and the percentage is ((2/3) * 100) = 66.67%
-- Bob registered in contest 207 and the percentage is ((1/3) * 100) = 33.33%

SELECT r.contest_id, ROUND(COUNT(DISTINCT r.user_id)/
COUNT(DISTINCT u.user_id)*100,2) AS percentage
FROM Users u
CROSS JOIN Register r
GROUP BY r.contest_id
ORDER BY percentage DESC, r.contest_id;

-- r.contest_id will return the contest_id number in ascending order in case of tie.

-- 3. Example Calculation for Each Contest
-- We calculate the percentage for each contest_id:

-- contest_id = 208:

-- Registered users: 6, 7, 2 (all 3 users).
-- Unique users = 3.
-- Total users = 3.
-- Percentage = 
-- (
-- 3
-- /
-- 3
-- )
-- ×
-- 100
-- =
-- 100.0
-- %
-- (3/3)×100=100.0%.
-- contest_id = 209:

-- Registered users: 2, 7, 6 (all 3 users).
-- Unique users = 3.
-- Total users = 3.
-- Percentage = 
-- (
-- 3
-- /
-- 3
-- )
-- ×
-- 100
-- =
-- 100.0
-- %
-- (3/3)×100=100.0%.
-- contest_id = 210:

-- Registered users: 6, 7, 2 (all 3 users).
-- Unique users = 3.
-- Total users = 3.
-- Percentage = 
-- (
-- 3
-- /
-- 3
-- )
-- ×
-- 100
-- =
-- 100.0
-- %
-- (3/3)×100=100.0%.
-- contest_id = 215:

-- Registered users: 6, 7.
-- Unique users = 2.
-- Total users = 3.
-- Percentage = 
-- (
-- 2
-- /
-- 3
-- )
-- ×
-- 100
-- =
-- 66.67
-- %
-- (2/3)×100=66.67%.
-- contest_id = 207:

-- Registered users: 2.
-- Unique users = 1.
-- Total users = 3.
-- Percentage = 
-- (
-- 1
-- /
-- 3
-- )
-- ×
-- 100
-- =
-- 33.33
-- %
-- (1/3)×100=33.33%.
