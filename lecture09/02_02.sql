-- 2. (по желанию) Пусть имеется таблица accounts содержащая три столбца 
-- id, name, password, содержащие первичный ключ, имя пользователя и его пароль. 
-- Создайте представление username таблицы accounts, предоставляющий доступ к 
-- столбца id и name. Создайте пользователя user_read, который бы не имел доступа 
-- к таблице accounts, однако, мог бы извлекать записи из представления username.

drop database if exists lecture09_02_task02;
create database lecture09_02_task02;
use lecture09_02_task02;
create table task02 (
	id serial,
	name varchar(100),
	`password` text
);

INSERT task02 (name,`password`) 
values 
	('user1', md5('mypass')),
	('user2', md5('alsomypass'));

create view task02_view as select id,name from task02;

select * from task02 t;
select * from task02_view;

grant select on lecture09_02_task02.task02_view to task02@localhost identified by '123';