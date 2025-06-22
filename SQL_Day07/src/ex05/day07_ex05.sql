-- Не использовать `GROUP BY`, любой тип (`UNION`,...), работу с множествами.

-- Напишите простой SQL-запрос, который возвращает список уникальных имен людей, 
-- сделавших заказ в любой пиццерии. 
-- Результат должен быть отсортирован по имени человека. 
-- Смотрите пример ниже.

-- | name   | 
-- | ------ |
-- | Andrey |
-- | Anna   | 
-- | ...    | 
-- 
SELECT DISTINCT
  person.name
FROM
  person_order
  JOIN person ON person.id = person_order.person_id
ORDER BY
  person.name;
