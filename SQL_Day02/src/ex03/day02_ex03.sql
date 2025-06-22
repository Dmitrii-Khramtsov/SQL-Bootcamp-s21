-- Давайте вернемся к упражнению #01, перепишите ваш SQL, 
-- используя шаблон CTE (Common Table Expression). 
-- Пожалуйста, перейдите к части CTE вашего "генератора дней". 
-- Результат должен выглядеть так же, как в упражнении #01.

WITH holiday AS (
SELECT visit_date::date
 FROM generate_series('2022-01-01', '2022-01-10', interval '1 day') AS visit_date
)
SELECT DISTINCT
  holiday.visit_date AS missing_date
FROM
  holiday
  LEFT JOIN (
    SELECT
      visit_date
    FROM
      person_visits
    WHERE
      person_id = 1
      OR person_id = 2
  ) AS person_visits ON holiday.visit_date = person_visits.visit_date
WHERE
  person_visits.visit_date IS NULL
ORDER BY
  missing_date;
