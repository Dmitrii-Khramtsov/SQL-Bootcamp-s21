-- Найдите все названия пиццы 
-- (и соответствующие названия пиццерий, используя таблицу меню), 
-- заказанные Денисом или Анной. 
-- Отсортируйте результат по обоим столбцам. 
-- Пример вывода показан ниже.

SELECT
  menu.pizza_name,
  pizzeria.name
FROM
  menu
  JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
  JOIN person_order ON menu.id = person_order.menu_id
  JOIN person ON person_order.person_id = person.id
WHERE
  person.name IN ('Denis', 'Anna')
ORDER BY
  menu.pizza_name,
  pizzeria.name;
