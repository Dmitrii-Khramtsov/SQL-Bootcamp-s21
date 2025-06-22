-- Найдите имена всех женщин, которые заказывали пиццу с пепперони и сыром 
-- (в любое время и в любых пиццериях). 
-- Убедитесь, что результат упорядочен по имени человека. 
-- Пример данных показан ниже.

SELECT
  p.name
FROM
  person_order po
  JOIN menu m ON po.menu_id = m.id
  AND m.pizza_name = 'pepperoni pizza'
  JOIN person p ON po.person_id = p.id
  AND p.gender = 'female'
INTERSECT
SELECT
  p.name
FROM
  person_order po
  JOIN menu m ON po.menu_id = m.id
  AND m.pizza_name = 'cheese pizza'
  JOIN person p ON po.person_id = p.id
  AND p.gender = 'female'
ORDER BY
  1;

SELECT
  p1.name
FROM
  person_order po1
  JOIN menu m1 ON po1.menu_id = m1.id
  JOIN person p1 ON po1.person_id = p1.id
  JOIN person_order po2 ON po1.person_id = po2.person_id
  JOIN menu m2 ON po2.menu_id = m2.id
WHERE
  p1.gender = 'female'
  AND m1.pizza_name = 'pepperoni pizza'
  AND m2.pizza_name = 'cheese pizza';
  