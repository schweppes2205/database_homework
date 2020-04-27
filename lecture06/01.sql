-- 1. Пусть задан некоторый пользователь (1). Из всех друзей этого пользователя 
-- найдите человека, который больше всех общался с нашим пользователем.

use vk;
INSERT INTO `friend_requests` 
	(`initiator_user_id`, `target_user_id`, `status`, `requested_at`, `confirmed_at`) 
VALUES 
	('1', '5', 'approved', '1970-08-21 06:40:37', '2003-12-29 23:20:55'),
	('6', '1', 'approved', '1970-08-21 06:40:37', '2003-12-29 23:20:55'),
	('1', '7', 'approved', '1970-08-21 06:40:37', '2003-12-29 23:20:55'),
	('8', '1', 'approved', '1970-08-21 06:40:37', '2003-12-29 23:20:55'),
	('1', '9', 'approved', '1970-08-21 06:40:37', '2003-12-29 23:20:55'),
	('1', '11', 'approved', '1970-08-21 06:40:37', '2003-12-29 23:20:55'),
	('1', '12', 'approved', '1970-08-21 06:40:37', '2003-12-29 23:20:55'),
	('1', '13', 'approved', '1970-08-21 06:40:37', '2003-12-29 23:20:55'),
	('1', '14', 'approved', '1970-08-21 06:40:37', '2003-12-29 23:20:55');	

-- пользователь id = 1
-- из всех друзей этого пользователя - from friend_requests all approved +
-- который больше всех общался с нашим пользователем. messages to user 1
select 
	id,firstname
from 
	users,
	(
		select 
			count(*) as `count`,
			any_value(to_user_id ) as friend_id	
		from messages m 
		where 
			to_user_id in (
				select target_user_id from friend_requests fr where initiator_user_id = 1 and status = "approved"
				UNION 
				select initiator_user_id from friend_requests fr where target_user_id = 1 and status = "approved"
			)
			and
			from_user_id = 1
		group by friend_id
		UNION 
		select 
			count(*) as `count`,
			any_value(from_user_id ) as friend_id
		from messages m 
		where 
			from_user_id in (
				select target_user_id from friend_requests fr where initiator_user_id = 1 and status = "approved"
				UNION 
				select initiator_user_id from friend_requests fr where target_user_id = 1 and status = "approved"
			) 
			and
			to_user_id = 1
		group by friend_id
		order by `count` DESC limit 1
	) as res
where users.id = res.friend_id



