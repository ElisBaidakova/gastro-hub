/*добавьте сюда запросы для решения задания 6*/
begin;
SELECT menu
from cafe.restaurants
where menu @> '{"Кофе": {"Капучино": null}}'
FOR NO KEY UPDATE;  --Выбрана блокировка строк для внесения изменений в неключевые поля
UPDATE cafe.restaurants
SET menu = jsonb_set(menu, '{Кофе, Капучино}', ((menu -> 'Кофе' -> 'Капучино')::numeric * 1.2)::text::jsonb)
WHERE menu @> '{"Кофе": {"Капучино": null}}';
commit;