use EHL;
-- проверка процедуры внесения пользователя
call insert_user_data('Василий','Pupkin',null,'паспорт',1234,123456,null,null,null,123456789,null,'m',now() - interval 30 year,'no comments'); 
-- 
-- проверка триггера на внесение нулевого значения указанного документа при использовании процедуры
call insert_user_data('Василий','Pupkin',null,'паспорт',null,123456,null,null,null,123456789,null,'m',now() - interval 30 year,'no comments');

-- проверка триггера на внесение записи в таблицу analysis_type с условием, что min больше, чем max
insert into analysis_type 
	(name_сyrillic,name_latin,standard_min,standard_max,unit)
values 
	('тест01', 'test01','10','5', 'q');

-- представление полного профиля пользователя из двух таблиц
create or replace view user_complete_profile as
select 
	u.id,
	u.first_name, 
	u.last_name, 
	u.patronymic,
	up.gender,
	up.personal_id_type,
	up.personal_id_number,
	up.personal_id_series,
	up.personal_id_picture,
	up.birth_certificat,
	up.birth_certificat_picture,
	up.insurance,
	up.birthday
from 
	users u 
join 
	user_profile up on u.id = up.user_id;

-- выбор из представления пользователя с именем Dina
select * from user_complete_profile where first_name = 'Dina';


-- представление сбора анализов пользователей за последние 10 дней
create or replace view users_analysis_last_ten_days as
select 
	u.id,
	u.first_name,
	u.last_name,
	(Year(now()) - Year(up.birthday)) as age,
	at1.name_сyrillic,
	ua.analysis_result as `result`,
	at1.standard_min as `min`,
	at1.standard_max as `max`,
	ua.alert
from user_analysis ua
join users u on ua.user_id = u.id
join user_profile up on up.user_id = ua.user_id 
join analysis_type at1 on ua.analysis_id = at1.id
where ua.record_created_date > now() - interval 10 day
order by ua.record_created_date desc;

-- воспользуемся этим view для получения данных на конкретного пользователя.
select * from users_analysis_last_ten_days where id = 1;

-- количество анализов на каждого пользователя c алертом за последние 10 дней.
select 
	u.first_name,
	u.last_name,
	(year(now()) - year(up.birthday)) as age,
	count(*) as `alerts`
from user_analysis ua
join users u on ua.user_id = u.id 
join user_profile up on ua.user_id = up.user_id 
where ua.alert = 1 and ua.record_created_date > (now() - interval 10 day )
group by ua.user_id ;

-- представление с анализами специалисту для осмотра пациента
create or replace view report_to_specialist_for_user as
select 
	u.id as u_id,
	s.id as s_id,
	concat(u.first_name," ",u.last_name) as `patient name`,
	year(now()) - year(up.birthday) as age,
	concat(s.specialist_first_name," ",s.specialist_last_name," - ",s.name_latin ) as `specialist`,
 	at1.name_latin as `analyse name`,
	ua.analysis_result as `result`,
	ua.alert as `alert`
from 
	specialist_analysis sa 
join specialist s on sa.specialist_id = s.id 
join user_analysis ua on sa.analysis_id = ua.analysis_id 
join users u on ua.user_id = u.id 
join user_profile up on ua.user_id = up.user_id 
join analysis_type at1 on at1.id = sa.analysis_id;

-- воспользуемся этим представлением для специалиста 1 для пользователя 1
select `patient name`, age,specialist,`analyse name`,`result`,`alert`
from 
	report_to_specialist_for_user 
where u_id = 1 and s_id = 1;
