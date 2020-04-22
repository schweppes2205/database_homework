-- 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были 
-- заданы типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10". 
-- Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
use shop;
-- create a copy of users table with created_at and updated_at as varchar
drop table if exists users_task_2;
create table users_task_2 (
	id serial primary key,
	name varchar(255),
	birthday_at date,
	created_at varchar(20),
	updated_at varchar(20)
);

-- copy content inserting current datetime as varchar in required format "20.10.2017 8:10".
insert into 
	users_task_2 
select 
	id,
	name,
	birthday_at, 
	DATE_FORMAT(now(),'%d.%m.%Y %h:%i'),
	DATE_FORMAT(now(),'%d.%m.%Y %h:%i')
from 
	users;

-- updating table changing char to datetime;
update 
	users_task_2
set 
	created_at = str_to_date(created_at ,'%d.%m.%Y %h:%i'),
	updated_at = str_to_date(updated_at ,'%d.%m.%Y %h:%i')
;