-- Не используйте прямые номера для идентификаторов основного ключа и пиццерии
-- Просим зарегистрировать новые заказы от Denis и Irina на 24 февраля 2022 года 
-- на новое меню с "Sicilian pizza".
-- Внимание: Это упражнение может привести к тому, 
-- что вы измените данные неправильным образом. 
-- На самом деле вы можете восстановить исходную модель базы данных 
-- с данными по ссылке в разделе "Правила дня" и повторить сценарий 
-- из упражнений 07, 08 и 09.

INSERT INTO
  person_order (id, person_id, menu_id, order_date)
VALUES
  (
    (
      SELECT
        MAX(id) + 1
      FROM
        person_order
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
        menu
      WHERE
        pizza_name = 'sicilian pizza'
    ),
    '2022-02-24'
  );

INSERT INTO
  person_order (id, person_id, menu_id, order_date)
VALUES
  (
    (
      SELECT
        MAX(id) + 1
      FROM
        person_order
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
        menu
      WHERE
        pizza_name = 'sicilian pizza'
    ),
    '2022-02-24'
  );

-- Chek
SELECT
  *
FROM
  person_order;
