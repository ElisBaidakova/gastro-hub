/*Добавьте в этот файл запросы, которые наполняют данными таблицы в схеме cafe данными*/
insert into cafe.restaurants(cafe_name, type, menu)
select distinct cafe_name, type::cafe.restaurant_type, menu
from raw_data.sales
full join raw_data.menu using(cafe_name);

insert into cafe.managers(manager, manager_phone)
select distinct manager, manager_phone
from raw_data.sales;

insert into cafe.restaurant_manager_work_dates(restaurant_uuid, manager_uuid)
select distinct restaurant_uuid, manager_uuid
from cafe.restaurants
join raw_data.sales using(cafe_name)
join cafe.managers using(manager);

insert into cafe.sales(report_date, restaurant_uuid, avg_check)
select distinct report_date, restaurant_uuid, avg_check
from raw_data.sales
left join cafe.restaurants using(cafe_name);