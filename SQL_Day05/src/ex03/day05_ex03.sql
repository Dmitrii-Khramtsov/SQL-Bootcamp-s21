-- Пожалуйста, создайте лучший многоколоночный индекс 
-- B-Tree с именем `idx_person_order_multi` для приведенного ниже SQL-оператора.
--
-- SELECT
--   person_id,
--   menu_id,
--   order_date
-- FROM
--   person_order
-- WHERE
--   person_id = 8
--   AND menu_id = 19;
--
-- Команда `EXPLAIN ANALYZE` должна вернуть следующий шаблон. Пожалуйста, 
-- будьте внимательны при сканировании "Index Only Scan"!
--
--     ...
--     -> Index Only Scan using idx_person_order_multi on person_order (...)
--     ...
--
-- Пожалуйста, предоставьте любой SQL с доказательством (`EXPLAIN ANALYZE`) того, 
-- что индекс `idx_person_order_multi` работает.

CREATE INDEX idx_person_order_multi ON person_order (person_id, menu_id);

BEGIN;

SET
  LOCAL enable_seqscan = OFF;

EXPLAIN ANALYZE
SELECT
  person_id,
  menu_id,
  order_date
FROM
  person_order
WHERE
  person_id = 8
  AND menu_id = 19;

COMMIT;

-- update statistics
ANALYZE person_order;
