-- 3. Определить кто больше поставил лайков (всего): мужчины или женщины.

select 
	count(*) as totalLikes,
	"male" as gender
from likes
where media_id in (
	select id 
	from media 
	where user_id in (
		select user_id 
		from profiles 
		where gender = "m"
	)
)
UNION 
select 
	count(*) as totalLikes,
	"female" as gender
from likes
where media_id in (
	select id 
	from media 
	where user_id in (
		select user_id 
		from profiles 
		where gender = "f"
	)
)
order by totalLikes desc limit 1