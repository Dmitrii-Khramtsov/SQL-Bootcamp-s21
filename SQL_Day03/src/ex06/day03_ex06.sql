-- Найдите одинаковые названия пиццы с одинаковой ценой, 
-- но из разных пиццерий. 
-- Убедитесь, что результат упорядочен по названию пиццы. 
-- Образец данных показан ниже. 
-- Убедитесь, что названия ваших столбцов совпадают 
-- с названиями столбцов ниже.

SELECT
  m1.pizza_name,
  pz1.name AS pizzeria1_name,
  pz2.name AS pizzeria2_name,
  m1.price
FROM
  menu m1
  JOIN pizzeria pz1 ON pz1.id = m1.pizzeria_id
  JOIN menu m2 ON m1.pizza_name = m2.pizza_name
  AND m1.price = m2.price
  AND m1.pizzeria_id > m2.pizzeria_id
  JOIN pizzeria pz2 ON pz2.id = m2.pizzeria_id
WHERE
  pz1.name <> pz2.name
ORDER BY
  pizza_name;
