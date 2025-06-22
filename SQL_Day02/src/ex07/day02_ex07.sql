-- Пожалуйста, найдите название пиццерии, 
-- которую Дмитрий посетил 8 января 2022 года
-- и смог съесть пиццу менее чем за 800 рублей.

SELECT
  pizzeria.name
FROM
  pizzeria
  JOIN menu ON pizzeria.id = menu.pizzeria_id
  JOIN person_visits ON menu.pizzeria_id = person_visits.pizzeria_id
WHERE
  person_visits.visit_date = '2022-01-08'
  AND menu.price < 800;
