-- Напишите SQL-запрос, который возвращает количество заказов, 
-- среднюю цену, максимальную цену и минимальную цену на пиццу, 
-- проданную в каждом ресторане-пиццерии. 
-- Результат должен быть отсортирован по названию пиццерии. 
-- Смотрите пример данных ниже. 
-- Округлите среднюю цену до 2 плавающих чисел.
-- 
-- | name       | count_of_orders | average_price | max_price | min_price |
-- | ---------- | --------------- | ------------- | --------- | --------- |
-- | Best Pizza | 5               | 780           | 850       | 700       |
-- | DinoPizza  | 5               | 880           | 1000      | 800       |
-- | ...        | ...             | ...           | ...       | ...       |
-- 
SELECT
  pizzeria.name,
  COUNT(pizzeria_id) AS count_of_orders,
  ROUND(AVG(menu.price), 2) AS average_price,
  MAX(menu.price) AS man_price,
  MIN(menu.price) AS min_price
FROM
  person_order
  JOIN menu ON person_order.menu_id = menu.id
  JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
GROUP BY
  pizzeria.name
ORDER BY
  pizzeria.name;
