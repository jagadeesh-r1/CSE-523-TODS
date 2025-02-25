3a. Based on all days in the year, hour 16 or 4:00 pm has the peak of collisions.
- hourly (24 hours) and monthly (12 months) counts of collision using CUBE based OLAP query
HOUR|MONTH|COLLISION_COUNT|
----+-----+---------------+
  16|    6|           1678|
  17|    6|           1637|
  16|    5|           1632|
  17|    5|           1624|
  16|    9|           1529|
  16|   10|           1524|
  14|    6|           1514|
  17|   12|           1495|
  16|    3|           1457|
  17|    7|           1433|
  14|    5|           1418|
  16|    7|           1418|
  16|    8|           1414|
  17|    9|           1412|
  17|    3|           1407|
  14|   10|           1403|
  17|   11|           1388|
... 288 rows without null values in hour/month value or 325 including nulls. (attached results picture)


- for peak hour.
HOUR|COLLISION_COUNT|
----+---------------+
  16|          16973|


3c. For the top 10 most dangerous locations the zipcode given in the dataset is different than the code from gps-coordinates.net.

latitude  | longitude  | given_zipcode | actual_zipcode
40.758980 | -73.995950 |  10036        | 10018
40.720320 | -73.994040 |  10012        | 10002
40.724136 | -73.992615 |  10012        | 10002

------------------------------------------EXTRA CREDIT-------------------------------------------
q1. Based on all days in the year, hour 16 or 4:00 pm has the peak of collisions.

HOUR|COLLISION_COUNT|
----+---------------+
  16|         146337|

q2. 

P_ZIP | P_RANK | C_ZIP | COLLISIONS | C_RANK
11236 |	8      | 11236 | 1938	    | 2
11234 |	10     | 11234 | 1917	    | 3           // RESULT FOR COLLISION TABLE
11226 |	7      | 11226 | 1882	    | 6
11385 |	4      | 11385 | 1791	    | 10


11385 |	4      | 11385 | 17430      | 6
11236 |	8      | 11236 | 18665	    | 3           // RESULT FOR COLLISION_ALL TABLE
11234 |	10     | 11234 | 17530	    | 5

Here, as we can see the zipcode 11226 is missing from the COLLISION_ALL result as the top 10 collisions does not contain it.

q3.

LATITUDE  | LONGITUDE  | ZIPCODE | COLLISIONS
40.820305 | -73.890830 | 10459	 | 115
40.696033 | -73.984530 | 11201	 | 107
40.816864 | -73.882744 | 10474	 | 89
40.759514 | -73.999260 | 10018	 | 86
40.758980 | -73.995950 | 10036	 | 84             // RESULT FOR COLLISION TABLE
40.861862 | -73.912820 | 10453	 | 79
40.720320 | -73.994040 | 10012	 | 76
40.760822 | -73.998320 | 10036	 | 76
40.724136 | -73.992615 | 10012	 | 75
40.760600 | -73.964340 | 10022	 | 70


40.696034 | -73.984529 | 11201	 | 587
40.696033 | -73.984530 | 11201	 | 513
40.861862 | -73.912820 | 10453	 | 478
40.760600 | -73.964314 | 10022	 | 474
40.757232 | -73.989792 | 10036	 | 456
40.675735 | -73.896853 | 11207	 | 435            // RESULT FOR COLLISION_ALL TABLE
40.820305 | -73.890830 | 10459	 | 428
40.658577 | -73.890622 | 11207	 | 418
40.816864 | -73.882744 | 10474	 | 405
40.758980 | -73.995950 | 10036	 | 382

Here the top 10 locations change from collision to collision_all tables, as the data points increase the locations with more collisions recorded rose to top of the list. Zipcodes like 10459, 11201, 10474, 10036 can be seen shuffled ranks based on the number of collisions change.
