-- 1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
use shop;

INSERT orders (user_id)
values (1),(2),(2),(3);

select DISTINCT u.name from users u ,orders o where u.id = o.user_id;