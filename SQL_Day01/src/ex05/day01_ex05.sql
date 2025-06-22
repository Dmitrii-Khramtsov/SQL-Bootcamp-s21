-- Пожалуйста, напишите инструкцию SQL, 
-- которая возвращает все возможные комбинации между таблицами `person` и `pizzeria`, 
-- и, пожалуйста, установите порядок по идентификатору человека, 
-- а затем по столбцам идентификатора пиццерии. 
-- Пожалуйста, взгляните на приведенный ниже пример результата. 
-- Пожалуйста, имейте в виду, что названия столбцов могут отличаться для вас.

SELECT
  person.id AS "person.id",
  person.name AS "person.name",
  person.age,
  person.gender,
  person.address,
  pizzeria.id AS "pizzeria.id",
  pizzeria.name AS "pizzeria.name",
  pizzeria.rating
FROM
  person
  CROSS JOIN pizzeria
ORDER BY
  person.id,
  pizzeria.id;
  