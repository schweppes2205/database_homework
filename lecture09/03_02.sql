-- 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное 
-- значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля 
-- были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.

use shop;
drop trigger if exists shop_products_insert;
drop trigger if exists shop_products_update;

delimiter //
create trigger shop_products_insert before insert on products
for each row
BEGIN 
	if (new.name is null and new.description is null) THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No possibility for name and description to be NULL simultaneously';
	end if;
END//

create trigger shop_products_update before update on products
for each row
BEGIN 
	if 
		(new.name is null and new.description is null) or
		(old.name is null and new.description is null) or
		(new.name is null and old.description is null)
	THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No possibility for name and description to be NULL simultaneously';
	end if;
END//
delimiter ;

INSERT into products (name,description) 
values 
	('test1','test2'),
	(NULL,NULL),
	('test3','test4');
select * from products p2;

INSERT into products (name,description) 
values 
	('test1',NULL),
	(NULL,'test2'),
	('test3','test4');

select * from products p2;

update products
set name = NULL 
where name = 'test1';

update products
set description = NULL 
where description = 'test2';

update products
set description = NULL 
where name = 'test3';

select * from products p2;

-- к сожалению не понял и не нашел, можно ли как-то отменить запись того элемента, что нас не устраивает. 
-- данный триггер отменяет всю операцию, как я понимаю в реальной жизни это может быть болезненно.