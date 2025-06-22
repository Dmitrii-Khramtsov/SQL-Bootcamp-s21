-- Напишите, пожалуйста, SQL-запрос, чтобы увидеть 3 любимых ресторана по посещениям 
-- и заказам в списке (пожалуйста, добавьте столбец action_type со значениями 'order' или 'visit', 
-- это зависит от данных из соответствующей таблицы). 
-- Пожалуйста, посмотрите на пример данных ниже. 
-- Результат должен быть отсортирован в порядке возрастания по столбцу action_type 
-- и в порядке убывания по столбцу count.
-- 
-- | name    | count  | action_type |
-- | ------- | ------ | ----------- |
-- | Dominos | 6      | order       |
-- | ...     | ...    | ...         |
-- | Dominos | 7      | visit       |
-- | ...     | ...    | ...         |
--
(
  SELECT
    pizzeria.name,
    COUNT(pizzeria_id) AS count,
    'order' AS action_type
  FROM
    person_order
    JOIN menu ON menu.id = person_order.menu_id
    JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
  GROUP BY
    pizzeria.name
  ORDER BY
    count DESC,
    pizzeria.name
  LIMIT
    3
)
UNION ALL
(
  SELECT
    pizzeria.name,
    COUNT(pizzeria_id) AS count,
    'visit' AS action_type
  FROM
    person_visits
    JOIN pizzeria ON pizzeria.id = person_visits.pizzeria_id
  GROUP BY
    pizzeria.name
  ORDER BY
    count DESC,
    pizzeria.name
  LIMIT
    3
)
ORDER BY
  action_type;
