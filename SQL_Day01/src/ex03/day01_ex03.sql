-- Пожалуйста, напишите SQL-инструкцию,
-- которая возвращает общие строки для атрибутов order_date, person_id 
-- из таблицы `person_order` с одной стороны 
-- и visit_date, person_id
-- из таблицы `person_visits` с другой стороны (пожалуйста, смотрите Пример ниже). 
-- Другими словами, давайте найдем идентификаторы людей, которые посетили пиццу 
-- и заказали ее в тот же день. На самом деле, пожалуйста, 
-- добавьте заказ по action_date в режиме возрастания, 
-- а затем по person_id в режиме убывания.

SELECT
  action_date,
  person_id
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
  )
ORDER BY
  action_date,
  person_id DESC;
  