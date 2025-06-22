-- Упражнение 08 - Алгоритм Фибоначчи в функции
-- 
-- Пожалуйста, напишите функцию SQL или pl / pgsql fnc_fibonacci (решать вам),
-- которая имеет входной параметр pstop с типом integer (по умолчанию равно 10),
-- а на выходе функции будет таблица со всеми числами Фибоначчи меньше pstop.
-- 
-- Чтобы проверить себя и вызвать функцию, вы можете выполнить инструкции,
-- подобные приведенным ниже.
-- select * from fnc_fibonacci(100);
-- select * from fnc_fibonacci();

DROP FUNCTION IF EXISTS fnc_fibonacci(INT), fnc_fibonacci(BIGINT), fnc_fibonacci(NUMERIC);

--------------------------------- FUNCTION ----------------------------
CREATE OR REPLACE FUNCTION fnc_fibonacci(n INT DEFAULT 10, OUT fibonacci INT) 
RETURNS SETOF INT AS $$
DECLARE
  first INT := 0; -- Предыдущее число в последовательности
  second INT := 1; -- Текущее число в последовательности
  nextFirst INT := 0; -- Переменная для временного хранения предыдущего числа
BEGIN
  DROP TABLE IF EXISTS fib;
  CREATE TEMP TABLE fib(num INT);

  INSERT INTO fib VALUES (first), (second);

  IF n = 0 THEN
    -- Удаляем последнее число из последовательности, если n = 0
    DELETE FROM fib WHERE num = second;
  ELSIF n > 0 THEN
    -- Добавляем новые числа в последовательность до n
    WHILE second <= n AND first + second <= n LOOP
      nextFirst := first;
      first := second;
      second := nextFirst + second;
      INSERT INTO fib VALUES (second);
    END LOOP;
  END IF;

  RETURN QUERY SELECT * FROM fib;

END;

$$ LANGUAGE plpgsql;

---------------------------------- CHECK -------------------------------
SELECT
  *
FROM
  fnc_fibonacci(100);

SELECT
  *
FROM
  fnc_fibonacci();
