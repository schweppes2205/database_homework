-- 7. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
-- Следует учесть, что необходимы дни недели текущего года, а не года рождения.

use shop;

insert into users (name, birthday_at) values 
('Пользователь01','1992-08-29');

select 
	count(*) as total,
	week(CONCAT(YEAR(CURDATE()), '-', DATE_FORMAT(birthday_at, '%m-%d')),1) as week_number,
	any_value(name)
from 
	users 
group by
	week_number 
	
