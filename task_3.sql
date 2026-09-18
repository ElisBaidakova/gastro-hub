/*Находим топ-3 заведения, где чаще всего менялся менеджер за весь период*/
SELECT
distinct cafe_name,
COUNT(manager_uuid) over(partition by restaurant_uuid) as managers_count
from cafe.restaurants
join cafe.restaurant_manager_work_dates using(restaurant_uuid)
group by cafe_name, restaurant_uuid, manager_uuid
order by managers_count desc
limit 3;
