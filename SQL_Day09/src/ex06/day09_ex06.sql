-- Упражнение 06 - Функционировать как функция-оболочка
-- 
-- Давайте прямо сейчас рассмотрим функции pl / pgsql.
-- 
-- Пожалуйста, создайте pl / pgsql 
-- функцию fnc_person_visits_and_eats_on_date на основе инструкции SQL, 
-- которая находит названия пиццерий, которые посетило лицо 
-- (параметр IN pperson со значением по умолчанию ‘Dmitriy’) 
-- и купило пиццу на сумму меньше указанной 
-- в рублях (параметр IN pprice со значением по умолчанию 500) 
-- на конкретную дату (параметр IN pdate со значением 
-- по умолчанию - 8 января 2022 года).
-- 
-- Чтобы проверить себя и вызвать функцию, вы можете выполнить инструкцию, 
-- подобную приведенной ниже.
-- select * from fnc_person_visits_and_eats_on_date(pprice := 800);
-- select * from fnc_person_visits_and_eats_on_date(pperson := 'Anna',pprice := 1300,pdate := '2022-01-01');
--
-- удаление функций если они существуют
DROP FUNCTION IF EXISTS fnc_person_visits_and_eats_on_date (varchar, NUMERIC, DATE);

--------------------------------- FUNCTION ----------------------------
CREATE OR REPLACE FUNCTION fnc_person_visits_and_eats_on_date (
  pperson varchar DEFAULT 'Dmitriy',
  pprice NUMERIC DEFAULT 500,
  pdate DATE DEFAULT '2022-01-08',
  OUT pizzeria_name VARCHAR
) RETURNS SETOF VARCHAR AS $$
BEGIN 
  RETURN QUERY (
  SELECT
    pz.name AS pizzeria_name
  FROM
    person_visits p_v
    JOIN person p ON p.id = p_v.person_id
    AND p.name = pperson
    JOIN menu m ON m.pizzeria_id = p_v.pizzeria_id
    AND m.price < pprice
    JOIN pizzeria pz ON pz.id = p_v.pizzeria_id
    AND p_v.visit_date = pdate
  );

END;

$$ LANGUAGE plpgsql;

---------------------------------- CHECK -------------------------------
SELECT
  *
FROM
  fnc_person_visits_and_eats_on_date (pprice := 800);

SELECT
  *
FROM
  fnc_person_visits_and_eats_on_date (
    pperson := 'Anna',
    pprice := 1300,
    pdate := '2022-01-01'
  );
