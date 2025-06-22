-- Не используйте прямые номера для идентификаторов основного ключа и пиццерии.
-- Пожалуйста, запишите новые посещения ресторана Dominos
-- Denis и Irina 24 февраля 2022 года.
-- Внимание: Это упражнение может привести к модификации данных неправильным образом. 
-- На самом деле вы можете восстановить исходную модель базы данных 
-- с данными по ссылке в разделе "Правила дня" 
-- и воспроизвести сценарий из упражнения 07.

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
        name = 'Denis'
    ),
    (
      SELECT
        id
      FROM
        pizzeria
      WHERE
        pizzeria.name = 'Dominos'
    ),
    '2022-02-24'
  );

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
        name = 'Irina'
    ),
    (
      SELECT
        id
      FROM
        pizzeria
      WHERE
        pizzeria.name = 'Dominos'
    ),
    '2022-02-24'
  );

-- Chek
SELECT
  *
FROM
  person_visits;
