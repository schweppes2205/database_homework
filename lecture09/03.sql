-- 3. (по желанию) Пусть имеется таблица с календарным полем created_at.
-- В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', 
-- '2018-08-04', '2018-08-16' и '2018-08-17'. Составьте запрос, который выводит 
-- полный список дат за август, выставляя в соседнем поле значение 1, 
-- если дата присутствует в исходной таблице и 0, если она отсутствует.

drop database if exists lecture09_task03;
create database lecture09_task03;
use lecture09_task03;
create table task03 (
	created_at date
);

insert task03 values 
	('2018-08-01'), 
	('2018-08-04'), 
	('2018-08-16'),
	('2018-08-17');
	
create view data_table as 
select a.Date
from (
    select last_day('2018-08-01') - INTERVAL (a.a + (10 * b.a) + (100 * c.a)) DAY as Date
    from (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as a
    cross join (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as b
    cross join (select 0 as a union all select 1 union all select 2 union all select 3 union all select 4 union all select 5 union all select 6 union all select 7 union all select 8 union all select 9) as c
) a 
where a.Date between '2018-08-01' and last_day('2018-09-01') order by a.Date;

select `date`,
	(
	CASE
		when a.`date` = b.created_at then '1'
		else '0'
	end
	) as meet
from data_table a
left join task03 b
on a.`date` = b.created_at 
order by date;
	