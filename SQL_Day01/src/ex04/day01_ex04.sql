-- Пожалуйста, напишите SQL-инструкцию, 
-- которая возвращает разницу (минус) значений столбца person_id 
-- с сохранением дубликатов между таблицами `person_order` и `person_visits` 
-- для order_date и visit_date на 7 января 2022 года

SELECT
  person_id
FROM
  person_order
WHERE
  order_date = '2022-01-07'
EXCEPT ALL
SELECT
  person_id
FROM
  person_visits
WHERE
  visit_date = '2022-01-07';
  