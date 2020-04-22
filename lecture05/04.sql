-- 4. (по желанию) Из таблицы users необходимо извлечь пользователей, 
-- родившихся в августе и мае. Месяцы заданы в виде списка английских названий ('may', 'august')

use shop;

select * from users 
where DATE_FORMAT(birthday_at, '%M') in ('May','August');