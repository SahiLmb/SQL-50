-- Table: Queue

-- +-------------+---------+
-- | Column Name | Type    |
-- +-------------+---------+
-- | person_id   | int     |
-- | person_name | varchar |
-- | weight      | int     |
-- | turn        | int     |
-- +-------------+---------+
-- person_id column contains unique values.
-- This table has the information about all people waiting for a bus.
-- The person_id and turn columns will contain all numbers from 1 to n, where n is the number of rows in the table.
-- turn determines the order of which the people will board the bus, where turn=1 denotes the first person to board and turn=n denotes the last person to board.
-- weight is the weight of the person in kilograms.
 

-- There is a queue of people waiting to board a bus. However, the bus has a weight limit of 1000 kilograms, so there may be some people who cannot board.

-- Write a solution to find the person_name of the last person that can fit on the bus without exceeding the weight limit. The test cases are generated such that the first person does not exceed the weight limit.

-- Note that only one person can board the bus at any given turn.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Queue table:
-- +-----------+-------------+--------+------+
-- | person_id | person_name | weight | turn |
-- +-----------+-------------+--------+------+
-- | 5         | Alice       | 250    | 1    |
-- | 4         | Bob         | 175    | 5    |
-- | 3         | Alex        | 350    | 2    |
-- | 6         | John Cena   | 400    | 3    |
-- | 1         | Winston     | 500    | 6    |
-- | 2         | Marie       | 200    | 4    |
-- +-----------+-------------+--------+------+
-- Output: 
-- +-------------+
-- | person_name |
-- +-------------+
-- | John Cena   |
-- +-------------+
-- Explanation: The folowing table is ordered by the turn for simplicity.
-- +------+----+-----------+--------+--------------+
-- | Turn | ID | Name      | Weight | Total Weight |
-- +------+----+-----------+--------+--------------+
-- | 1    | 5  | Alice     | 250    | 250          |
-- | 2    | 3  | Alex      | 350    | 600          |
-- | 3    | 6  | John Cena | 400    | 1000         | (last person to board)
-- | 4    | 2  | Marie     | 200    | 1200         | (cannot board)
-- | 5    | 4  | Bob       | 175    | ___          |
-- | 6    | 1  | Winston   | 500    | ___          |
-- +------+----+-----------+--------+--------------+

SELECT q1.turn, SUM(q2.weight) AS running_weight
FROM Queue q1
LEFT JOIN Queue q2
ON q1.turn >= q2.turn
GROUP BY q1.turn
HAVING SUM(q2.weight) <= 1000
ORDER BY SUM(q2.weight) DESC

-- | turn | running_weight |
-- | ---- | -------------- |
-- | 3    | 1000           |
-- | 2    | 600            |
-- | 1    | 250            |

SELECT person_name
FROM Queue
WHERE turn =
(SELECT q1.turn
FROM Queue q1
LEFT JOIN Queue q2
ON q1.turn >= q2.turn
GROUP BY q1.turn
HAVING SUM(q2.weight) <= 1000
ORDER BY SUM(q2.weight) DESC
LIMIT 1);

-- | person_name |
-- | ----------- |
-- | John Cena   |


-- USING CTE

-- STEP 1
SELECT turn, person_name,weight, sum(weight) OVER(ORDER BY turn) as total_weight from Queue

-- | turn | person_name | weight | total_weight |
-- | ---- | ----------- | ------ | ------------ |
-- | 1    | Alice       | 250    | 250          |
-- | 2    | Alex        | 350    | 600          |
-- | 3    | John Cena   | 400    | 1000         |
-- | 4    | Marie       | 200    | 1200         |
-- | 5    | Bob         | 175    | 1375         |
-- | 6    | Winston     | 500    | 1875         |

-- STEP 2
WITH CTE as
(SELECT turn, person_name,weight, sum(weight) OVER(ORDER BY turn) as total_weight from Queue)

SELECT person_name
FROM CTE
where total_weight <=1000
ORDER BY total_weight DESC
LIMIT 1;

-- | person_name |
-- | ----------- |
-- | John Cena   |

