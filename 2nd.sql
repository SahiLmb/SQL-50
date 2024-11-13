-- Optimal approach
SELECT name
FROM Customer
WHERE IFNULL(referee_id, -1) <> 2; -- # if referee_id is null substitute with -1 and also check if not equal to 2.