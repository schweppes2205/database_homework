-- 6. Подсчитайте средний возраст пользователей в таблице users

use shop;

select AVG((date_format(now(),'%Y') - DATE_FORMAT(birthday_at,'%Y'))) as avg_age from users;
select AVG(year(now())- year(birthday_at)) as avg_age from users;
select AVG(timestampdiff(YEAR, birthday_at,now())) as avg_age from users;