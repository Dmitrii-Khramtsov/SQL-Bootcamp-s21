-- Фактически, мы создали структуру для хранения наших скидок и готовы пойти дальше 
-- и заполнить нашу таблицу `person_discounts` новыми записями.
-- 
-- Итак, есть таблица `person_order`, в которой хранится история заказов человека. 
-- Напишите DML-оператор (`INSERT INTO ... SELECT ...`), 
-- который делает вставку новых записей в таблицу `person_discounts` на основе следующих правил.
-- - берем агрегированное состояние по столбцам person_id и pizzeria_id 
-- - вычисляем значение персональной скидки с помощью следующего псевдокода:
-- 
--     `if “amount of orders” = 1 then
--         “discount” = 10.5 
--     else if “amount of orders” = 2 then 
--         “discount” = 22
--     else 
--         “discount” = 30`
-- 
-- - чтобы создать первичный ключ для таблицы person_discounts, 
-- используйте SQL-конструкцию ниже (эта конструкция находится в области WINDOW FUNCTION SQL).
-- 
--     `... ROW_NUMBER( ) OVER ( ) AS id ...`
-- 
INSERT INTO
  person_discounts (id, person_id, pizzeria_id, discount)
SELECT
  ROW_NUMBER() OVER () AS id,
  person_id,
  pizzeria_id,
  CASE
    WHEN COUNT(person_id) = 1 THEN 10.5
    WHEN COUNT(person_id) = 2 THEN 22
    ELSE 30
  END AS discount
FROM
  person_order po
  JOIN menu m ON po.menu_id = m.id
  JOIN pizzeria pz ON m.pizzeria_id = pz.id
GROUP BY
  person_id,
  pizzeria_id