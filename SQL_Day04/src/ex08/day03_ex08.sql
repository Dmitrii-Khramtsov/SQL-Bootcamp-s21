-- После всех упражнений у нас есть пара виртуальных таблиц 
-- и материализованное представление. Давайте их запустим!

DROP VIEW IF EXISTS v_persons_female;

DROP VIEW IF EXISTS v_persons_male;

DROP VIEW IF EXISTS v_generated_dates;

DROP VIEW IF EXISTS v_symmetric_union;

DROP VIEW IF EXISTS v_price_with_discount;

DROP MATERIALIZED VIEW mv_dmitriy_visits_and_eats;
