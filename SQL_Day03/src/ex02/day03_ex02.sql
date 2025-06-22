-- Используйте оператор SQL из упражнения #01 
-- и выведите названия пицц из пиццерии, которые никто не заказывал, 
-- включая соответствующие цены. 
-- Результат должен быть отсортирован по названию и цене пиццы. 
-- Пример выходных данных показан ниже.

SELECT
  menu.pizza_name,
  menu.price,
  pizzeria.name AS pizzeria_name
FROM
  menu
JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
LEFT JOIN person_order ON menu.id = person_order.menu_id
WHERE person_order.id IS NULL
ORDER BY
  1,
  2;
