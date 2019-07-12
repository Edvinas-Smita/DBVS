SELECT	kng.pavadinimas AS "Pavadinimas",
	skait.vardas AS "Vardas",
	skait.pavarde AS "Pavarde"
FROM	stud.knyga AS kng
		JOIN
	stud.egzempliorius AS egz
		ON kng.isbn = egz.isbn
		LEFT OUTER JOIN
	stud.skaitytojas AS skait
		ON egz.skaitytojas = skait.nr
WHERE	regexp_replace
	(
		kng.pavadinimas,
		'[^a-zA-Z]',
		'',
		'g'
	)
	~* regexp_replace
	(
		substring
		(
			:v1 FROM
			'(?<=[^a-zA-Z]*)([a-zA-Z]+[\s_+-]*[a-zA-Z]+)(?=[^a-zA-Z]*$)'
		),
		'[^a-zA-Z]',
		'',
		'g'
	);
