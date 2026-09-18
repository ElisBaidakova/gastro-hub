/*Создаём представление, которое покажет топ-3 заведения внутри каждого типа заведений по среднему чеку за все даты*/
select distinct restaurants.cafe_name, restaurants.type, ROUND(avg_avg_check, 2) as avg_check
from cafe.restaurants
join (
    select
    distinct cafe_name,
    type,
    avg(avg_check) as avg_avg_check,
    row_number() over (partition by type order by avg(avg_check) desc) as rn
    from cafe.sales
    join cafe.restaurants using(restaurant_uuid)
    group by cafe_name, type
    order by rn
    ) mch
on restaurants.cafe_name = mch.cafe_name
where rn < 4
order by type, cafe_name;
