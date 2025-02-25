SELECT DISTINCT TEST.AUTHORNAME,MAX(TEST.MAXCOAUTHORS) AS MOSTCOAUTHORS
FROM Publications p, 
XMLTABLE(
    'for $author in distinct-values($PUB/r/*/author[1])
     let $maxCoAuthors := max($PUB/r/*[author = $author]/count(author))
     return $PUB/r/*[author = $author and count(author) = $maxCoAuthors][1]'
    PASSING p.Document AS "PUB" 
    COLUMNS 
        MaxCoAuthors INT PATH 'count(author)',
        AuthorName VARCHAR(100) PATH 'author[1]',
        Title VARCHAR(100) PATH 'title'
) AS TEST GROUP BY TEST.AUTHORNAME ORDER BY MOSTCOAUTHORS DESC 
