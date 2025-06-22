-- Пожалуйста, посмотрите на SQL ниже с технической точки зрения 
-- (не обращайте внимания на логический случай этого SQL-оператора).
--
-- SELECT
--   m.pizza_name AS pizza_name,
--   max(rating) OVER (
--     PARTITION BY
--       rating
--     ORDER BY
--       rating ROWS BETWEEN UNBOUNDED PRECEDING
--       AND UNBOUNDED FOLLOWING
--   ) AS k
-- FROM
--   menu m
--   INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
-- ORDER BY
--   1,
--   2;
--
-- Создайте новый индекс BTree с именем `idx_1`, 
-- который должен улучшить метрику "Время выполнения" этого SQL. 
-- Пожалуйста, предоставьте доказательство (`EXPLAIN ANALYZE`) того, 
-- что SQL был улучшен.
-- **Примечание**: это упражнение похоже на задачу "грубой силы" 
-- по поиску хорошего покрывающего индекса, 
-- поэтому перед новым тестом удалите индекс `idx_1`.
-- Пример моего улучшения:
--
-- **Before**:
--     Sort  (cost=26.08..26.13 rows=19 width=53) (actual time=0.247..0.254 rows=19 loops=1)
--     "  Sort Key: m.pizza_name, (max(pz.rating) OVER (?))"
--     Sort Method: quicksort  Memory: 26kB
--     ->  WindowAgg  (cost=25.30..25.68 rows=19 width=53) (actual time=0.110..0.182 rows=19 loops=1)
--             ->  Sort  (cost=25.30..25.35 rows=19 width=21) (actual time=0.088..0.096 rows=19 loops=1)
--                 Sort Key: pz.rating
--                 Sort Method: quicksort  Memory: 26kB
--                 ->  Merge Join  (cost=0.27..24.90 rows=19 width=21) (actual time=0.026..0.060 rows=19 loops=1)
--                         Merge Cond: (m.pizzeria_id = pz.id)
--                         ->  Index Only Scan using idx_menu_unique on menu m  (cost=0.14..12.42 rows=19 width=22) (actual time=0.013..0.029 rows=19 loops=1)
--                             Heap Fetches: 19
--                         ->  Index Scan using pizzeria_pkey on pizzeria pz  (cost=0.13..12.22 rows=6 width=15) (actual time=0.005..0.008 rows=6 loops=1)
--     Planning Time: 0.711 ms
--     Execution Time: 0.338 ms
-- **After**:
--     Sort  (cost=26.28..26.33 rows=19 width=53) (actual time=0.144..0.148 rows=19 loops=1)
--     "  Sort Key: m.pizza_name, (max(pz.rating) OVER (?))"
--     Sort Method: quicksort  Memory: 26kB
--     ->  WindowAgg  (cost=0.27..25.88 rows=19 width=53) (actual time=0.049..0.107 rows=19 loops=1)
--             ->  Nested Loop  (cost=0.27..25.54 rows=19 width=21) (actual time=0.022..0.058 rows=19 loops=1)
--                 ->  Index Scan using idx_1 on …
--                 ->  Index Only Scan using idx_menu_unique on menu m  (cost=0.14..2.19 rows=3 width=22) (actual time=0.004..0.005 rows=3 loops=6)
--     …
--     Planning Time: 0.338 ms
--     Execution Time: 0.203 ms
--

DROP INDEX idx_1;

CREATE INDEX idx_1 ON menu (pizzeria_id);

CREATE INDEX idx_1 ON pizzeria (rating);

BEGIN;

SET
  LOCAL enable_seqscan = OFF;

EXPLAIN ANALYZE
SELECT
  m.pizza_name AS pizza_name,
  max(rating) OVER (
    PARTITION BY
      rating
    ORDER BY
      rating ROWS BETWEEN UNBOUNDED PRECEDING
      AND UNBOUNDED FOLLOWING
  ) AS k
FROM
  menu m
  INNER JOIN pizzeria pz ON m.pizzeria_id = pz.id
ORDER BY
  1,
  2;

COMMIT;

-- update statistics
ANALYZE menu;

ANALYZE pizzeria;
-- 
-- Sort  (cost=18.83..18.88 rows=19 width=53) (actual time=0.101..0.102 rows=19 loops=1)
--   Sort Key: m.pizza_name, (max(pz.rating) OVER (?))
--   Sort Method: quicksort  Memory: 26kB
--   ->  WindowAgg  (cost=18.05..18.43 rows=19 width=53) (actual time=0.046..0.054 rows=19 loops=1)
--         ->  Sort  (cost=18.05..18.10 rows=19 width=21) (actual time=0.038..0.039 rows=19 loops=1)
--               Sort Key: pz.rating
--               Sort Method: quicksort  Memory: 25kB
--               ->  Nested Loop  (cost=0.28..17.65 rows=19 width=21) (actual time=0.012..0.024 rows=19 loops=1)
--                     ->  Index Scan using idx_1 on menu m  (cost=0.14..12.42 rows=19 width=22) (actual time=0.004..0.006 rows=19 loops=1)
--                     ->  Memoize  (cost=0.14..0.79 rows=1 width=15) (actual time=0.001..0.001 rows=1 loops=19)
--                           Cache Key: m.pizzeria_id
--                           Cache Mode: logical
--                           Hits: 13  Misses: 6  Evictions: 0  Overflows: 0  Memory Usage: 1kB
--                           ->  Index Scan using pizzeria_pkey on pizzeria pz  (cost=0.13..0.78 rows=1 width=15) (actual time=0.001..0.001 rows=1 loops=6)
--                                 Index Cond: (id = m.pizzeria_id)
-- Planning Time: 0.642 ms
-- Execution Time: 0.146 ms
-- 
-- 
-- Sort  (cost=18.83..18.88 rows=19 width=53) (actual time=0.123..0.124 rows=19 loops=1)
--   Sort Key: m.pizza_name, (max(pz.rating) OVER (?))
--   Sort Method: quicksort  Memory: 26kB
--   ->  WindowAgg  (cost=18.05..18.43 rows=19 width=53) (actual time=0.061..0.070 rows=19 loops=1)
--         ->  Sort  (cost=18.05..18.10 rows=19 width=21) (actual time=0.052..0.053 rows=19 loops=1)
--               Sort Key: pz.rating
--               Sort Method: quicksort  Memory: 25kB
--               ->  Nested Loop  (cost=0.28..17.65 rows=19 width=21) (actual time=0.020..0.034 rows=19 loops=1)
--                     ->  Index Only Scan using idx_menu_unique on menu m  (cost=0.14..12.42 rows=19 width=22) (actual time=0.010..0.014 rows=19 loops=1)
--                           Heap Fetches: 19
--                     ->  Memoize  (cost=0.14..0.79 rows=1 width=15) (actual time=0.001..0.001 rows=1 loops=19)
--                           Cache Key: m.pizzeria_id
--                           Cache Mode: logical
--                           Hits: 13  Misses: 6  Evictions: 0  Overflows: 0  Memory Usage: 1kB
--                           ->  Index Scan using pizzeria_pkey on pizzeria pz  (cost=0.13..0.78 rows=1 width=15) (actual time=0.001..0.001 rows=1 loops=6)
--                                 Index Cond: (id = m.pizzeria_id)
-- Planning Time: 0.726 ms
-- Execution Time: 0.170 ms
