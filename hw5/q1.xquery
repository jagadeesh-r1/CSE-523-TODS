let $articles := /dblpperson/r/article[author = "David A. Patterson 0001"]
let $inproceedings := /dblpperson/r/inproceedings[author = "David A. Patterson 0001"]
let $publications := ($articles,$inproceedings)
let $acendingYears := distinct-values($publications/year)
for $year in sort($acendingYears)
    let $paperCount := count($publications[year = $year])
    let $totalAuthorCount := sum($publications[year = $year]/count(author))
    let $avgAuthorCount := $totalAuthorCount div $paperCount
return
    <r>
    <year>{$year}</year>
    <paperCount>{$paperCount}</paperCount>
    <avgAuthorCount>{$avgAuthorCount}</avgAuthorCount>
    </r>