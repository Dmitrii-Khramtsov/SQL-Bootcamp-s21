-- Не используйте прямые числа для идентификаторов первичных ключей, персон и пиццерий.
-- Давайте обновим данные в нашем материализованном представлении mv_dmitriy_visits_and_eats 
-- из упражнения #06. Перед этим действием создайте еще один визит Дмитрия, 
-- удовлетворяющий SQL-запросу материализованного представления, за исключением пиццерии, 
-- что мы можем видеть в результате из упражнения №06.
-- После добавления нового визита обновите состояние данных для mv_dmitriy_visits_and_eats.

INSERT INTO
  person_visits (id, person_id, pizzeria_id, visit_date)
VALUES
  (
    (
      SELECT
        MAX(id) + 1
      FROM
        person_visits
    ),
    (
      SELECT
        id
      FROM
        person
      WHERE
        name = 'Dmitriy'
    ),
    (
      SELECT
        pz.id
      FROM
        pizzeria pz
        JOIN menu m ON m.pizzeria_id = pz.id
      WHERE
        m.price < 800
        AND pz.name <> 'Papa Johns'
      ORDER BY
        pz.id
      LIMIT
        1
    ),
    '2022-01-08'
  );

-- Chek
SELECT
  *
FROM
  person_visits;

REFRESH MATERIALIZED VIEW mv_dmitriy_visits_and_eats;

-- Chek
SELECT
  *
FROM
  mv_dmitriy_visits_and_eats;
