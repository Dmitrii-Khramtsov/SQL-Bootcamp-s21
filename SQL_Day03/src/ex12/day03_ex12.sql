-- Не используйте прямые числа для идентификаторов первичного ключа и меню.
-- Не используйте оконные функции типа ROW_NUMBER( ).
-- Не используйте атомарные операторы INSERT |.
-- Пожалуйста, зарегистрируйте новые заказы всех лиц на "greek pizza" на 25 февраля 2022 года.
-- Внимание: Это упражнение может привести к тому, что вы измените данные неправильным образом.
-- На самом деле вы можете восстановить исходную модель базы данных 
-- с данными по ссылке в разделе "Правила дня" 
-- и повторить сценарий из упражнений 07, 08, 09, 10 и 11.

WITH
  person_ids AS (
    SELECT
      generate_series (
        1,
        (
          SELECT
            MAX(id)
          FROM
            person
        )
      ) AS person_id
  ),
  max_order_id AS (
    SELECT
      MAX(id) AS max_id
    FROM
      person_order
  )
INSERT INTO
  person_order (id, person_id, menu_id, order_date)
SELECT
  (person_ids.person_id + max_order_id.max_id),
  person_ids.person_id,
  (
    SELECT
      id
    FROM
      menu
    WHERE
      pizza_name = 'greek pizza'
  ),
  '2022-02-25'
FROM
  person_ids,
  max_order_id;

-- Chek
SELECT
  *
FROM
  person_order;
