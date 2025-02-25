-- table to store results
CREATE TABLE salary_histogram (
    binnum INT PRIMARY KEY NOT NULL,
    frequency INT,
    binstart INT,
    binend INT
);


DROP PROCEDURE JAGAD.GEN_SALARY_HISTOGRAM;

CREATE PROCEDURE gen_salary_histogram (IN starting_range DECIMAL (10, 2), IN ending_range DECIMAL (10, 2), IN number_of_bins INT)
SPECIFIC gen_salary_histogram
LANGUAGE SQL
BEGIN
	DECLARE bin_width INT;
	DECLARE bin_start INT;
	DECLARE bin_end INT;
	DECLARE bin_count INT;
	DECLARE SQLSTATE CHAR(5) DEFAULT '00000';
	DECLARE i INT;
--	DECLARE c CURSOR FOR SELECT salary FROM EMPLOYEE e WHERE salary >= starting_range AND salary < ending_range ORDER BY salary;

	DELETE FROM JAGAD.SALARY_HISTOGRAM; 
	
	SET bin_width = (ending_range - starting_range) / number_of_bins;
	SET i = 1;
	SET bin_count = 0;	

-- without using cursor
	WHILE(i <= number_of_bins) DO
		SET bin_start = starting_range + ((i - 1) * bin_width);
		SET bin_end = starting_range + (i * bin_width);

		INSERT INTO SALARY_HISTOGRAM (binnum, frequency, binstart, binend) SELECT i, COUNT(*), bin_start, bin_end FROM EMPLOYEE WHERE salary >= bin_start AND salary < bin_end;
		SET i = i + 1;
	END WHILE;
END
-- with cursors : https://www.ibm.com/docs/en/db2/11.5?topic=procedures-cursors
--	OPEN c;
----	FETCH FROM c INTO p_sal;
----	FOR iterable_salary IN c LOOP
--	WHILE (SQLSTATE = '00000') AND (i <= number_of_bins) DO
--		SET bin_start = starting_range + ((i - 1) * bin_width);
--		SET bin_end = starting_range + (i * bin_width);
--	
--		WHILE (SQLSTATE = '00000') DO
--			SET bin_count = bin_count + 1;
----				FETCH FROM c INTO p_sal;
--		END WHILE;
--		
--		INSERT INTO SALARY_HISTOGRAM (binnum, frequency, binstart, binend) VALUES(i, bin_count, bin_start, bin_end);
--		SET bin_count = 0;
--		SET i = i + 1;
--	END WHILE;
--	CLOSE c;
--END

CALL JAGAD.GEN_SALARY_HISTOGRAM(30000, 170000, 7)

