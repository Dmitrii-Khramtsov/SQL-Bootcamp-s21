-- Напишите SQL-запрос, который возвращает список названий пицц, цен на них,
-- названий пиццерий и дат посещения для Kate и для цен от 800 до 1000 рублей.
-- Отсортируйте список по пицце, цене и названию пиццерии. Пример данных приведен ниже.

SELECT
  menu.pizza_name,
  menu.price,
  pizzeria.name AS pizzeria_name,
  person_visits.visit_date
FROM
  menu
  JOIN pizzeria ON menu.pizzeria_id = pizzeria.id
  JOIN person_visits ON pizzeria.id = person_visits.pizzeria_id
  JOIN person ON person_visits.person_id = person.id
  AND person.name = 'Kate'
  AND menu.price BETWEEN 800 AND 1000
ORDER BY
  1,
  2,
  3;
  