WITH inventorius AS
(
	SELECT	egz.isbn AS "isbn",
		COUNT(egz.isbn) AS "kiekis",
--		CASE
--			WHEN kng.verte IS NULL then '10.00'
--			ELSE kng.verte
--		END AS "kaina"
		COALESCE(kng.verte, '10.00') AS "kaina"
	FROM	stud.knyga AS kng
			JOIN
		stud.egzempliorius AS egz
			ON kng.isbn = egz.isbn
	GROUP BY egz.isbn,
		kng.verte
),
bendrasVidurkis AS
(
	SELECT	AVG(inventorius.kiekis * inventorius.kaina) AS vidurkis
	FROM	inventorius
)
SELECT	kng.pavadinimas AS "Pavadinimas",
	CAST(inventorius.kiekis * inventorius.kaina AS DECIMAL(18, 2))
		AS "visu tokiu knygu kaina",
	CAST(bendrasVidurkis.vidurkis AS DECIMAL(18, 2))
		AS "Bendras vidurkis"
FROM 	inventorius
		JOIN
	stud.knyga AS kng
		ON inventorius.isbn = kng.isbn,
	bendrasVidurkis
WHERE 	inventorius.kiekis * inventorius.kaina < bendrasVidurkis.vidurkis;
