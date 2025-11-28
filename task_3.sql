/*добавьте сюда запрос для решения задания 3*/
SELECT
distinct cafe_name,
COUNT(manager_uuid) over(partition by restaurant_uuid) as managers_count
from cafe.restaurants
join cafe.restaurant_manager_work_dates using(restaurant_uuid)
group by cafe_name, restaurant_uuid, manager_uuid
order by managers_count desc
limit 3;