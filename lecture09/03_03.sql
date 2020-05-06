-- 3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
-- Числами Фибоначчи называется последовательность в которой число равно сумме двух 
-- предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.

drop database if exists lecture09_03_03;
create database lecture09_03_03;
use lecture09_03_03;

DROP FUNCTION IF EXISTS get_fib_n;
delimiter //
CREATE FUNCTION get_fib_n (n int)
RETURNS BIGINT NOT DETERMINISTIC
BEGIN
	declare i,n_0,n_2 int default 0;
	declare n_1 int default 1;
	cycle: loop
		set n_2 = n_0 + n_1;
		set n_0 = n_1;
		set n_1 = n_2;
-- 		select n_0, n_1, n_2;
		if i = n-2 then 
			leave cycle;
		end if;
		set i = i + 1;
	end loop cycle;
	RETURN n_2;
END//

select get_fib_n(10)//