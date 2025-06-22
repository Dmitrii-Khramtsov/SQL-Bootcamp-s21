-- Упражнение 04 - Неповторяемые чтения для сериализации
-- 
-- Давайте проверим один из известных шаблонов базы данных «Неповторяющиеся чтения», 
-- но на уровне изоляции SERIALIZABLE. 
-- Вы можете увидеть графическое представление этой аномалии на рисунке. 
-- Горизонтальная красная линия представляет собой конечный результат 
-- после выполнения всех последовательных шагов для обеих сессий.
-- Проверьте рейтинг «Pizza Hut» в режиме транзакции для сессии #1, 
-- а затем выполните UPDATE рейтинга до значения 3.0 в сессии #2 
-- (в том же порядке, что и на рисунке).
-- 
-- Session #1
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Session #2
BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Session #1
SELECT
  *
FROM
  pizzeria
WHERE
  name = 'Pizza Hut';

-- Session #2
UPDATE pizzeria
SET
  rating = 3
WHERE
  name = 'Pizza Hut';

COMMIT;

-- Session #1
SELECT
  *
FROM
  pizzeria
WHERE
  name = 'Pizza Hut';

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
