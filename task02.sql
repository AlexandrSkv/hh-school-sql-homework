INSERT INTO specialties(title) VALUES
    ('Аналитик'),
    ('Художник'),
    ('Директор'),
    ('Менеджер'),
    ('Программист'),
    ('Инженер'),
    ('Администратор'),
    ('Тестировщик'),
    ('Дизайнер'),
    ('Писатель');

INSERT INTO area_name(title) VALUES
    ('Москва'),
    ('Санкт-Петербург'),
    ('Петрозаводск'),
    ('Казань'),
    ('Новосибирск'),
    ('Волгоград'),
    ('Сочи'),
    ('Калининград'),
    ('Саратов'),
    ('Владивосток');

WITH test_data_e (name, area_id) AS (
    SELECT
           md5(random()::text) AS name,
           generate_series(1,100) AS area_id
)
INSERT INTO employer (employer_name, area_id)
SELECT name, area_id
FROM test_data_e;

WITH test_data_v (g, employer_id, area_id, position_name, salary, date) AS (
    SELECT
           generate_series(1,10000) AS g,
           (random()*99::int)+1 AS employer_id,
           round((random()*9::int)+1) AS area_id,
           md5(random()::text) AS position_name,
           round((random()*100000)::int, -3) AS salary,
           timestamp '2021-01-01 00:00:00' + random() * (timestamp '2022-01-01 00:00:00' - timestamp '2021-01-01 00:00:00'))
INSERT INTO vacancy (employer_id, area_id, position_name, compensation_from, compensation_to, date)
SELECT
       employer_id, area_id, position_name, salary + 10000, salary + 20000, date
FROM test_data_v;

WITH test_data_resume(g, first_name, last_name, contacts, position, salary) AS (
    SELECT generate_series(1,100000) AS g,
           md5(random()::text) AS first_name,
           md5(random()::text) AS last_name,
           md5(random()::text) AS contacts,
           md5(random()::text) AS position,
           round((random()*100000)::int, -3) AS salary)
INSERT INTO resumes(first_name, last_name, contact, position, salary)
SELECT first_name, last_name, contacts, position, salary + 5000
FROM test_data_resume;

-- Заполняя отклики случайной датой, хочеться, что бы date отклика не могла быть раньше date вакансии
-- С timestamp, наверное, не самая лучшая идея, но зато наглядно видно сколько дней, месяцев...

WITH test_data_response(g, vacancy_id, resume_id) AS (
    SELECT
           generate_series(1,10000) AS g,
           round((random()*9999::int)+1) AS vacancy_id,
           round((random()*99999::int)+1) AS resume_id)
INSERT INTO responses (vacancy_id, resume_id, date)
SELECT vacancy_id, resume_id, (SELECT date FROM vacancy WHERE vacancy_id = test_data_response.vacancy_id) +
    random() * (timestamp '2021-02-01 00:00:00' -
                timestamp '2021-01-01 00:00:00')
FROM test_data_response;

WITH test_data_s(g, resume_id, special_id) AS (
    SELECT
           generate_series(1, 100000) AS g,
           round((random()*99999::int)+1) AS resume_id,
           round((random()*9::int)+1) AS special_id
)
INSERT INTO resume_special(resume_id, special_id)
SELECT resume_id, special_id
FROM test_data_s;