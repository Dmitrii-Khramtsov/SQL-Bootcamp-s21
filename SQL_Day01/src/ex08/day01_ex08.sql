-- Пожалуйста, перепишите инструкцию SQL из упражнения № 07, 
-- используя конструкцию NATURAL JOIN. 
-- Результат должен быть таким же, как в упражнении № 07.

SELECT
  order_date,
  CONCAT (name, ' (age:', age, ')') AS person_information
FROM
  (
    SELECT
      order_date,
      person_id
    FROM
      person_order
  )
  NATURAL JOIN (
    SELECT
      name,
      age,
      id AS person_id
    FROM
      person
  )
ORDER BY
  order_date,
  person_information;
  