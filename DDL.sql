create schema cafe;

CREATE TYPE cafe.restaurant_type AS ENUM ('coffee_shop', 'restaurant', 'bar', 'pizzeria');

create table cafe.restaurants(
restaurant_uuid uuid PRIMARY KEY DEFAULT GEN_RANDOM_UUID(),
cafe_name varchar,
type cafe.restaurant_type,
menu jsonb);

create table cafe.managers(
manager_uuid uuid primary key default GEN_RANDOM_UUID(),
manager varchar,
manager_phone varchar);

create table cafe.restaurant_manager_work_dates(
restaurant_uuid uuid REFERENCES cafe.restaurants(restaurant_uuid),
manager_uuid uuid REFERENCES cafe.managers(manager_uuid),
date_start date,
date_end date,
PRIMARY key (restaurant_uuid, manager_uuid)
);

create table cafe.sales(
report_date date,
restaurant_uuid uuid REFERENCES cafe.restaurants(restaurant_uuid),
avg_check numeric(6, 2),
PRIMARY key (report_date, restaurant_uuid)
);
