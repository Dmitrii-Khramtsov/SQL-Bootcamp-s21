-- Найдите полную информацию обо всех возможных названиях пиццерий 
-- и ценах на пиццу с грибами или пепперони. 
-- Затем отсортируйте результат по названию пиццы и названию пиццерии. 
-- Ниже показан результат для примера данных 
-- (пожалуйста, используйте те же имена столбцов в SQL-запросе).

SELECT
  menu.pizza_name,
  pizzeria.name AS pizzeria_name,
  menu.price AS Цена
FROM
  menu
  JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
WHERE
  pizza_name = 'pepperoni pizza'
  OR pizza_name = 'mushroom pizza'
ORDER BY
  pizza_name,
  pizzeria_name;
