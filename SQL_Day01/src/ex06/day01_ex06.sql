-- Давайте вернемся к упражнению № 03 и изменим наш оператор SQL, 
-- чтобы возвращать имена пользователей вместо идентификаторов пользователей, 
-- и изменим порядок по action_date в режиме возрастания, 
-- а затем по person_name в режиме убывания. 
-- Взгляните на приведенные ниже примеры данных.

SELECT
  action_date,
  name AS person_name
FROM
  (
    SELECT
      order_date AS action_date,
      person_id
    FROM
      person_order
    INTERSECT
    SELECT
      visit_date AS action_date,
      person_id
    FROM
      person_visits
  ) AS intersect_result
  INNER JOIN person ON intersect_result.person_id = person.id
ORDER BY
  action_date,
  person_name DESC;
  