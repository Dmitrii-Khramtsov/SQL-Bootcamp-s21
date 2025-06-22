-- Напишите инструкцию SQL, которая возвращает дату заказа из person_order таблицы
-- и соответствующее имя человека
-- (имя и возраст отформатированы так, как в приведенном ниже примере данных),
-- который сделал заказ из person таблицы.
-- Добавьте сортировку по обоим столбцам в порядке возрастания.

SELECT
  order_date,
  CONCAT (name, ' (age:', age, ')') AS person_information
FROM
  person_order
  INNER JOIN person ON person.id = person_order.person_id
ORDER BY
  order_date,
  person_information;
  