-- 02. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке
select distinct users.firstname from users order by firstname

-- 03. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false). Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)
alter table profiles add is_active boolean default true;
update profiles set is_active=false where birthday > date(now()) - interval 18 year;

-- 04. Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней)
update messages set created_at="2040-06-14 05:48:08.0" where id between 10 and 30;
delete from messages where created_at > now();