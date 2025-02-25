LOAD FROM "C:\Users\jagad\AppData\Roaming\DBeaverData\workspace6\CSE532\Scripts\zipcodepopulation.csv" 
OF  DEL METHOD P ( 1, 2, 3, 4 ) 
MESSAGES "C:\Users\jagad\AppData\Roaming\DBeaverData\workspace6\CSE532\Scripts\loadmsg.txt"
INSERT INTO CSE532.ZIPCENSUS ( RANK, POPULATION_DENSITY, ZIPCODE, POPULATION );