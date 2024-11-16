-- Table: Weather

-- +---------------+---------+
-- | Column Name   | Type    |
-- +---------------+---------+
-- | id            | int     |
-- | recordDate    | date    |
-- | temperature   | int     |
-- +---------------+---------+
-- id is the column with unique values for this table.
-- There are no different rows with the same recordDate.
-- This table contains information about the temperature on a certain day.
 

-- Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).

-- Return the result table in any order.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Weather table:
-- +----+------------+-------------+
-- | id | recordDate | temperature |
-- +----+------------+-------------+
-- | 1  | 2015-01-01 | 10          |
-- | 2  | 2015-01-02 | 25          |
-- | 3  | 2015-01-03 | 20          |
-- | 4  | 2015-01-04 | 30          |
-- +----+------------+-------------+
-- Output: 
-- +----+
-- | id |
-- +----+
-- | 2  |
-- | 4  |
-- +----+
-- Explanation: 
-- In 2015-01-02, the temperature was higher than the previous day (10 -> 25).
-- In 2015-01-04, the temperature was higher than the previous day (20 -> 30).

SELECT *
FROM Weather w1
LEFT JOIN Weather w2
ON w1.recordDate - 1 = w2.recordDate

-- Output
-- | id | recordDate | temperature | id   | recordDate | temperature |
-- | -- | ---------- | ----------- | ---- | ---------- | ----------- |
-- | 1  | 2015-01-01 | 10          | null | null       | null        |
-- | 2  | 2015-01-02 | 25          | 1    | 2015-01-01 | 10          |
-- | 3  | 2015-01-03 | 20          | 2    | 2015-01-02 | 25          |
-- | 4  | 2015-01-04 | 30          | 3    | 2015-01-03 | 20 

-- we can see id 2 and 4 have dates where temp is greater than prev dates

SELECT w1.id 
FROM Weather w1
LEFT JOIN Weather w2
ON w1.recordDate - INTERVAL 1 DAY = w2.recordDate
WHERE w1.temperature > w2.temperature;

-- Interval used to substract day as if subtracted from 1st june will give you 0 june in normal cases