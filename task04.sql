-- В задании запрос в ед. числе, вот и сделал один запрос
-- Ну и год тоже нужно учесть
SELECT * FROM
(
    SELECT count(vacancy_id) as count, TO_CHAR(vacancy.date, 'MM') as mounth, 'Вакансии' as Type
    FROM vacancy
    WHERE TO_CHAR(vacancy.date, 'YYYY') = '2021'
    GROUP BY mounth
    ORDER BY count DESC
    LIMIT 1
) AS foo
UNION
(
     SELECT count(response_id) as count, TO_CHAR (responses.date, 'MM') as mounth, 'Отклики'
     FROM responses
     WHERE TO_CHAR (responses.date, 'YYYY') = '2021'
     GROUP BY mounth ORDER BY count DESC
     LIMIT 1
);