-- 2. Создайте представление, которое выводит название name товарной позиции 
-- из таблицы products и соответствующее название каталога name из таблицы catalogs.

create view task02_view as 
select 
	p.name as product_name,
	c.name as catalog_name
from products p, catalogs c 
where p.catalog_id = c.id;

select * from task02_view tv 