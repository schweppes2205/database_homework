-- 1. В базе данных shop и sample присутствуют одни и те же таблицы, 
-- учебной базы данных. Переместите запись id = 1 из таблицы 
-- shop.users в таблицу sample.users. Используйте транзакции.

-- select * from shop.users u ;
-- select * from sample.users u;

select @user_id_task01 := 1;

start transaction;

select * from shop.users u
where id = 1;

update sample.users set 
name = (select name from shop.users where id = @user_id_task01)
where id = @user_id_task01;

delete from shop.users 
where id = @user_id_task01;

commit;

-- select * from shop.users u ;
-- select * from sample.users u;