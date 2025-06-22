-- Пожалуйста, добавьте следующие правила ограничений для существующих столбцов таблицы `person_discounts`.
-- - столбец person_id не должен быть NULL (используйте имя ограничения `ch_nn_person_id`);
-- - столбец pizzeria_id не должен быть NULL (используйте ограничение `ch_nn_pizzeria_id`);
-- - столбец discount не должен быть NULL (используйте ограничение `ch_nn_discount`);
-- - Столбец скидки по умолчанию должен быть равен 0 процентов;
-- - столбец скидки должен быть в диапазоне значений от 0 до 100 (используйте имя ограничения `ch_range_discount`).
--
-- Установка значения по умолчанию для столбца discount
ALTER TABLE person_discounts
ALTER COLUMN discount
SET DEFAULT 0;

-- Добавление ограничений на уровне столбцов
ALTER TABLE person_discounts ADD CONSTRAINT ch_nn_person_id CHECK (person_id IS NOT NULL),
ADD CONSTRAINT ch_nn_pizzeria_id CHECK (pizzeria_id IS NOT NULL),
ADD CONSTRAINT ch_nn_discount CHECK (discount IS NOT NULL);

-- Добавление ограничения диапазона значений для столбца discount
ALTER TABLE person_discounts ADD CONSTRAINT ch_range_discount CHECK (discount BETWEEN 0 AND 100);
