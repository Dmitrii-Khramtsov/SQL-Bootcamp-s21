-- Не используйте жестко заданное значение количества строк, 
-- чтобы установить правильное значение для последовательности
--
-- Давайте создадим последовательность базы данных 
-- с именем `seq_person_discounts` (начиная со значения 1) 
-- и установим значение по умолчанию для атрибута id таблицы `person_discounts`, 
-- чтобы каждый раз автоматически брать значение из `seq_person_discounts`. 
-- Обратите внимание, что ваш следующий номер последовательности равен 1, 
-- в этом случае задайте фактическое значение последовательности базы данных, 
-- основанное на формуле «количество строк в таблице person_discounts» + 1. 
-- В противном случае вы получите ошибки о нарушении ограничения Primary Key.
--
-- Удаление последовательности
DROP SEQUENCE IF EXISTS seq_person_discounts;
-- Создание последовательности
CREATE SEQUENCE seq_person_discounts START 1;

-- Определение значения по умолчанию для id в таблице person_discounts
ALTER TABLE person_discounts
ALTER COLUMN id
SET DEFAULT NEXTVAL ('seq_person_discounts');

-- Установка начального значения последовательности
SELECT
  CASE
    WHEN COUNT(*) > 0 THEN (
      SELECT
        setval ('seq_person_discounts', COUNT(*))
      FROM
        person_discounts
    )
  END
FROM
  person_discounts;

SELECT
  last_value
FROM
  seq_person_discounts;
