-- Пожалуйста, найдите пиццерии, которые чаще посещали женщины или мужчины.
-- Сохраните дубликаты для любых операторов SQL с множествами 
-- (конструкции UNION ALL, EXCEPT ALL, INTERSECT ALL). 
-- Отсортируйте результат по названию пиццерии. 
-- Пример данных показан ниже.

SELECT
  more_fem_mel.pizzeria_name
FROM
  (
    SELECT
      pz.name AS pizzeria_name,
      COUNT(p.gender) AS visits
    FROM
      pizzeria pz
      JOIN person_visits pv ON pz.id = pv.pizzeria_id
      JOIN person p ON pv.person_id = p.id
    WHERE
      p.gender = 'female'
    GROUP BY
      pz.name
    EXCEPT ALL
    SELECT
      pz.name AS pizzeria_name,
      COUNT(p.gender) AS visits
    FROM
      pizzeria pz
      JOIN person_visits pv ON pz.id = pv.pizzeria_id
      JOIN person p ON pv.person_id = p.id
    WHERE
      p.gender = 'male'
    GROUP BY
      pz.name
  ) AS more_fem_mel
ORDER BY
  pizzeria_name;
