-- Создайте материализованное представление mv_dmitriy_visits_and_eats 
-- (с включенными данными) на основе SQL-запроса, который находит название пиццерии, 
-- где Dmitriy побывал 8 января 2022 года и смог съесть пиццу менее чем за 800 рублей 
-- (этот SQL можно найти в упражнении Day #02 Exercise #07).
-- Чтобы проверить себя, вы можете написать SQL 
-- в материализованном представлении mv_dmitriy_visits_and_eats 
-- и сравнить результаты с предыдущим запросом.

CREATE MATERIALIZED VIEW mv_dmitriy_visits_and_eats AS
SELECT
  pz.name AS pizzeria_name
FROM
  person_visits pv
  JOIN pizzeria pz ON pz.id = pv.pizzeria_id
  JOIN person p ON p.id = pv.person_id
  JOIN menu m ON m.pizzeria_id = pv.pizzeria_id
WHERE
  p.name = 'Dmitriy'
  AND pv.visit_date = '2022-01-08'
  AND m.price < 800;

-- Chek
SELECT
  *
FROM
  mv_dmitriy_visits_and_eats;

DROP MATERIALIZED VIEW mv_dmitriy_visits_and_eats;
