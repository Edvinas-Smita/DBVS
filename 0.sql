/*WITH vyr AS
(
	SELECT	kng.pavadinimas AS "pavadinimas",
		COUNT(egz.skaitytojas) AS "skaito"
	FROM	stud.knyga AS kng
			JOIN
		stud.egzempliorius AS egz
			ON kng.isbn = egz.isbn
			JOIN
		stud.skaitytojas AS skait
			ON egz.skaitytojas = skait.nr
	WHERE	skait.ak SIMILAR TO '3%'
	GROUP BY kng.isbn
), mot AS
(
	SELECT	kng.pavadinimas AS "pavadinimas",
		COUNT(egz.skaitytojas) AS "skaito"
	FROM	stud.knyga AS kng
			JOIN
		stud.egzempliorius AS egz
			ON kng.isbn = egz.isbn
			JOIN
		stud.skaitytojas AS skait
			ON egz.skaitytojas = skait.nr
	WHERE	skait.ak SIMILAR TO '4%'
	GROUP BY kng.isbn
), maxes AS
(
	SELECT	MAX(vyr.skaito) AS "vyr", MAX(mot.skaito) AS "mot"
	FROM	vyr, mot
)
SELECT	vyr.pavadinimas || ' (' || maxes.vyr || ')' AS "Skaitomiausia tarp vyru",
	mot.pavadinimas || ' (' || maxes.mot || ')' AS "Skaitomiausia tarp moteru"
FROM	vyr,
	mot,
	maxes
WHERE	vyr.skaito = maxes.vyr
AND	mot.skaito = maxes.mot;*/
WITH counts AS
(
	SELECT	substring(skait.ak from 1 for 1) AS "sk",
		kng.pavadinimas AS "pavadinimas",
		COUNT(egz.skaitytojas) AS "skaito"
	FROM	stud.knyga AS kng
			JOIN
		stud.egzempliorius AS egz
			ON kng.isbn = egz.isbn
			JOIN
		stud.skaitytojas AS skait
			ON egz.skaitytojas = skait.nr
	GROUP BY substring(skait.ak from 1 for 1),
		kng.isbn
	ORDER BY substring(skait.ak from 1 for 1),
		COUNT(egz.skaitytojas)
), maxes AS
(
	SELECT	counts.sk,
		MAX(counts.skaito) AS "cnt"
	FROM	counts
	GROUP BY counts.sk
)
SELECT	counts.pavadinimas,
	CASE
		WHEN counts.sk = '3' then 'vyru'
		ELSE 'moteru'
	END AS "Populiariausia tarp"
FROM	counts
		JOIN
	maxes
		ON counts.sk = maxes.sk
WHERE	counts.skaito = maxes.cnt;
