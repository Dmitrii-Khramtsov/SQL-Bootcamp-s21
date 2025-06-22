-- Пожалуйста, напишите SQL-инструкцию, 
-- которая возвращает уникальные названия пиццы из таблицы "меню" 
-- и столбца Заказы по "pizza_name" в режиме убывания. 
-- Пожалуйста, обратите внимание, что вы
-- не должны использовать `DISTINCT`, `GROUP BY`, `HAVING`, любой тип `JOINs`

SELECT
  pizza_name
FROM
  (
    SELECT
      pizza_name
    FROM
      menu
    UNION
    SELECT
      pizza_name
    FROM
      menu
  )
ORDER BY
  pizza_name DESC;
  