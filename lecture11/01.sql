-- 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users,
-- catalogs и products в таблицу logs помещается время и дата создания записи, название 
-- таблицы, идентификатор первичного ключа и содержимое поля name.

use shop;
drop table if exists logs;
create table logs (
	id serial,
	requestTime timestamp,
	tableName varchar(255),
	recordId bigint,
	recordName varchar(255)
) ENGINE=ARCHIVE; 

drop trigger if exists product_logs;
create trigger product_logs after insert on products 
for each row 
	insert into logs 
		(recordid, recordname, requesttime, tablename) 
	values 
		(new.id, new.name, now(),'product');
	
drop trigger if exists catalog_logs;
create trigger catalog_logs after insert on catalogs
for each row 
	insert into logs 
		(recordid, recordname, requesttime, tablename) 
	values 
		(new.id, new.name, now(),'catalogs');

insert into products
	(name)
values
	('lab11_task1_name01_test'),
	('lab11_task1_name02_test');

insert into catalogs 
	(name)
values
	('name05_test'),
	('name06_test');

select * from logs;

-- show engines;