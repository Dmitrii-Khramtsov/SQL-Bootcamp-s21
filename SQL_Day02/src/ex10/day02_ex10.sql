-- Найдите имена людей, которые живут по одному адресу.
-- Убедитесь, что результат отсортирован по имени 1-го человека,
-- имени 2-го человека и общему адресу. Образец данных показан ниже.
-- Убедитесь, что названия ваших столбцов совпадают с названиями столбцов ниже.

SELECT
  p1.name AS person_name1,
  p2.name AS person_name2,
  p1.address AS common_address,
  p1.id,
  p2.id

FROM
  person AS p1
  JOIN person AS p2 ON p1.address = p2.address
  AND p1.id > p2.id
ORDER BY
  1,
  2,
  3;
