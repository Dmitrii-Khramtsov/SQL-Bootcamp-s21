-- Упражнение 01 - Подробный запрос
-- 
-- 
-- Прежде чем углубиться в эту задачу, выполните следующие операторы INSERT.
-- 
-- insert into currency values (100, 'EUR', 0.85, '2022-01-01 13:29');
-- insert into currency values (100, 'EUR', 0.79, '2022-01-08 13:29');
-- 
-- Напишите, пожалуйста, SQL-запрос, который возвращает всех пользователей, 
-- все балансовые транзакции (в этой задаче не учитываются валюты, 
-- у которых нет ключа в таблице `Currency`) с названием валюты 
-- и рассчитанным значением валюты в USD на следующий день.
-- 
-- Ниже приведена таблица столбцов результатов и соответствующая формула расчета.
-- 
-- | Выходной столбец | Формула (псевдокод)                                                            |
-- | ---------------- | ------------------------------------------------------------------------------ |
-- | name             | source: user.name if user.name is NULL then return `not defined` value         |
-- | lastname         | source: user.lastname if user.lastname is NULL then return `not defined` value |
-- | currency_name    | источник: currency.name                                                        | 
-- | currency_in_usd  | привлеченные источники: currency.rate_to_usd, currency.updated,balance.updated.| 
-- |                  | Посмотрите на графическую интерпретацию формулы ниже.                          | 
-- 
-- ![T01_06](misc/images/T01_06.png)
-- 
-- - Вам нужно найти ближайший курс_к_usd валюты в прошлом (t1).
-- - Если t1 пуст (значит, в прошлом не было курсов), то найдите ближайший курс_к_usd валюты в будущем (t2).
-- - Используйте курс t1 ИЛИ t2 для расчета валюты в формате USD.
-- 
-- Смотрите пример вывода ниже. Отсортируйте результаты по имени пользователя в порядке убывания, 
-- а затем по фамилии пользователя и названию валюты в порядке возрастания.
-- 
-- | name   | lastname | currency_name | currency_in_usd |
-- | ------ | -------- | ------------- | --------------- |
-- | Иван   | Иванов   | EUR           | 150.1           |
-- | Иван   | Иванов   | EUR           | 17              |
-- | ...    | ...      | ...           | ...             |
-- 
SELECT
  COALESCE(u.name, 'not defined') AS name,
  COALESCE(u.lastname, 'not defined') AS lastname,
  c.name AS currency_name,
  b.money * COALESCE(
    (
      SELECT
        rate_to_usd
      FROM
        currency c
      WHERE
        b.currency_id = c.id
        AND c.updated < b.updated
      ORDER BY
        c.updated DESC
      LIMIT
        1
    ),
    (
      SELECT
        rate_to_usd
      FROM
        currency c
      WHERE
        b.currency_id = c.id
        AND c.updated > b.updated
      ORDER BY
        c.updated ASC
      LIMIT
        1
    )
  ) AS currency_in_usd
FROM
  balance b
  LEFT JOIN "user" u ON u.id = b.user_id
  JOIN currency c ON b.currency_id = c.id
GROUP BY
  currency_in_usd,
  lastname,
  currency_name,
  u.name
ORDER BY
  name DESC,
  lastname ASC,
  currency_name ASC;
