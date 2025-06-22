-- Напишите, пожалуйста, SQL-запрос, который возвращает заказы с фактической ценой 
-- и ценой с примененной скидкой для каждого человека 
-- в соответствующем ресторане-пиццерии и сортирует их по имени человека и названию пиццы. 
-- Пожалуйста, посмотрите на пример данных ниже.
-- 
-- | name | pizza_name | price | discount_price | pizzeria_name | 
-- | ------ | ------ | ------ | ------ | ------ |
-- | Andrey | cheese pizza | 800 | 624 | Dominos |
-- | Andrey | mushroom pizza | 1100 | 858 | Dominos |
-- | ... | ... | ... | ... | ... |
-- 
SELECT
  p.name,
  m.pizza_name,
  m.price,
  ROUND(m.price - (m.price * pd.discount / 100), 0) AS discount_price,
  pz.name AS pizzeria_name
FROM
  person_order po
  JOIN person p ON po.person_id = p.id
  JOIN menu m ON po.menu_id = m.id
  JOIN person_discounts pd ON pd.person_id = p.id
  AND pd.pizzeria_id = m.pizzeria_id
  JOIN pizzeria pz ON pd.pizzeria_id = pz.id
ORDER BY
  p.name,
  m.pizza_name;
