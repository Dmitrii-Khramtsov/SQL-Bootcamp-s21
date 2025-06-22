-- Пожалуйста, создайте функциональный индекс B-Tree с именем `idx_person_name` 
-- для столбца name таблицы `person`. 
-- Индекс должен содержать имена людей в верхнем регистре.
-- Пожалуйста, напишите и предоставьте любой SQL с доказательством 
-- (`EXPLAIN ANALYZE`) того, что индекс idx_person_name работает.

CREATE INDEX idx_person_name ON person (UPPER(name));

BEGIN;

SET
  LOCAL enable_seqscan = OFF;

EXPLAIN ANALYZE
SELECT
  name
FROM
  person
WHERE
  UPPER(name) = 'KATE';

COMMIT;

-- update statistics
ANALYZE person;
