-- SQL Syntax Construction - generate_series(...)
-- Создайте представление базы данных (с именем v_generated_dates), 
-- которое должно "хранить" сгенерированные даты с 1 по 31 января 2022 года в типе DATE. 
-- Не забудьте про порядок столбца generated_date.

CREATE VIEW
  v_generated_dates AS
SELECT
  generate_date::DATE
FROM
  generate_series (
    '2022-01-01'::DATE, 
    '2022-01-31', 
    '1 DAY'
  ) AS generate_date
ORDER BY
  generate_date;

-- Chek
SELECT
  *
FROM
  v_generated_dates;

DROP VIEW IF EXISTS v_generated_dates;
