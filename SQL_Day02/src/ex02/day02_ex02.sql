-- Пожалуйста, напишите SQL-инструкцию, которая вернет весь список имен людей, 
-- которые посещали (или не посещали) пиццерии 
-- в период с 1 по 3 января 2022 года с одной стороны, 
-- и весь список названий пиццерий, которые посещали (или не посещали) с другой стороны. 
-- Образец данных с требуемыми именами столбцов показан ниже. 
-- Пожалуйста, обратите внимание на заменяющее значение '-' для NULL значений 
-- в столбцах person_name и pizzeria_name. 
-- Пожалуйста, также добавьте порядок для всех 3 столбцов.

SELECT DISTINCT
  CASE
    WHEN person.name IS NULL THEN '-'
    ELSE person.name
  END AS person_name,
  person_visits.visit_date,
  CASE
    WHEN pizzeria.name IS NULL THEN '-'
    ELSE pizzeria.name
  END AS pizzeria_name
FROM
  person
  FULL OUTER JOIN person_visits ON person.id = person_visits.person_id
  AND (
    visit_date = '2022-01-01'
    OR visit_date = '2022-01-02'
    OR visit_date = '2022-01-03'
  )
  FULL OUTER JOIN pizzeria ON person_visits.pizzeria_id = pizzeria.id
  AND (
    visit_date = '2022-01-01'
    OR visit_date = '2022-01-02'
    OR visit_date = '2022-01-03'
  )
WHERE
  (
    visit_date = '2022-01-01'
    OR visit_date = '2022-01-02'
    OR visit_date = '2022-01-03'
  )
  OR (
    visit_date IS NULL
    AND (
      pizzeria.name IS NOT NULL
      OR person.name IS NOT NULL
    )
  )
ORDER BY
  person_name,
  visit_date,
  pizzeria_name;
  