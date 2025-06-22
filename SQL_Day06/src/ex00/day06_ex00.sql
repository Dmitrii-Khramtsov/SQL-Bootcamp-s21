-- Пожалуйста, подумайте о персональных скидках для людей с одной стороны и ресторанов-пиццерий 
-- с другой. Необходимо создать новую реляционную таблицу (пожалуйста, задайте имя person_discounts) 
-- со следующими правилами.
-- 
-- установите атрибут id в качестве первичного ключа 
-- (пожалуйста, взгляните на столбец id в существующих таблицах и выберите тот же тип данных).
-- установить для атрибутов внешние ключи person_id и pizzeria_id для соответствующих таблиц 
-- (типы данных должны быть такими же, как для столбцов id в соответствующих родительских таблицах)
-- пожалуйста, задайте явные имена для ограничений внешних ключей по шаблону 
-- fk_{имя_таблицы}_{имя_столбца}, например fk_person_discounts_person_id
-- добавьте атрибут скидки, чтобы сохранить значение скидки в процентах. 
-- Помните, значение скидки может быть числом с плавающей запятой 
-- (пожалуйста, просто используйте тип данных числовой). 
-- Поэтому, пожалуйста, выберите соответствующий тип данных, чтобы учесть эту возможность.
-- 
DROP TABLE IF EXISTS person_discounts;

-- Create table
CREATE TABLE
  IF NOT EXISTS person_discounts (
    id BIGINT PRIMARY KEY,
    person_id BIGINT NOT NULL,
    pizzeria_id BIGINT NOT NULL,
    discount NUMERIC,
    CONSTRAINT fk_person_discounts_person_id FOREIGN KEY (person_id) REFERENCES person (id),
    CONSTRAINT fk_person_discounts_pizzeria_id FOREIGN KEY (pizzeria_id) REFERENCES pizzeria (id)
  );

SELECT
  *
FROM
  person_discounts;