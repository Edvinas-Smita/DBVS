SELECT	col.table_name AS "lentele",
	col.column_name AS "stulpelis",
	col.data_type AS "stulpelio tipas"
FROM	information_schema.tables AS tbl,
	information_schema.columns AS col
WHERE	tbl.table_catalog = col.table_catalog
AND	tbl.table_catalog = 'biblio'
AND	tbl.table_schema = col.table_schema
AND	tbl.table_schema = 'stud'
AND	tbl.table_name = col.table_name;
