-- Упражнение 07 - Другой взгляд на поиск минимума
--
-- Пожалуйста, напишите функцию SQL или pl / pgsql `func_minimum` 
-- (это зависит от вас), у которой входным параметром является массив чисел, 
-- и функция должна возвращать минимальное значение. 
-- 
-- Чтобы проверить себя и вызвать функцию, вы можете выполнить инструкцию, 
-- подобную приведенной ниже.
-- SELECT func_minimum(VARIADIC arr => ARRAY[10.0, -1.0, 5.0, 4.4]);
--
-- удаление функций если они существуют
DROP FUNCTION IF EXISTS func_minimum(NUMERIC[]);

--------------------------------- FUNCTION ----------------------------
CREATE OR REPLACE FUNCTION func_minimum(VARIADIC arr NUMERIC[]) RETURNS NUMERIC AS $$
SELECT
  MIN(arr[i])
FROM
  generate_subscripts(arr, 1) g(i);

$$ LANGUAGE SQL;

---------------------------------- CHECK -------------------------------
SELECT
  func_minimum(VARIADIC arr => ARRAY[10.0, -1.0, 5.0, 4.4]);
