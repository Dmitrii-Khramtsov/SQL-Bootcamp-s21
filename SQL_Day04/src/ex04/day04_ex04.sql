-- Напишите оператор SQL, удовлетворяющий формуле (R - S)U(S - R) . 
-- Где R - это person_visits таблица с фильтром по 2 января 2022 года, 
-- S - это тоже person_visits таблица, 
-- но с другим фильтром по 6 января 2022 года. Пожалуйста, 
-- выполните свои вычисления с наборами в столбце person_id, 
-- и в результате этот столбец будет единственным. 
-- Пожалуйста, отсортируйте результат по person_id столбцу 
-- и представьте свой окончательный SQL в v_symmetric_union (*) представлении базы данных.
-- (*) Честно говоря, определения "symmetric union" не существует в теории множеств. 
-- Это авторская интерпретация, основная идея основана 
-- на существующем правиле симметричного различия.

CREATE VIEW
  v_symmetric_union AS
WITH
  R AS (
    SELECT
      person_id
    FROM
      person_visits
    WHERE
      visit_date = '2022-01-02'
  ),
  S AS (
    SELECT
      person_id
    FROM
      person_visits
    WHERE
      visit_date = '2022-01-06'
  ) (
    SELECT
      R.person_id
    FROM
      R
    EXCEPT
    SELECT
      S.person_id
    FROM
      S
  )
UNION
(
  SELECT
    S.person_id
  FROM
    S
  EXCEPT
  SELECT
    R.person_id
  FROM
    R
)
ORDER BY
  person_id;

-- Chek
SELECT
  *
FROM
  v_symmetric_union;

DROP VIEW IF EXISTS v_symmetric_union;
