-- 1. Создайте двух пользователей которые имеют доступ к базе данных shop. 
-- Первому пользователю shop_read должны быть доступны только запросы 
-- на чтение данных, второму пользователю shop — любые операции в пределах базы данных shop.

grant select on shop.* to shop_read@localhost identified by '12345';
grant all on shop.* to shop_all@localhost identified by '12345';