-- Напишите SQL-запрос, чтобы увидеть, как рестораны группируются по посещениям 
-- и заказам и объединяются по названию ресторана.  
-- Вы можете использовать внутренний SQL из упражнения 02 
-- (Рестораны по посещениям и по заказам) без ограничений на количество строк.
-- Кроме того, добавьте следующие правила.
-- - Вычислите сумму заказов и посещений для соответствующей пиццерии 
-- (обратите внимание, что не все ключи пиццерий представлены в обеих таблицах).
-- - Отсортируйте результаты по столбцу `total_count` в порядке убывания 
-- и по столбцу `name` в порядке возрастания.
-- Посмотрите на пример данных ниже.
-- | name      | total_count |
-- | --------- | ----------- |
-- | Dominos   | 13          |
-- | DinoPizza | 9           |
-- | ...       | ...         | 
-- 
WITH
  all_count_pz_name AS (
    (
      SELECT
        pizzeria.name,
        COUNT(pizzeria_id) AS count
      FROM
        person_order
        JOIN menu ON menu.id = person_order.menu_id
        JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
      GROUP BY
        pizzeria.name
      ORDER BY
        count DESC,
        pizzeria.name
    )
    UNION ALL
    (
      SELECT
        pizzeria.name,
        COUNT(pizzeria_id) AS count
      FROM
        person_visits
        JOIN pizzeria ON pizzeria.id = person_visits.pizzeria_id
      GROUP BY
        pizzeria.name
      ORDER BY
        count DESC,
        pizzeria.name
    )
  )
SELECT
  name,
  SUM(count) AS total_count
FROM
  all_count_pz_name
GROUP BY
  name
ORDER BY
  total_count DESC,
  name;
