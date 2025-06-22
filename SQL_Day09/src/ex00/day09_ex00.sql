-- Упражнение 00 - Аудит входящих вкладышей
-- 
-- Мы хотим быть более надежными с данными и не хотим терять ни одного события изменений. 
-- Давайте внедрим функцию аудита для входящих изменений INSERT. 
-- Пожалуйста, создайте таблицу `person_audit` с той же структурой, что и в таблице person, 
-- но, пожалуйста, внесите несколько дополнительных изменений. 
-- Взгляните на приведенную ниже таблицу с описаниями для каждого столбца.
-- | Столбец | Тип | Описание |
-- | ------ | ------ | ------ |
-- | создано | временная метка с часовым поясом | отметкой времени при создании нового события. 
-- Значение по умолчанию - это текущая временная метка, а НЕ NULL |
-- | type_event | char(1) | возможные значения I (вставить), D (удалить), U (обновить). Значение по умолчанию - ‘I’. НЕ NULL. 
-- Добавьте контрольное ограничение `ch_type_event` с возможными значениями ‘I’, ‘U’ и ‘D’ |
-- | row_id | bigint | копия person.id. НЕ NULL |
-- | имя |переменная | копия person.name (без каких-либо ограничений) |
-- | возраст |целое число | копия person.age (без каких-либо ограничений) |
-- | пол |переменная | копия person.gender (без каких-либо ограничений) |
-- | адрес |переменная | копия person.address (без каких-либо ограничений) |
-- На самом деле, давайте создадим триггерную функцию базы данных с именем `fnc_trg_person_insert_audit`, 
-- которая должна обрабатывать трафик `INSERT` DML и создавать копию новой строки в таблицу person_audit.
-- Просто подсказка, если вы хотите реализовать триггер PostgreSQL (пожалуйста, прочтите это в документации PostgreSQL), 
-- вам нужно создать 2 объекта: функцию запуска базы данных и триггер базы данных. 
-- Итак, пожалуйста, определите триггер базы данных с именем `trg_person_insert_audit` со следующими опциями
-- - триггер с опцией “ДЛЯ КАЖДОЙ СТРОКИ”
-- - триггер с опцией “ПОСЛЕ ВСТАВКИ”
-- - триггер вызывает триггерную функцию fnc_trg_person_insert_audit
-- Когда вы будете готовы к работе с объектами-триггерами, пожалуйста, сделайте команду `ВСТАВИТЬ` в таблицу person. 
-- INSERT INTO person(id, name, age, gender, address) VALUES (10,'Damir', 22, 'male', 'Irkutsk');
-- 
-- удаление таблицы person если она существует
DROP TABLE IF EXISTS person_audit;

-- удаление триггера для таблицы person
DROP TRIGGER IF EXISTS trg_person_insert_audit ON person;

-- удаление функции
DROP FUNCTION IF EXISTS fnc_trg_person_insert_audit ();

-- показать все доступные триггеры для таблицы person
SELECT
  *
FROM
  information_schema.triggers
WHERE
  event_object_table = 'person';

----------------------------------------- CREATE TABLE PERSON_AUDIT ---------------------------------------
CREATE TABLE
  IF NOT EXISTS person_audit (
    row_id BIGINT NOT NULL,
    name VARCHAR(20),
    age INT,
    gender VARCHAR(10),
    address VARCHAR(20),
    type_event CHAR(1) NOT NULL DEFAULT 'I' CONSTRAINT ch_type_event CHECK (type_event IN ('I', 'D', 'U')),
    created TIMESTAMP
    WITH
      TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
  );

--------------------------------------------- TRIGGER FUNCTION --------------------------------------------
CREATE OR REPLACE FUNCTION fnc_trg_person_insert_audit() RETURNS TRIGGER AS $$
BEGIN
INSERT INTO
  person_audit (
    row_id,
    name,
    age,
    gender,
    address,
    type_event,
    created
  )
VALUES
  (
    NEW.id,
    NEW.name,
    NEW.age,
    NEW.gender,
    NEW.address,
    'I',
    CURRENT_TIMESTAMP
  );

RETURN NULL;

END;

$$ LANGUAGE plpgsql;

------------------------------------------------- TRIGGER -------------------------------------------------
CREATE TRIGGER trg_person_insert_audit AFTER INSERT ON person FOR EACH ROW EXECUTE FUNCTION fnc_trg_person_insert_audit ();

-------------------------------------------------- INSERT -------------------------------------------------
INSERT INTO
  person (id, name, age, gender, address)
VALUES
  (10, 'Damir', 22, 'male', 'Irkutsk');

-------------------------------------------------- CHECK --------------------------------------------------
SELECT
  *
FROM
  person;

SELECT
  *
FROM
  person_audit;

------------------------------------------------- DELETE --------------------------------------------------
DELETE FROM person
WHERE
  id = 10;

DELETE FROM person_audit
WHERE
  row_id = 10;
