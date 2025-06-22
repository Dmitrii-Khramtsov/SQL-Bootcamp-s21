-- Пожалуйста, создайте уникальный индекс BTree с именем `idx_menu_unique` 
-- в таблице `menu` для столбцов `pizzeria_id` и `pizza_name`. 
-- Пожалуйста, напишите и предоставьте любой SQL с доказательством (`EXPLAIN ANALYZE`) того, 
-- что индекс `idx_menu_unique` работает.

CREATE INDEX idx_menu_unique ON menu (pizzeria_id, pizza_name);

BEGIN;

SET
  LOCAL enable_seqscan = OFF;

EXPLAIN ANALYZE
SELECT
  pizzeria_id,
  pizza_name,
  price
FROM
  menu
WHERE
  pizzeria_id = 4 AND pizza_name = 'mushroom pizza';

COMMIT;

-- update statistics
ANALYZE menu;
