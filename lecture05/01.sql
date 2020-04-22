-- 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
-- Заполните их текущими датой и временем.
use shop;
update 
	shop.users 
set 
	shop.users.created_at = now(),
	shop.users.updated_at = now();