-- 2. Выведите список товаров products и разделов catalogs, который соответствует товару.
use shop;

select p.name ,c.name from products p ,catalogs c where p.catalog_id = c.id 