-- база данных электронной медицинской карты.
-- Персональные медицинские карты на каждого пользователя для:
-- хранения анализов
-- хранения исследований
-- хранения посещения специалистов.


drop database if exists EHL; -- electronic health record
create database EHL CHARACTER SET utf8 COLLATE utf8_general_ci;
use EHL;

-- таблица всех изображений, используемых в базе (фото документов, анализов, исследований, консультаций)
create table pictures(
	id serial PRIMARY KEY,
	picture_link text
);

-- таблица пользователей ФИО.
create table users(
	id serial primary key,
	first_name varchar(255) not null,
	last_name varchar(255) not null,
	patronymic varchar(255) default null,
	
	index fst_lst_name_idx(first_name,last_name)
);

-- талица подробного профиля пользователя
create table user_profile(
	user_id serial primary KEY,
	personal_id_type enum('паспорт', 'свидетельство о рождении') not null,
	personal_id_series int unsigned default null,
	personal_id_number int unsigned  default null,
	personal_id_photo bigint unsigned, -- ссылка на скан документа на ftp или в облаке
	birth_certificat varchar(20) default null,
	birth_certificat_photo bigint unsigned, -- ссылка на скан документа на ftp или в облаке
	insurance bigint unsigned not null comment 'СНИЛС',
	insurance_photo bigint unsigned, -- ссылка на скан документа на ftp или в облаке
	gender char(1) not null,
	birthday date not null,
	comments text,
	record_created_date datetime default now(),
	record_update_date datetime default now() on update now(),
	
	foreign key (user_id) references users(id) on update cascade on delete restrict,
	foreign key (personal_id_photo) references pictures(id) on update cascade on delete restrict,
	foreign key (birth_certificat_photo) references pictures(id) on update cascade on delete restrict,
	foreign key (insurance_photo) references pictures(id) on update cascade on delete restrict,
	
	index pasport_idx (personal_id_series,personal_id_number),
	index birth_cert_idx (birth_certificat),
	index insurance_idx (insurance)
);

delimiter //
-- централизованное заведение пользователя одной процедурой.
create procedure insert_user_data (
	first_name_data varchar(255),
	last_name_data varchar(255),
	patronymic_data varchar(255),
	personal_id_type_data varchar(30),
	personal_id_series_data int unsigned,
	personal_id_number_data int unsigned,
	personal_id_photo_data bigint unsigned,
	birth_certificat_data varchar(20),
	birth_certificat_photo_data bigint unsigned,
	insurance_data bigint unsigned,
	insurance_photo_data bigint unsigned,
	gender_data char(1),
	birthday_data date,
	comments_data text)
begin
	declare exit handler for sqlexception
		begin
			get diagnostics condition 1 @sqlstate = RETURNED_SQLSTATE, 
			@errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
			set @full_error = concat("ERROR ", @errno, " (", @sqlstate, "): ", @text);
			select @full_error;
		  	rollback;
		end;
	start transaction;
	insert into users (first_name,last_name,patronymic)
				values (first_name_data,last_name_data,patronymic_data);
	set @last_id_in_table1 = last_insert_id();
	insert into user_profile (user_id,personal_id_type,personal_id_series,personal_id_number,personal_id_photo,birth_certificat,birth_certificat_photo,insurance,insurance_photo,gender,birthday,comments)
				values (@last_id_in_table1,personal_id_type_data,personal_id_series_data,personal_id_number_data,personal_id_photo_data,
						birth_certificat_data,birth_certificat_photo_data,insurance_data,insurance_photo_data,gender_data,birthday_data,comments_data);
	commit;
end//

-- проверку уникальности вносимых документов нужно вынести на уровень приложения.
-- не должно быть возможным внесение записи в базу с нулевой записью документа.
create trigger insert_user_profile_id_check before insert on user_profile
for each row 
BEGIN 
	if ((new.personal_id_type = 'паспорт' and (new.personal_id_series is null or new.personal_id_number is null)) 
		or 
		(new.personal_id_type = 'свидетельство о рождении' and new.birth_certificat is null)) THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Нельзя оставить поле выбранного документа пустым';
	end if;
END//
delimiter ;

-- procedure check
-- call insert_user_data('Василий','Pupkin',null,'паспорт',1234,123456,null,null,null,123456789,null,'m',now() - interval 30 year,'no comments'); 
-- 
-- -- trigger check
-- call insert_user_data('Василий','Pupkin',null,'паспорт',null,123456,null,null,null,123456789,null,'m',now() - interval 30 year,'no comments');

-- Типы Анализов таблица 
-- id serial
-- Название кирилица индекс руками или через приложение
-- Название латиница индекс руками или через приложение
-- Норма если есть. Min max
-- Единица измерения.
-- Создать новую таблицу автоматом, если совпадает с шаблоном "имя, norma_min, norma_max" Или создать через service request с описанием нужных полей.

-- таблица типов анализов в самом популярном шаблоне
create table analysis_type (
	id serial primary key,
	name_сyrillic varchar(255),
	name_latin varchar(255),
	standard_min float(10,4),
	standard_max float(10,4),
	unit varchar(30),
	
	index name_c_idx (name_сyrillic),
	index name_l_idx (name_latin)
);

-- Сданные анализы - таблицы на каждый вид анализа. Создаётся руками. Авооматизаровть, если есть паттерн.
-- id serial
-- User_id индекс
-- Annalise_id индекс 
-- Показатель.
-- Alert - поле, если показатель вне границ нормы. Bit
-- Фото анализа 
-- Creation date
-- Update date

-- таблица данных о сданных анализах пользователей
create table user_analysis_pass (
	id serial primary key,
	user_id bigint unsigned not null,
	analisys_id bigint unsigned not null,
	analisys_result float(10,4),
	alert bit comment 'флаг внимание, если результат выходит за рамки нормы',
	analisys_photo bigint unsigned,
	record_created_date datetime default now(),
	record_update_date datetime default now() on update now(),
	
	foreign key (user_id) references users(id) on update cascade on delete restrict,
	foreign key (analisys_id) references analysis_type(id) on update cascade on delete restrict,
	foreign key (analisys_photo) references pictures(id) on update cascade on delete restrict
);


-- 
-- Доктора. Специализация.
-- id serial.
-- Специальность кирилица index 
-- Специальность латиница index
-- 
-- Посещения докторов.
-- id serial.
-- User_id индекс
-- Doctor_id индекс
-- Creation date
-- Заключение
-- Фото заключения
-- 
-- Исследования типы
-- id serial
-- Название кирилица индекс руками или через приложение
-- Название латиница индекс руками или через приложение
-- 
-- Пройденный исследования.
-- id 
-- User_id 
-- Id исследования
-- Дата проведения 
-- Заключение
-- Фото.

-- TODO
-- + table with ID\Name + table with IDs + table with all pictures.
-- + Процедура на заполнение таблицы user + profile на входные данные.
-- результаты анализов бывают не только циферные, но и буквенные (не обнаружено, сплошь... можно ли это как-то обработать средствами БД?..)
