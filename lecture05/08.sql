-- 8. (по желанию) Подсчитайте произведение чисел в столбце таблицы
use shop;

drop table if exists task_08;
create table task_08(
	value int
);

INSERT task_08
VALUES
(1),(2),(3),(4),(5);

select exp(sum(log(value))) from task_08 where value != 0;