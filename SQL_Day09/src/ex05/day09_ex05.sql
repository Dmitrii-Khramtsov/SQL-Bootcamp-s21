-- Упражнение 05 - Параметризованная функция базы данных
-- 
-- Похоже, что 2 функции из упражнения 04 нуждаются в более общем подходе. 
-- Пожалуйста, перед нашими дальнейшими шагами удалите эти функции из базы данных. 
-- Напишите обычную SQL-функцию (пожалуйста, имейте в виду, не pl / pgsql-функцию)
-- с именем fnc_persons. У этой функции должен быть параметр IN pgender 
-- со значением по умолчанию = ‘female’.
-- 
-- Чтобы проверить себя и вызвать функцию, вы можете сделать следующее утверждение 
-- (вау! вы можете работать с функцией, как с виртуальной таблицей, 
-- но с большей гибкостью!).
-- select * from fnc_persons(pgender := 'male');
-- select * from fnc_persons();
-- 
-- удаление функций если они существуют
DROP FUNCTION IF EXISTS fnc_persons_female, fnc_persons_male;

--------------------------------- FUNCTION ----------------------------
CREATE OR REPLACE FUNCTION fnc_persons(pgender varchar default 'female')
RETURNS SETOF person AS $$
SELECT
  *
FROM
  person
WHERE
  gender = pgender;

$$ LANGUAGE SQL;

---------------------------------- CHECK -------------------------------
SELECT
  *
FROM
  fnc_persons(pgender := 'male');

SELECT
  *
FROM
  fnc_persons();
