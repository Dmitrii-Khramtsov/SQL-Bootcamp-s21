-- Упражнение 06 - Фантомное считывание для повторного считывания
-- 
-- Давайте проверим один из известных шаблонов базы данных «Призрачное чтение», 
-- но на уровне изоляции REPEATABLE READ. 
-- Графическое представление этой аномалии вы можете увидеть на рисунке. 
-- Горизонтальная красная линия представляет собой итоговый результат после выполнения 
-- всех последовательных шагов для обеих сессий.
-- Просьба суммировать все рейтинги для всех пиццерий в одном режиме транзакции для сессии #1, 
-- а затем UPDATE рейтинг до значения 5 для ресторана «Pizza Hut» 
-- в сессии #2 (в том же порядке, что и на рисунке).
-- 
-- Session #1
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Session #2
BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Session #1
SELECT
  SUM(rating)
FROM
  pizzeria;

-- Session #2
UPDATE pizzeria
SET
  rating = 5
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
