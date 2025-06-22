-- Найдите имена всех женщин старше 25 лет и отсортируйте результат по имени. 
-- Пример выходных данных показан ниже.

SELECT
  name AS Имя
FROM
  person
WHERE
  age > 25 AND gender = 'female'
ORDER BY
  name;
