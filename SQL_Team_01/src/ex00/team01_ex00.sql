-- Упражнение 00 - Классический DWH
-- 
-- Напишите, пожалуйста, SQL-запрос, который возвращает общий объем 
-- (сумму всех денег) транзакций с баланса пользователя, 
-- агрегированный по пользователю и типу баланса. Обратите внимание, 
-- что должны быть обработаны все данные, включая данные с аномалиями. 
-- Ниже представлена таблица результирующих столбцов и соответствующая 
-- формула расчета.
-- Выходной столбец	Формула (псевдокод)
-- name	            источник user.name if user.name is NULL then return not defined value
-- lastname	        источник user.lastname if user.lastname is NULL then return not defined value
-- type	            источник balance.type
-- volume	            источник balance.money Необходимо собрать все «движения» денег
-- currency_name   	источник currency.name if currency.name is NULL then return not defined value
-- last_rate_to_usd	источник currency.rate_to_usd. берем последний currency.rate_to_usd для соответствующей валюты if currency.rate_to_usd is NULL then return 1
-- total_volume_in_usd	источник volume , last_rate_to_usd. выполните умножение между volume и last_rate_to_usd
-- Посмотрите на пример выходных данных ниже. 
-- Отсортируйте результат по имени пользователя в режиме убывания, 
-- а затем по имени пользователя и типу баланса в режиме возрастания.
-- 
-- | name	| lastname	  | type | volume |	currency_name	| last_rate_to_usd | total_volume_in_usd |
-- | Петр	| not defined	| 2	   | 203	  | not defined	  | 1	               | 203                 |
-- | Иван	| Иванов	    | 1	   | 410	  | EUR	          | 0.9	             | 369                 |
-- | ...	| ...         |	...  | ...	  | ...           |	...              | ...                 |

WITH
  pre_query AS (
    SELECT
      COALESCE("user".name, 'not defined') name,
      COALESCE("user".lastname, 'not defined') lastname,
      balance.type,
      balance.money volume,
      COALESCE(
        (
          CASE
            WHEN balance.currency_id IN (
              SELECT DISTINCT
                id
              FROM
                currency
            ) THEN (
              SELECT DISTINCT
                name
              FROM
                currency
              WHERE
                balance.currency_id = currency.id
            )
          END
        ),
        'not defined'
      ) currency_name,
      COALESCE(
        (
          SELECT
            currency.rate_to_usd
          FROM
            currency
          WHERE
            last_currency.max = currency.updated
            AND last_currency.id = currency.id
        ),
        1
      ) last_rate_to_usd
    FROM
      balance
      LEFT JOIN "user" ON "user".id = balance.user_id
      LEFT JOIN (
        SELECT
          id,
          MAX(updated)
        FROM
          currency
        GROUP BY
          name,
          id
      ) last_currency ON last_currency.id = balance.currency_id
  )
SELECT
  name,
  lastname,
  type,
  SUM(volume) volume,
  currency_name,
  last_rate_to_usd,
  SUM(last_rate_to_usd * volume) total_volume_in_usd
FROM
  pre_query
GROUP BY
  type,
  name,
  lastname,
  currency_name,
  last_rate_to_usd
ORDER BY
  name DESC,
  lastname,
  type;
