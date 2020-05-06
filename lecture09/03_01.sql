-- 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие,
-- в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна 
-- возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать 
-- фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

drop database if exists lecture09_03_task01;
create database lecture09_03_task01;
use lecture09_03_task01;

create procedure hello_world() 
begin
	if (hour(current_time()) > 6 and  hour(current_time()) < 11) then
		select "Доброе утро";
	elseif (hour(current_time()) > 12 and  hour(current_time()) < 17) then
		select "Добрый день";
	elseif (hour(current_time()) > 18 and  hour(current_time()) < 23) then
		select "Добрый  вечер";
	elseif (hour(current_time()) > 0 and  hour(current_time()) < 5) then
		select "Доброй ночи";
	end if;
end;

call hello_world();

