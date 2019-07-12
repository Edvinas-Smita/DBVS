SELECT	'Is viso' AS "Tipas",
	COUNT(*) AS "Kiekis"
FROM	information_schema.tables
UNION
SELECT	CASE	WHEN table_type = 'VIEW'
		THEN 'Virtuali'
		ELSE CASE	WHEN table_type = 'BASE TABLE'
				THEN 'Bazine'
				ELSE table_type
				END
		END AS "Tipas",
	COUNT(*) AS "Kiekis"
FROM	information_schema.tables
GROUP BY table_type;
