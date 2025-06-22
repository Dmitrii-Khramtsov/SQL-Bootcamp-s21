-- На самом деле, мы должны улучшить согласованность данных с одной стороны 
-- и настроить производительность с другой. 
-- Пожалуйста, создайте многоколоночный уникальный индекс (с именем `idx_person_discounts_unique`), 
-- который предотвращает дублирование пары значений идентификаторов person и pizzeria.
-- После создания нового индекса, пожалуйста, предоставьте любую простую инструкцию SQL, 
-- которая показывает доказательство использования индекса (используя `EXPLAIN ANALYZE`).
-- Пример "доказательства” приведен ниже
--  ...
--  Сканирование индекса с использованием idx_person_discounts_unique в person_discounts
--  ...

CREATE UNIQUE INDEX idx_person_discounts_unique ON person_discounts (person_id, pizzeria_id);

BEGIN;

SET
  LOCAL enable_seqscan = OFF;

EXPLAIN ANALYZE
SELECT
  *
FROM
  person_discounts
ORDER BY
  pizzeria_id;

SET
  LOCAL enable_seqscan = ON;

EXPLAIN ANALYZE
SELECT
  *
FROM
  person_discounts
ORDER BY
  pizzeria_id;

COMMIT;

-- update statistics
ANALYZE person_order;
