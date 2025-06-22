-- Упражнение 01 - Противоположный TSP
--
-- Разрешенные
-- SQL Рекурсивный запрос
--
-- Пожалуйста, добавьте возможность просмотра дополнительных строк 
-- с наиболее высокой стоимостью в SQL из предыдущего упражнения. 
-- Просто взгляните на образец данных ниже. Пожалуйста, 
-- отсортируйте данные по total_cost, а затем по туру.
--
-- total_cost	tour
-- 80	{a,b,d,c,a}
-- ...	...
-- 95	{a,d,c,b,a}
--
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
  JOIN cities c_2 ON c_1.point1 = 'a'
                  AND 'a' NOT IN(c_2.point1, c_2.point2)
                  AND c_1.point2 NOT IN(c_2.point1, c_2.point2)
  JOIN cities c_3 ON c_3.point1 = c_1.point2 -- нужно для подсчёта total_cost
                  AND c_3.point2 = c_2.point1
  JOIN cities c_4 ON c_4.point1 = c_2.point2 -- нужно для подсчёта total_cost
                  AND c_4.point2 = c_1.point1
GROUP BY
  c_1.point1,
  c_1.point2,
  c_2.point1,
  c_2.point2
ORDER BY
  1,
  2;

-- Вариант решения через рекурсию
WITH RECURSIVE
    tours AS (
      SELECT
        -- point1,
        point2,
        -- cost,
        ARRAY[point1, point2]::text[] AS tour,
        cost AS total_cost
      FROM
        cities
      WHERE
        point1 = 'a'
      UNION ALL
      SELECT
        -- c2.point1,
        c2.point2,
        -- c2.cost,
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
        AND point2 = tour[1]
  ) AS total_cost,
       (tour || tour[1])::text AS tour
FROM
  tours
WHERE
  ARRAY_LENGTH(tour, 1) = (SELECT MAX(ARRAY_LENGTH(tour, 1)) FROM tours)
ORDER BY
  1,
  2;