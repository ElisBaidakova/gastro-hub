/*добавьте сюда запрос для решения задания 1*/
select distinct restaurants.cafe_name, restaurants.type, ROUND(avg_check, 2) as avg_check
from cafe.restaurants
join (
    select
    distinct cafe_name,
    type,
    avg_check,
    row_number() over (partition by type order by avg_check desc) as rn
    from cafe.sales
    join cafe.restaurants using(restaurant_uuid)
    group by cafe_name, type, avg_check
    order by rn
    ) mch
on restaurants.cafe_name = mch.cafe_name
where rn < 4
order by cafe_name;