load data local infile 'filename.tsv'
into table tt_table_name
IGNORE 1 LINES		#if filename.tsv has headers
   (`column_1`, `column_2`, `column_3`, @column_4, @column_5)
set column_4 = nullif(@column_4,'')		#to have NULL and not blank
   , column_5 = nullif(@column_5,'');		#to have NULL and not blank