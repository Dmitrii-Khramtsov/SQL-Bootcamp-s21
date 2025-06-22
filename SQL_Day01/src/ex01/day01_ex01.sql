-- Пожалуйста, измените инструкцию SQL из “упражнения 00”, 
-- удалив столбец object_id. 
-- Затем измените порядок по object_name для части данных из таблицы `person", 
-- а затем из таблицы `menu" (как показано в примере ниже). 
-- Пожалуйста, сохраните дубликаты!

SELECT
  object_name
FROM
  (
    SELECT
      pizza_name AS object_name
    FROM
      menu
    UNION ALL
    SELECT
      name AS object_name
    FROM
      person
  )
ORDER BY
  object_name;
  