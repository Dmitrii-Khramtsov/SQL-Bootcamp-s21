-- Пожалуйста, напишите SQL-инструкцию, 
-- которая возвращает пропущенные дни с 1 по 10 января 2022 года (включая все дни) 
-- для посещений людей с идентификаторами 1 или 2 (т. е. Дни, пропущенные обоими). 
-- Пожалуйста, упорядочьте количество посещений по дням в порядке возрастания. 
-- Ниже приведены примеры данных с названиями столбцов.

SELECT DISTINCT
   v_date::date AS missing_date
FROM
   generate_series('2022-01-01', '2022-01-10', interval '1 day') AS v_date
  LEFT JOIN (
    SELECT
      visit_date
    FROM
      person_visits
    WHERE
      person_id = 1
      OR person_id = 2
  ) AS person_visits ON v_date::date = person_visits.visit_date
WHERE
  person_visits.visit_date IS NULL
ORDER BY
  missing_date;
