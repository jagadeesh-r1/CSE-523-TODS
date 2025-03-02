--WITH HOURLY_MONTHLY AS (
--	SELECT EXTRACT(HOUR FROM TIME) AS PHOUR, EXTRACT(MONTH FROM DATE) AS PMONTH, COUNT(*) AS COLLISION_COUNT FROM CSE532.COLLISION c 
--	WHERE c.TIME IS NOT NULL AND c.DATE IS NOT NULL GROUP BY CUBE (c.TIME, c.DATE)
--)
--SELECT PHOUR AS HOUR, PMONTH AS MONTH, SUM(COLLISION_COUNT) AS COLLISION_COUNT FROM HOURLY_MONTHLY WHERE PHOUR IS NOT NULL AND PMONTH IS NOT NULL GROUP BY PMONTH, PHOUR ORDER BY COLLISION_COUNT DESC;

-- for peak hour uncomment below query and run it

WITH HOURLY_MONTHLY AS (
	SELECT EXTRACT(HOUR FROM TIME) AS PHOUR, EXTRACT(MONTH FROM DATE) AS PMONTH, COUNT(*) AS COLLISION_COUNT FROM CSE532.COLLISION c 
	WHERE c.TIME IS NOT NULL AND c.DATE IS NOT NULL GROUP BY CUBE (c.TIME, c.DATE)
)
SELECT HOUR, SUM(COLLISION_COUNT) AS COLLISION_COUNT FROM (
SELECT PHOUR AS HOUR, PMONTH AS MONTH, SUM(COLLISION_COUNT) AS COLLISION_COUNT FROM HOURLY_MONTHLY WHERE PHOUR IS NOT NULL AND PMONTH IS NOT NULL GROUP BY PMONTH, PHOUR ORDER BY COLLISION_COUNT DESC
)GROUP BY HOUR ORDER BY COLLISION_COUNT DESC LIMIT 1;