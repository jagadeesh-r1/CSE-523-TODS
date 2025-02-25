DROP TABLE CSE532.uszip;

!db2se import_shape sample
-fileName         C:\Users\jagad\Downloads\tl_2019_us_zcta510\tl_2019_us_zcta510.shp
-srsName          nad83_srs_1
-tableSchema      cse532
-tableName        uszip
-spatialColumn    shape
-client           1
;
 
!db2se register_spatial_column sample
-tableSchema      cse532
-tableName        uszip
-columnName       shape
-srsName          nad83_srs_1
;