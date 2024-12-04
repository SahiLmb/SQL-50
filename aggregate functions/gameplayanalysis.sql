-- Table: Activity

-- +--------------+---------+
-- | Column Name  | Type    |
-- +--------------+---------+
-- | player_id    | int     |
-- | device_id    | int     |
-- | event_date   | date    |
-- | games_played | int     |
-- +--------------+---------+
-- (player_id, event_date) is the primary key (combination of columns with unique values) of this table.
-- This table shows the activity of players of some games.
-- Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 

-- Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.

-- The result format is in the following example.

 

-- Example 1:

-- Input: 
-- Activity table:
-- +-----------+-----------+------------+--------------+
-- | player_id | device_id | event_date | games_played |
-- +-----------+-----------+------------+--------------+
-- | 1         | 2         | 2016-03-01 | 5            |
-- | 1         | 2         | 2016-03-02 | 6            |
-- | 2         | 3         | 2017-06-25 | 1            |
-- | 3         | 1         | 2016-03-02 | 0            |
-- | 3         | 4         | 2018-07-03 | 5            |
-- +-----------+-----------+------------+--------------+
-- Output: 
-- +-----------+
-- | fraction  |
-- +-----------+
-- | 0.33      |
-- +-----------+
-- Explanation: 
-- Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33


-- # STEP 1 To identify first login date

SELECT player_id, MIN(event_date) AS FLD
FROM Activity 
GROUP BY player_id

-- Output
-- | player_id | FLD        |
-- | --------- | ---------- |
-- | 1         | 2016-03-01 |
-- | 2         | 2017-06-25 |
-- | 3         | 2016-03-02 |

-- # Step 2 Identify consecutive players
SELECT a.*, t.player_id
FROM Activity a
LEFT JOIN 
(SELECT player_id, MIN(event_date) AS FLD -- first login date(FLD)
FROM Activity 
GROUP BY player_id) T
ON a.player_id = T.player_id
AND DATE_SUB(a.event_date,INTERVAL 1 DAY) = T.FLD -- Interval used because we need to substract a date not a number

-- Output
-- | player_id | device_id | event_date | games_played | player_id |
-- | --------- | --------- | ---------- | ------------ | --------- |
-- | 1         | 2         | 2016-03-01 | 5            | null      |
-- | 1         | 2         | 2016-03-02 | 6            | 1         |
-- | 2         | 3         | 2017-06-25 | 1            | null      |
-- | 3         | 1         | 2016-03-02 | 0            | null      |
-- | 3         | 4         | 2018-07-03 | 5            | null      |

-- # Step 3 Find the fraction

SELECT ROUND(COUNT(DISTINCT T.player_id)/COUNT(DISTINCT a.player_id),2) AS fraction
FROM Activity a
LEFT JOIN 
(SELECT player_id, MIN(event_date) AS FLD -- first login date(FLD)
FROM Activity 
GROUP BY player_id) T
ON a.player_id = T.player_id
AND DATE_SUB(a.event_date,INTERVAL 1 DAY) = T.FLD -- Interval used because we need to substract a date not a number

-- Output
-- | fraction |
-- | -------- |
-- | 0.33     |

