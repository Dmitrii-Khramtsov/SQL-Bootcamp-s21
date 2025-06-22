-- Напишите SQL-оператор, который возвращает список пиццерий,
-- которые посетил Андрей, но не сделал в них заказ. 
-- Заказывайте по названию пиццерии. Пример данных показан ниже.

WITH
  Andrey_pz_vis AS (
    SELECT
      pz.name AS pizzeria_name
    FROM
      person_visits pv
      JOIN person p ON pv.person_id = p.id
      JOIN pizzeria pz ON pv.pizzeria_id = pz.id
    WHERE
      p.name = 'Andrey'
  ),
  Andrey_pz_ord AS (
    SELECT
      pz.name AS pizzeria_name
    FROM
      person_order po
      JOIN menu m ON po.menu_id = m.id
      JOIN pizzeria pz ON pz.id = m.pizzeria_id
      JOIN person p ON po.person_id = p.id
    WHERE
      p.name = 'Andrey'
  )
SELECT
  pizzeria_name
FROM
  Andrey_pz_vis
EXCEPT
SELECT
  pizzeria_name
FROM
  Andrey_pz_ord;
