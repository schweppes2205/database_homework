-- 3. Пусть имеется таблица рейсов flights (id, from, to) и 
-- таблица городов cities (label, name). Поля from, to и label 
-- содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.

drop database if exists lecture07_task03;
CREATE DATABASE lecture07_task03 CHARACTER SET utf8 COLLATE utf8_general_ci;
use lecture07_task03;

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  `from` VARCHAR(255),
  `to` varchar(255)
);

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  label VARCHAR(255),
  name varchar(255)
);


insert into flights (`from`,`to`)
values
('moscow','omsk'),
('novgorod','kazan'),
('irkutsk','moscow'),
('omsk','irkutsk'),
('moscow','kazan')


insert into cities
values
('moscow','Москва'),
('irkutsk','Иркутск'),
('novgorod','Новгород'),
('kazan','Казань'),
('omsk','Омск');

select * from flights f 

select `from`,`to` from 
(select f.id as id, c.name as `from` from cities c, flights f where c.label = f.`from`) as tbl1
join
(select f.id as id, c.name as `to` from cities c, flights f where c.label = f.`to`) as tbl2
using(id);
