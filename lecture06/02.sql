-- 2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.

select count(*) from likes
where media_id in (
	select id 
	from media
	where user_id in (
		select user_id 
		from profiles p 
		where year(birthday + INTERVAL 10 YEAR) > year(now())
	) 
);



