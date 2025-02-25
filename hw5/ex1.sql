DROP TABLE PUBLICATIONS ;
DROP TABLE TEMP_TABLE;
DROP TABLE TEMP_TABLE2;



CREATE TABLE Publications (
	id INT GENERATED BY DEFAULT AS IDENTITY,
	Document XML,
    PRIMARY KEY(id)
);

CREATE TABLE temp_table (
    data CLOB(100M)
)

CREATE TABLE temp_table2 (
    data CLOB(100M)
)

-- do it in terminal
-- LOAD FROM 'C:\Users\jagad\OneDrive\Documents\Fall 2023\hw5\DAPatterson_test.xml' OF DEL INSERT INTO DB2ADMIN.temp_table
--  LOAD FROM 'C:\Users\jagad\OneDrive\Documents\Fall 2023\hw5\JohnLHennessy_test.xml' OF DEL INSERT INTO DB2ADMIN.temp_table2

INSERT INTO PUBLICATIONS(Document) SELECT XMLPARSE(DOCUMENT data) FROM temp_table

INSERT INTO PUBLICATIONS(Document) SELECT XMLPARSE(DOCUMENT data) FROM temp_table2


SELECT * FROM PUBLICATIONS p ;


--XQuery
--db2-fn:xmlcolumn('PUBLICATIONS.DOCUMENT')
--/r/article/author/text()
