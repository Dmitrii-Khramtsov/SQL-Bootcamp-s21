-- Найдите объединение пиццерий, 
-- в которых принимают заказы как женщины, так и мужчины. 
-- Другими словами, вы должны найти набор названий пиццерий, 
-- которые были заказаны только женщинами, и произвести операцию 
-- "ОБЪЕДИНЕНИЕ" с набором названий пиццерий, 
-- которые были заказаны только мужчинами. Пожалуйста, 
-- будьте осторожны со словом "только" для обоих полов. 
-- Для всех операторов SQL с наборами не храните дубликаты 
-- (UNION, EXCEPT, INTERSECT). 
-- Пожалуйста, отсортируйте результат по названию пиццерии. 
-- Примерные данные приведены ниже.

SELECT DISTINCT
  pz.name AS pizzeria_name
FROM
  pizzeria pz
  JOIN menu m ON m.pizzeria_id = pz.id
  JOIN person_order po ON m.id = po.menu_id
  JOIN person p ON p.id = po.person_id
WHERE
  p.gender = 'female'
GROUP BY
  pz.name
EXCEPT
SELECT DISTINCT
  pz.name AS pizzeria_name
FROM
  pizzeria pz
  JOIN menu m ON m.pizzeria_id = pz.id
  JOIN person_order po ON m.id = po.menu_id
  JOIN person p ON p.id = po.person_id
WHERE
  p.gender = 'male'
GROUP BY
  pz.name
ORDER BY
  pizzeria_name;
