-- Пожалуйста, найдите имена всех мужчин из Москвы или Самары,
-- которые заказывают пиццу с пепперони или грибами (или и то, и другое). 
-- Пожалуйста, отсортируйте результат по именам в порядке убывания. 
-- Пример вывода показан ниже.

SELECT
  person.name
FROM
  person
  JOIN person_order ON person.id = person_order.person_id
  JOIN menu ON person_order.menu_id = menu.id
WHERE
  person.address IN ('Moscow', 'Samara')
  AND menu.pizza_name IN ('pepperoni pizza', 'mushroom pizza')
  AND person.gender = 'male'
ORDER BY
  person.name DESC;
