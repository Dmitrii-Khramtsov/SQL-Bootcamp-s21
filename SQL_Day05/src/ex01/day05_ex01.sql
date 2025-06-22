-- Перед дальнейшими действиями напишите SQL-запрос, 
-- который возвращает названия пицц и соответствующих им пиццерий. 
-- Пожалуйста, посмотрите на примере результата ниже (сортировка не требуется).
--
-- | pizza_name | pizzeria_name | 
-- | ------ | ------ |
-- | cheese pizza | Pizza Hut |
-- | ... | ... |
--
-- Давайте приведем доказательства того, что ваши индексы работают для вашего SQL.
-- Образцом доказательства является вывод команды `EXPLAIN ANALYZE`. 
-- Пожалуйста, посмотрите на примере вывода команды.
--
--     ...
--     -> Index Scan using idx_menu_pizzeria_id on menu m (...)
--     ...
--
-- **Подсказка**: пожалуйста, подумайте, 
-- почему ваши индексы не работают прямым образом 
-- и что нужно сделать, чтобы включить их?

BEGIN;

SET
  LOCAL enable_seqscan = OFF;

EXPLAIN ANALYZE
SELECT
  m.pizza_name,
  pz.name AS pizzeria_name
FROM
  menu m
  JOIN pizzeria pz ON m.pizzeria_id = pz.id;

COMMIT;

-- update statistics
ANALYZE menu;

ANALYZE pizzeria;
