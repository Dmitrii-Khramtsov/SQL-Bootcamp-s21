SELECT
  (
    SELECT
      name
    FROM
      person
    WHERE
      id = person_order.person_id
  ) AS NAME,
  (
    SELECT
      CASE
        WHEN id = person_order.person_id
        AND person.name = 'Denis' THEN 'True'
        ELSE 'False'
      END
    FROM
      person
    WHERE
      id = person_order.person_id
  ) AS check_name
FROM
  person_order
WHERE
  (
    menu_id = 13
    OR menu_id = 14
    OR menu_id = 18
  )
  AND order_date = '2022-01-07';