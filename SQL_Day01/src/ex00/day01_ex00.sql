-- Пожалуйста, напишите SQL-инструкцию, 
-- которая возвращает идентификатор меню и названия пицц из таблицы `menu" 
-- и идентификатор пользователя и имя пользователя из таблицы `person` 
-- в одном глобальном списке 
-- (с именами столбцов, как представлено в примере ниже), 
-- упорядоченном по столбцам object_id, а затем по столбцам object_name.

SELECT
  object_id,
  object_name
FROM
  (
    SELECT
      id AS object_id,
      pizza_name AS object_name
    FROM
      menu
    UNION ALL
    SELECT
      id AS object_id,
      name AS object_name
    FROM
      person
  )
ORDER BY
  object_id,
  LOWER(object_name);
  