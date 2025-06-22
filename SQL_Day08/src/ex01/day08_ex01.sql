-- Упражнение 01 - Аномалия потерянного обновления.
-- 
-- Проверьте рейтинг «Pizza Hut» в режиме транзакции для обеих сессий, 
-- затем выполните UPDATE рейтинга до значения 4 в сессии #1 
-- и UPDATE рейтинга до значения 3.6 в сессии #2 (в том же порядке, что и на рисунке).
-- 
-- Session #1
SHOW TRANSACTION ISOLATION LEVEL;

BEGIN;

-- Session #2
SHOW TRANSACTION ISOLATION LEVEL;

BEGIN;

-- Session #1
SELECT
  *
FROM
  pizzeria
WHERE
  name = 'Pizza Hut';

-- Session #2
SELECT
  *
FROM
  pizzeria
WHERE
  name = 'Pizza Hut';

-- Session #1
UPDATE pizzeria
SET
  rating = 4
WHERE
  name = 'Pizza Hut';

-- Session #2
UPDATE pizzeria
SET
  rating = 3.6
WHERE
  name = 'Pizza Hut';

-- Session #1
COMMIT;

-- Session #2
COMMIT;

-- Session #1
SELECT
  *
FROM
  pizzeria
WHERE
  name = 'Pizza Hut';

-- Session #2
SELECT
  *
FROM
  pizzeria
WHERE
  name = 'Pizza Hut';
