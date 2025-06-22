-- Упражнение 04 - Представление базы данных против функции базы данных
-- 
-- Как вы помните, мы создали 2 представления базы данных 
-- для разделения данных из таблиц person по признаку пола. 
-- \Пожалуйста, определите 2 SQL-функции 
-- (обратите внимание, не pl / pgsql-функции) с именами
-- 
-- fnc_persons_female (должны возвращать лиц женского пола)
-- fnc_persons_male (должен возвращать лиц мужского пола)
-- Чтобы проверить себя и вызвать функцию, 
-- вы можете сделать заявление, подобное приведенному ниже 
-- (потрясающе! вы можете работать с функцией, как с виртуальной таблицей!).
-- 
-- SELECT * FROM fnc_persons_female();
-- SELECT * FROM fnc_persons_male();
--
-- удаление функций если они существуют
DROP FUNCTION IF EXISTS fnc_persons_female, fnc_persons_male;

--------------------------------- FUNCTION ----------------------------
CREATE OR REPLACE FUNCTION fnc_persons_female() RETURNS SETOF person AS $$
SELECT
  *
FROM
  person
WHERE
  gender = 'female';

$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION fnc_persons_male() RETURNS SETOF person AS $$
SELECT
  *
FROM
  person
WHERE
  gender = 'male';

$$ LANGUAGE SQL;

---------------------------------- CHECK -------------------------------
SELECT
  *
FROM
  fnc_persons_female();

SELECT
  *
FROM
  fnc_persons_male();
