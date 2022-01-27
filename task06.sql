-- Специальный индекс для поиска вакансий
CREATE INDEX vacancy_index on vacancy(position_name, date, area_id);

-- Специальный индекс для поиска резюме
CREATE INDEX resume_index on resumes(position);

-- Специальный индекс для следующего запроса
CREATE INDEX vacancy_search on vacancy(position_name, compensation_from, compensation_to, date);

SELECT position_name, compensation_from, compensation_to, date from vacancy
RIGHT JOIN area_name a on vacancy.area_id = a.area_id
WHERE a.title = 'Санкт-Петербург'
ORDER BY date DESC, compensation_to DESC;

--К сожалению мне не удалось заставить какие-либо запросы выполняться быстрее, можно считать этот таск провальным.