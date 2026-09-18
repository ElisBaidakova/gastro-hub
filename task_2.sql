/*
Создаём материализованное представление, которое покажет, как изменяется средний чек для каждого заведения 
от года к году за все года за исключением 2023 года
*/
CREATE MATERIALIZED VIEW check_dynamics AS
    SELECT
    check_year,
    cafe_name,
    type,
    current_check,
    lag(current_check) over (partition by cafe_name order by check_year) as previous_check,
    ((current_check - lag(current_check) over (partition by cafe_name order by check_year)) / 
    NULLIF(lag(current_check) over (partition by cafe_name order by check_year), 0)) * 100 as dynamics
    from (
        select
        distinct extract('year' from report_date::date) as check_year,
        restaurant_uuid,
        ROUND(avg(avg_check)) as current_check
        from cafe.sales
        where extract('year' from report_date::date) != 2023
        group by restaurant_uuid, check_year
        order by restaurant_uuid, check_year
        ) statistic 
    join cafe.restaurants using (restaurant_uuid)
    order by cafe_name, check_year;
