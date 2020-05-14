-- 2. Создайте SQL-запрос, который помещает в таблицу users миллион записей.
-- единственный, понятный мне способ заполнить таблицу таким большим количеством значений.
-- вопросы, на который я не смог найти ответ, потому что скорее всего не знаю, как именно их понятно задать гуглу =)
-- 		можно ли генерировать на лету insert поточный в одном реквесте без функций\процедур?
--  	используя язык программирования можно сгенерировать строку запроса с 1 млн строк после values. можно ли это сделать средствами sql и затем запустить на исполнение?
--  	есть ли польза от такоё базы в памяти? она очень нестбильна из-за места её хранение, а фактически она может быть важна.
--   		может быть её стоит переместить после этого на жесткий диск? но это займет уйму времени, если я верно понимаю сравнимо с тем, что мы бы использовали движек InnoDB.
-- 			скорее всего тут вопрос вызван тем, что задача вне контекста, непонятен SLR этой таблицы.
-- первая попытка запуска скрипта была на InnoDB, чего ждать мне не хотелось. скорость была несколько сотен записей в секунду.
-- если я не понял "подвох" задания, учитываю именно ту секцию в которой она была задана, расскажите пожалуйста его =)

-- ALARM! memory engine used. procedure call is commented.
-- 500 MB in memory used
SET tmp_table_size = 1024 * 1024 * 500; 
SET max_heap_table_size = 1024 * 1024 * 500;

drop database if exists lecture11_01_02;
create database lecture11_01_02;
use lecture11_01_02;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL COMMENT 'Имя покупателя',
  `birthday_at` date DEFAULT NULL COMMENT 'Дата рождения',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
)engine=memory;

delimiter //
create procedure insert_mln() 
begin
	declare i int default 0;
	cycle: loop
		insert into users (name, birthday_at) values (CONCAT("user_test_", i), now() - interval floor(rand()*10000) day);
		if i = 1000000 then 
			leave cycle;
		end if;
		set i = i + 1;
	end loop cycle;
end//
delimiter ;


-- !!!PROCEDURE CALL START!!!
-- call insert_mln();


