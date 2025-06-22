-- Упражнение 00 - Классический TSP
--
-- Разрешено
-- SQL Рекурсивный запрос
--
-- Посмотрите на график слева. Есть 4 города (a, b, c и d)
-- и дуги между ними со стоимостью (или таксацией).
-- На самом деле стоимость (a,b) = (b,a).
-- Создайте таблицу с именами узлов, используя структуру
-- {point1, point2, cost}, и заполните ее данными,
-- основываясь на рисунке (помните, что между двумя узлами есть прямой и обратный пути).
--
-- Напишите, пожалуйста, один SQL-оператор, который возвращает все туры (они же пути)
-- с минимальной стоимостью проезда, если мы стартуем из города "a".
-- Помните, что вам нужно найти самый дешевый способ посетить все города
-- и вернуться в начальную точку.
-- Например, тур выглядит так: a -> b -> c -> d -> a.
--
-- Пример выходных данных вы можете найти ниже.
--
-- Пожалуйста, отсортируйте данные по total_cost, а затем по tour.
--
-- total_cost tour
-- 80 {a,b,d,c,a}
-- ... ...
--
--
DROP TABLE IF EXISTS cities;

CREATE TABLE
  IF NOT EXISTS cities (
    point1 CHARACTER VARYING(1) NOT NULL,
    point2 CHARACTER VARYING(1) NOT NULL,
    cost INTEGER NOT NULL,
    -- ОГРАНИЧЕНИЯ ВВОДА:
    -- составной первичный ключ(только уникальные сочетания p1 и p2), по сути аналог UNIQUE
    PRIMARY KEY (point1, point2),
    -- проверка ввода. Обрати внимание, что пустое значение '' не тоже самое что и NOT NULL
    CHECK (
      cost > 0
      AND point1 != ''
      AND point2 != ''
      AND point1 != point2
    )
  );

INSERT INTO
  cities (point1, point2, cost)
VALUES
  ('a', 'b', 10),
  ('b', 'a', 10),
  ('a', 'c', 15),
  ('c', 'a', 15),
  ('a', 'd', 20),
  ('d', 'a', 20),
  ('b', 'c', 35),
  ('c', 'b', 35),
  ('b', 'd', 25),
  ('d', 'b', 25),
  ('c', 'd', 30),
  ('d', 'c', 30);

SELECT
  *
FROM
  cities;

WITH
  all_tours AS (
    SELECT
      SUM(c_1.cost + c_2.cost + c_3.cost + c_4.cost)::int AS total_cost,
      CONCAT (
        '{',
        c_1.point1,
        ',',
        c_1.point2,
        ',',
        c_2.point1,
        ',',
        c_2.point2,
        ',',
        c_1.point1,
        '}'
      ) AS tour
    FROM
      cities c_1
      JOIN cities c_2 ON c_1.point1 != c_2.point1
      AND c_1.point1 != c_2.point2
      AND c_1.point2 != c_2.point1
      AND c_1.point2 != c_2.point2
      AND c_1.point1 = 'a'
      JOIN cities c_3 ON c_3.point1 = c_1.point2
      AND c_3.point2 = c_2.point1
      JOIN cities c_4 ON c_4.point1 = c_2.point2
      AND c_4.point2 = c_1.point1
    GROUP BY
      c_1.point1,
      c_1.point2,
      c_2.point1,
      c_2.point2
  )
SELECT
  total_cost,
  tour
FROM
  all_tours
WHERE
  total_cost = (
    SELECT
      MIN(total_cost)
    FROM
      all_tours
  )
ORDER BY
  total_cost,
  tour;

-- Вариант решения через рекурсию
WITH
  all_tours AS (
    WITH RECURSIVE
      tours AS (
        -- Базовый случай: начальный город 'a'
        SELECT
          c1.point1,
          c1.point2,
          c1.cost,
          ARRAY[point1, point2]::character varying[] AS tour,
          c1.cost AS total_cost
        FROM
          cities c1
        WHERE
          point1 = 'a'
        UNION ALL
        -- Рекурсивный случай: добавление следующего города к tour
        SELECT
          c2.point1,
          c2.point2,
          c2.cost,
          t.tour || c2.point2 AS tour,
          t.total_cost + c2.cost AS total_cost
        FROM
          cities c2
          JOIN tours t ON t.point2 = c2.point1
        WHERE
          NOT c2.point2 = ANY (t.tour)
      )
    SELECT
      total_cost + (
        SELECT
          cost
        FROM
          cities
        WHERE
          point1 = tour[array_length(tour, 1)]
          AND point2 = 'a'
      ) AS total_cost,
      CONCAT (
        ARRAY_APPEND(tour, tour[1])
      ) AS tour
    FROM
      tours
    WHERE
      ARRAY_LENGTH (tour, 1) = 4
  )
SELECT
  total_cost,
  tour
FROM
  all_tours
WHERE
  total_cost = (
    SELECT
      MIN(total_cost)
    FROM
      all_tours
  )
ORDER BY
  total_cost,
  tour;