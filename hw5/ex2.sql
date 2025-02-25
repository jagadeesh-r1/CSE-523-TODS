--SELECT XMLQUERY('$DATA/r/article/author/text()' PASSING DOCUMENT  AS "DATA") AS author
--FROM PUBLICATIONS p 

--WITH ARTICLES AS (SELECT TEST.* FROM PUBLICATIONS p, XMLTABLE('$DATA/r/article' PASSING p.DOCUMENT AS "DATA" COLUMNS TITLE VARCHAR(100) PATH 'title', AUTHORS VARCHAR(10000) PATH 'string-join(author, ", ")' ) AS TEST),
--INPROCEEDINGS AS (SELECT TEST.* FROM PUBLICATIONS p, XMLTABLE('$DATA/r/inproceedings' PASSING p.DOCUMENT AS "DATA" COLUMNS TITLE VARCHAR(100) PATH 'title', AUTHORS VARCHAR(10000) PATH 'string-join(author, ", ")' ) AS TEST),
--ALL_DATA AS (SELECT * FROM ARTICLES UNION ALL SELECT * FROM INPROCEEDINGS)
--SELECT * FROM ALL_DATA WHERE AUTHORS


SELECT DISTINCT AuthorName
FROM (
    SELECT TEST.* FROM Publications p, XMLTABLE('$PUB/r/*/author' PASSING p.Document AS "PUB" COLUMNS AuthorName VARCHAR(100) PATH '.') AS TEST
    WHERE XMLExists(
        '$PUB/r/*/author[text()="John L. Hennessy"]'
        PASSING p.Document AS "PUB"
    )
) AS HennessyAuthors
WHERE AuthorName IN (
SELECT TEST.* FROM Publications p, XMLTABLE('$PUB/r/*/author' PASSING p.Document AS "PUB" COLUMNS AuthorName VARCHAR(100) PATH '.') AS TEST
    WHERE XMLExists(
        '$PUB/r/*/author[text()="David A. Patterson 0001"]'
        PASSING p.Document AS "PUB"
    )
);
