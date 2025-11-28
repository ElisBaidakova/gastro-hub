/*добавьте сюда запрос для решения задания 5*/
select distinct name_and_price.cafe_name, dish, pizzas_name, max_price
from (
    select
    cafe_name,
    key as dish
    from cafe.restaurants,
         jsonb_each_text(restaurants.menu)
    where key = 'Пицца'
    ) dish_name,
    (
    select
    cafe_name,
    key as pizzas_name,
    value::numeric as price,
    MAX(value::numeric) over (partition by cafe_name) as max_price
    FROM cafe.restaurants,
         jsonb_each_text(restaurants.menu -> 'Пицца')
    ) name_and_price
where price = max_price
order by cafe_name;