-- Не использовать WHERE.
-- Напишите SQL-оператор, который возвращает имя человека 
-- и соответствующее количество посещений любых пиццерий, 
-- если человек посетил их более 3 раз (> 3). 
-- Пожалуйста, посмотрите на пример данных ниже.
-- | name    | count_of_visits |
-- | ------- | --------------- |
-- | Dmitriy | 4               |
-- 
SELECT
  person.name,
  COUNT(person_id) AS count_of_visits
FROM
  person_visits
  JOIN person ON person.id = person_visits.person_id
GROUP BY
  person.name
HAVING
  COUNT(person_id) > 3;
