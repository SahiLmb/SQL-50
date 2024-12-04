-- Table: Seat

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | id          | int     |
-- | student     | varchar |
-- +-------------+---------+
-- id is the primary key (unique value) column for this table.
-- Each row of this table indicates the name and the ID of a student.
-- The ID sequence always starts from 1 and increments continuously.
 

-- Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.

-- Return the result table ordered by id in ascending order.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Seat table:
-- +----+---------+
-- | id | student |
-- +----+---------+
-- | 1  | Abbot   |
-- | 2  | Doris   |
-- | 3  | Emerson |
-- | 4  | Green   |
-- | 5  | Jeames  |
-- +----+---------+
-- Output: 
-- +----+---------+
-- | id | student |
-- +----+---------+
-- | 1  | Doris   |
-- | 2  | Abbot   |
-- | 3  | Green   |
-- | 4  | Emerson |
-- | 5  | Jeames  |
-- +----+---------+
-- Explanation: 
-- Note that if the number of students is odd, there is no need to change the last one's seat.

-- logic
-- If id is even decrease by 1
-- If id odd plus 1 or if odd id is max value then keep as it is

-- as you can see below
-- Input: 
-- Seat table:
-- +----+---------+
-- | id | student |
-- +----+---------+
-- | 1  | Abbot   |
-- | 2  | Doris   |
-- | 3  | Emerson |
-- | 4  | Green   |
-- | 5  | Jeames  |

-- Output: 
-- +----+---------+
-- | id | student |
-- +----+---------+
-- | 1  | Doris   | 2
-- | 2  | Abbot   | 1
-- | 3  | Green   | 4
-- | 4  | Emerson | 3
-- | 5  | Jeames  | 5
-- +----+---------+

# Write your MySQL query statement below
SELECT *, CASE WHEN id%2= 0 THEN id-1
WHEN id%2 = 1 AND id = (SELECT MAX(id) FROM Seat)
THEN id
ELSE id + 1 END AS new_id
FROM Seat

-- | id | student | new_id |
-- | -- | ------- | ------ |
-- | 1  | Abbot   | 2      |
-- | 2  | Doris   | 1      |
-- | 3  | Emerson | 4      |
-- | 4  | Green   | 3      |
-- | 5  | Jeames  | 5      |

SELECT CASE WHEN id%2= 0 THEN id-1
WHEN id%2 = 1 AND id = (SELECT MAX(id) FROM Seat)
THEN id
ELSE id + 1 END AS id, student
FROM Seat
ORDER BY id;


