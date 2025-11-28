/*добавьте сюда запрос для решения задания 2*/
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
        ROUND(avg(avg_check) over (partition by restaurant_uuid order by extract('year' from report_date::date)), 2) as current_check
        from cafe.sales
        where extract('year' from report_date::date) != 2023
        order by restaurant_uuid, check_year
        ) statistic 
    join cafe.restaurants using (restaurant_uuid)
    order by cafe_name, check_year;