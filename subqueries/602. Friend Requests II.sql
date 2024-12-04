-- Table: RequestAccepted

-- +----------------+---------+
-- | Column Name    | Type    |
-- +----------------+---------+
-- | requester_id   | int     |
-- | accepter_id    | int     |
-- | accept_date    | date    |
-- +----------------+---------+
-- (requester_id, accepter_id) is the primary key (combination of columns with unique values) for this table.
-- This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.
 

-- Write a solution to find the people who have the most friends and the most friends number.

-- The test cases are generated so that only one person has the most friends.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- RequestAccepted table:
-- +--------------+-------------+-------------+
-- | requester_id | accepter_id | accept_date |
-- +--------------+-------------+-------------+
-- | 1            | 2           | 2016/06/03  |
-- | 1            | 3           | 2016/06/08  |
-- | 2            | 3           | 2016/06/08  |
-- | 3            | 4           | 2016/06/09  |
-- +--------------+-------------+-------------+
-- Output: 
-- +----+-----+
-- | id | num |
-- +----+-----+
-- | 3  | 3   |
-- +----+-----+
-- Explanation: 
-- The person with id 3 is a friend of people 1, 2, and 4, so he has three friends in total, which is the most number than any others.
 

-- Follow up: In the real world, multiple people could have the same most number of friends. Could you find all these people in this case?

SELECT requester_id, accepter_id
From RequestAccepted 
UNION
SELECT accepter_id, requester_id
From RequestAccepted

-- Output
-- | requester_id | accepter_id |
-- | ------------ | ----------- |
-- | 1            | 2           |
-- | 1            | 3           |
-- | 2            | 3           |
-- | 3            | 4           |
-- | 2            | 1           |
-- | 3            | 1           |
-- | 3            | 2           |
-- | 4            | 3           |

SELECT requester_id AS id, COUNT(accepter_id) AS num
FROM 
(SELECT requester_id, accepter_id
From RequestAccepted 
UNION ALL
SELECT accepter_id, requester_id
From RequestAccepted) T 
GROUP BY requester_id
ORDER BY num DESC
LIMIT 1

-- Output: 
-- +----+-----+
-- | id | num |
-- +----+-----+
-- | 3  | 3   |
-- +----+-----+


USING CTE

WITH CTE AS(
    SELECT requester_id as id, accepter_id
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id as id, requester_id
    FROM RequestAccepted
),
RequestCounts AS(
    SELECT id, COUNT(accepter_id) as num
    FROM CTE
    GROUP BY id
)
SELECT id, num
From RequestCounts
ORDER BY num DESC
LIMIT 1