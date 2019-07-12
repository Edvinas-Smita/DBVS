SELECT	skait.vardas AS "Vardas",
	skait.pavarde AS "Pavarde",
	egz.paimta AS "Data",
	COUNT(egz.paimta) AS "Kiekis"
FROM	stud.egzempliorius AS egz
		JOIN
	stud.skaitytojas AS skait
		ON egz.skaitytojas = skait.nr
GROUP BY skait.vardas,
	skait.pavarde,
	egz.paimta
HAVING	COUNT(egz.paimta) > 0
ORDER BY skait.pavarde,
	skait.vardas,
	egz.paimta;
