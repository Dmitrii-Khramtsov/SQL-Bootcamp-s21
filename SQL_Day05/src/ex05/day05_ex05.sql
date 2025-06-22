-- Пожалуйста, создайте частично уникальный индекс BTree с именем `idx_person_order_order_date` 
-- на таблице `person_order` для атрибутов `person_id` и `menu_id` 
-- с частичной уникальностью для столбца `order_date` для даты '2022-01-01'.
-- Команда `EXPLAIN ANALYZE` должна вернуть следующий шаблон
--
--     ...
--     -> Index Only Scan using idx_person_order_order_date on person_order (...)
--     ...
--

CREATE UNIQUE INDEX idx_person_order_order_date ON person_order (person_id, menu_id)
WHERE
  order_date = '2022-01-01';

BEGIN;

SET
  LOCAL enable_seqscan = OFF;

EXPLAIN ANALYZE
SELECT
  person_id
FROM
  person_order
WHERE
  person_id = 1
  AND order_date = '2022-01-01';

COMMIT;

-- update statistics
ANALYZE person_order;
