-- Упражнение 03 - Общий аудит
-- 
-- На самом деле, есть 3 триггера для одной таблицы person. 
-- Давайте объединим всю нашу логику в один главный триггер 
-- с именем trg_person_audit и новую соответствующую 
-- триггерную функцию fnc_trg_person_audit.
-- 
-- Другими словами, весь трафик DML (INSERT, UPDATE, DELETE) 
-- должен обрабатываться из одного функционального блока. 
-- Пожалуйста, явно определите отдельный блок IF-ELSE 
-- для каждого события (I, U, D)!
-- 
-- Дополнительно, пожалуйста, выполните следующие действия.
-- 
-- чтобы удалить 3 старых триггера из таблицы person.
-- удалить 3 старые триггерные функции
-- выполнить УСЕЧЕНИЕ (или УДАЛЕНИЕ) всех строк в нашей таблице person_audit
-- 
-- Когда вы будете готовы, пожалуйста, повторно примените набор инструкций DML.
-- `INSERT INTO person(id, name, age, gender, address)  VALUES (10,'Damir', 22, 'male', 'Irkutsk');`
-- `UPDATE person SET name = 'Bulat' WHERE id = 10;`
-- `UPDATE person SET name = 'Damir' WHERE id = 10;`
-- `DELETE FROM person WHERE id = 10;`
-- 
---------------------- DROP TRIGGER & FUNCTION -------------------------
DROP TRIGGER IF EXISTS trg_person_delete_audit on person cascade;

DROP TRIGGER IF EXISTS trg_person_insert_audit on person cascade;

DROP TRIGGER IF EXISTS trg_person_update_audit on person cascade;

DROP FUNCTION IF EXISTS fnc_trg_person_delete_audit;

DROP FUNCTION IF EXISTS fnc_trg_person_insert_audit;

DROP FUNCTION IF EXISTS fnc_trg_person_update_audit;

-------------------------- TRIGGER FUNCTION ----------------------------
CREATE OR REPLACE FUNCTION fnc_trg_person_audit() RETURNS TRIGGER AS $$
BEGIN
IF (TG_OP = 'DELETE') THEN
INSERT INTO
  person_audit (type_event, row_id, name, age, gender, address)
VALUES
  (
    'D',
    old.id,
    old.name,
    old.age,
    old.gender,
    old.address
  );

ELSEIF (TG_OP = 'UPDATE') THEN
INSERT INTO
  person_audit (type_event, row_id, name, age, gender, address)
VALUES
  (
    'U',
    old.id,
    old.name,
    old.age,
    old.gender,
    old.address
  );

ELSEIF (TG_OP = 'INSERT') THEN
INSERT INTO
  person_audit (type_event, row_id, name, age, gender, address)
VALUES
  (
    'I',
    new.id,
    new.name,
    new.age,
    new.gender,
    new.address
  );

END IF;

RETURN NEW;

END;

$$ LANGUAGE plpgsql;
-------------------------------- TRIGGER -------------------------------
CREATE
OR REPLACE TRIGGER trg_person_audit AFTER INSERT
OR
UPDATE
OR DELETE ON person FOR EACH ROW EXECUTE PROCEDURE fnc_trg_person_audit ();

--------------------------- DELETE & TRUNCATE --------------------------
DELETE FROM person WHERE id = 10;

-- усекаем person_audit таблицу, чтобы удалить все существующие записи.
TRUNCATE person_audit;

--------------------------------- INSERT -------------------------------
INSERT INTO
  person (id, name, age, gender, address)
VALUES
  (10, 'Damir', 22, 'male', 'Irkutsk');

UPDATE person
SET
  name = 'Bulat'
WHERE
  id = 10;

UPDATE person
SET
  name = 'Damir'
WHERE
  id = 10;

DELETE FROM person
WHERE
  id = 10;

---------------------------------- CHECK -------------------------------
SELECT
  *
FROM
  person;

SELECT
  *
FROM
  person_audit;
