-- Заодно и название региона выведем
SELECT a.title,
       avg(compensation_from)::int as avg_comp_from,
       avg(compensation_to)::int as avg_comp_to,
       avg((compensation_to + compensation_from)/2)::int as avg_avg_comp
FROM vacancy v
RIGHT JOIN employer e on v.employer_id = e.employer_id
RIGHT JOIN area_name a on e.area_id = a.area_id
GROUP BY a.area_id ORDER BY avg_avg_comp DESC;