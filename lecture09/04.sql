-- 4. (по желанию) Пусть имеется любая таблица с календарным полем created_at. 
-- Создайте запрос, который удаляет устаревшие записи из таблицы, 
-- оставляя только 5 самых свежих записей.
drop database if exists lecture09_task04;
create database lecture09_task04;
use lecture09_task04;
create table task04 (
	created_at date
);

insert task04 values 
	('2011-08-01'), 
	('2012-08-04'), 
	('2013-08-16'),
	('2014-08-17'),
	('2015-08-17'),
	('2016-08-17'),
	('2017-08-17'),
	('2018-08-17'),
	('2019-08-17'),
	('2020-08-17');

select * from task04;
create view limitation as select created_at from task04 order by created_at DESC limit 5;
delete from task04 where created_at not in (select * from limitation);
select * from task04;
	 