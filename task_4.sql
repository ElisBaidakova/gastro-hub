/*Находим пиццерию с самым большим количеством пицц в меню*/
SELECT 
cafe_name,
pizzas_count
FROM (
    SELECT DISTINCT
    cafe_name,
    COUNT(*) AS pizzas_count,
    RANK() OVER (ORDER BY COUNT(*) DESC) AS rank
    FROM cafe.restaurants,
    JSONB_EACH(menu -> 'Пицца')
    GROUP BY cafe_name
) most_pizzas
WHERE rank = 1;
