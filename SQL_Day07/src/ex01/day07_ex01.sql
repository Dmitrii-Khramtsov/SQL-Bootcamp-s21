-- Пожалуйста, измените SQL-оператор из упражнения 00 
-- и верните имя человека (не идентификатор). 
-- Дополнительное условие - нам нужно увидеть только топ-4 людей 
-- с максимальным количеством посещений в каждой пиццерии 
-- и отсортировать их по имени человека. Смотрите пример выходных данных ниже.

-- | name    | count_of_visits |
-- | ------- | --------------- |
-- | Dmitriy | 4               |
-- | Denis   | 3               |
-- | ...     | ...             |  
-- 
SELECT
  person.name,
  COUNT(*) AS count_of_visits
FROM
  person_visits
  JOIN person ON person_visits.person_id = person.id
GROUP BY
  person.name
ORDER BY
  count_of_visits DESC,
  person.name ASC
LIMIT 4;
