-- Упражнение 05 - Аномалия фантомных чтений
-- 
-- Давайте проверим один из известных паттернов базы данных «фантомные чтения», 
-- но на уровне изоляции READ COMMITTED. 
-- Графическое представление этой аномалии вы можете увидеть на рисунке. 
-- Горизонтальная красная линия представляет собой итоговый результат 
-- после выполнения всех последовательных шагов для обеих сессий.
-- Просьба суммировать все рейтинги для всех пиццерий 
-- в одном режиме транзакции для сессии #1, 
-- а затем UPDATE рейтинг до 1 значения для ресторана «Pizza Hut» в сессии #2 
-- (в том же порядке, что и на рисунке).
-- 
-- Session #1
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Session #2
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Session #1
SELECT
  SUM(rating)
FROM
  pizzeria;

-- Session #2
UPDATE pizzeria
SET
  rating = 1
WHERE
  name = 'Pizza Hut';

COMMIT;

-- Session #1
SELECT
  SUM(rating)
FROM
  pizzeria;

COMMIT;

-- Session #1
SELECT
  SUM(rating)
FROM
  pizzeria;

-- Session #2
SELECT
  SUM(rating)
FROM
  pizzeria;
