let $articles := /dblpperson/r/article[author = "John L. Hennessy"]
let $inproceedings := /dblpperson/r/inproceedings[author = "John L. Hennessy"]
let $publications := ($articles,$inproceedings)
let $maxCoAuthors := max($publications/count(author))
let $paperWithMostCoAuthors := $publications[author = "John L. Hennessy" and count(author) = $maxCoAuthors]
return 
<TitleswithMaxCount count="{$maxCoAuthors}">
    {$paperWithMostCoAuthors}
</TitleswithMaxCount>