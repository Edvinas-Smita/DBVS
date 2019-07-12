SELECT	COUNT(DISTINCT skaitytojas) AS "Skolingu skaitytoju kiekis",
	COUNT(*) - COUNT(skaitytojas) AS "Nepaimtos knygos"
FROM	stud.egzempliorius;
