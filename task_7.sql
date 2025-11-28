/*добавьте сюда запросы для решения задания 6*/
BEGIN;
LOCK TABLE cafe.managers IN EXCLUSIVE MODE;  --выбран наименее строгий режим, который подходит для изменения таблицы
ALTER TABLE cafe.managers ADD COLUMN phones JSONB;  --добавили поле для массива номеров

INSERT INTO cafe.managers (phones)  --вставляем данные в новое поле таблицы
SELECT jsonb_build_array(new_phone, manager_phone)  --создаём массив из телефонных номеров
FROM (
    SELECT concat('8-800-2500-', rn - 1 + 100) as new_phone,  --получаем новый номер телефона
           manager_phone
    FROM (
        SELECT *,
               ROW_NUMBER() OVER (ORDER BY manager) as rn  --получаем порядковый номер менеджера, отсортировав записи по алфавиту
        FROM cafe.managers
        ORDER BY manager
    ) manager_num
) sub;

ALTER TABLE cafe.managers DROP COLUMN manager_phone;  --удаляем поле со старым телефоном
COMMIT;