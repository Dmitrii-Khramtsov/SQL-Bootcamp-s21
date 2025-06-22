-- Упражнение 07 - Тупик
-- 
-- Давайте воспроизведем ситуацию тупика в нашей базе данных. 
-- Графическое представление ситуации тупика можно увидеть на рисунке. 
-- Это выглядит как «Christ-lock» между параллельными сессиями.
-- Пожалуйста, напишите любой SQL-оператор с любым уровнем изоляции 
-- (можно использовать настройки по умолчанию) для таблицы `pizzeria`, 
-- чтобы воспроизвести эту ситуацию тупика.
-- 
-- Session #1
BEGIN;

-- Session #2
BEGIN;

-- Session #1
UPDATE pizzeria
SET
  rating = 1
WHERE
  id = 1;

-- Session #2
UPDATE pizzeria
SET
  rating = 2
WHERE
  id = 2;

-- Session #1
UPDATE pizzeria
SET
  rating = 1
WHERE
  id = 2;

-- Session #2
UPDATE pizzeria
SET
  rating = 2
WHERE
  id = 1;

-- Session #1
COMMIT;

-- Session #2
COMMIT;

-- Session #1
SELECT
  *
FROM
  pizzeria;
