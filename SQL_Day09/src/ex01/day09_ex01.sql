-- Упражнение 01 - Аудит входящих обновлений
-- 
-- Давайте продолжим реализацию нашего шаблона аудита для таблицы person. 
-- Просто определите триггер trg_person_update_audit 
-- и соответствующую триггерную функцию fnc_trg_person_update_audit 
-- для обработки всего трафика ОБНОВЛЕНИЙ в таблице person. 
-- Мы должны сохранить СТАРЫЕ состояния всех значений атрибута.
-- 
-- Когда вы будете готовы, пожалуйста, примените инструкции UPDATE ниже.
-- `UPDATE person SET name = 'Bulat' WHERE id = 10;`
-- `UPDATE person SET name = 'Damir' WHERE id = 10;`
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

--------------------------------- TRIGGER UPDATE ------------------------------
CREATE OR REPLACE FUNCTION fnc_trg_person_update_audit() RETURNS TRIGGER AS $$
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
    OLD.id,
    OLD.name,
    OLD.age,
    OLD.gender,
    OLD.address,
    'U',
    CURRENT_TIMESTAMP
  );

RETURN NULL;

END;

$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_person_update_audit AFTER
UPDATE ON person FOR EACH ROW EXECUTE FUNCTION fnc_trg_person_update_audit ();

------------------------------------ UPDATE ----------------------------------
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

------------------------------------ CHECK -----------------------------------
SELECT
  *
FROM
  person;

SELECT
  *
FROM
  person_audit;
