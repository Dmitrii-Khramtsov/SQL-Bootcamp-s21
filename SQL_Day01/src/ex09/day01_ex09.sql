-- Напишите 2 оператора SQL, 
-- которые возвращают список пиццерий, 
-- которые не посещали люди, 
-- использующие IN, для первого и EXISTS для второго.

SELECT
  name
FROM
  pizzeria
WHERE
  name NOT IN (
    SELECT
      name
    FROM
      person_visits
    WHERE
      person_visits.pizzeria_id = pizzeria.id
  );

SELECT
  name
FROM
  pizzeria
WHERE
  NOT EXISTS (
    SELECT
      name
    FROM
      person_visits
    WHERE
      person_visits.pizzeria_id = pizzeria.id
  );
  