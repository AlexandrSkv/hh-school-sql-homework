SELECT v.vacancy_id as id, position_name as title
FROM vacancy v
RIGHT JOIN Responses r on v.vacancy_id = r.vacancy_id
WHERE r.date <= (select date from vacancy where vacancy_id = v.vacancy_id) + (timestamp '2021-01-07 00:00:00' - timestamp '2021-01-01 00:00:00')
GROUP BY v.vacancy_id
HAVING count(r.vacancy_id) > 5;