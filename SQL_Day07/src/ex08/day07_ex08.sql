-- Мы знаем персональные адреса из наших данных. 
-- Предположим, что этот человек посещает только пиццерии в своем городе. 
-- Напишите SQL-оператор, который возвращает адрес, 
-- название пиццерии и сумму заказов этого человека. 
-- Результат должен быть отсортирован по адресу, 
-- а затем по названию ресторана. 
-- Посмотрите на пример выходных данных ниже.
-- 
-- | address | name       |count_of_orders |
-- | ------- | ---------- |--------------- |
-- | Kazan   | Best Pizza |4               |
-- | Kazan   | DinoPizza  |4               |
-- | ...     | ...        | ...            | 
-- 
SELECT
  person.address,
  pizzeria.name,
  COUNT(person_order.person_id) AS count_of_orders
FROM
  person_order
  JOIN person ON person_order.person_id = person.id
  JOIN menu ON menu.id = person_order.menu_id
  JOIN pizzeria ON pizzeria.id = menu.pizzeria_id
GROUP BY
  person.address,
  pizzeria.name
ORDER BY
  person.address,
  pizzeria.name;
