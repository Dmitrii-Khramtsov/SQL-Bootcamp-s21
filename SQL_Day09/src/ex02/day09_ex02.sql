-- Упражнение 02 - Проверка входящих удалений
-- 
-- Наконец, нам нужно обработать инструкции DELETE 
-- и создать копию СТАРЫХ состояний для всех значений атрибута. 
-- Пожалуйста, создайте триггер trg_person_delete_audit 
-- и соответствующую триггерную функцию fnc_trg_person_delete_audit.
-- Когда вы будете готовы, пожалуйста, примените приведенную ниже инструкцию SQL.
-- 
-- DELETE FROM person WHERE id = 10;
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

--------------------------------- DELETE UPDATE ------------------------------
CREATE OR REPLACE FUNCTION fnc_trg_person_delete_audit() RETURNS TRIGGER AS $$
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
    'D',
    CURRENT_TIMESTAMP
  );

RETURN NULL;

END;

$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_person_delete_audit AFTER DELETE ON person FOR EACH ROW EXECUTE FUNCTION fnc_trg_person_delete_audit ();

----------------------------------- DELETE ------------------------------------
DELETE FROM person WHERE id = 10;

------------------------------------ CHECK -----------------------------------
SELECT
  *
FROM
  person;

SELECT
  *
FROM
  person_audit;
