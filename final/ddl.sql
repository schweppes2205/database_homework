-- база данных электронной медицинской карты.
-- Персональные медицинские карты на каждого пользователя для:
-- хранения анализов
-- хранения исследований
-- хранения посещения специалистов.


drop database if exists EHL; -- electronic health record
create database EHL CHARACTER SET utf8 COLLATE utf8_general_ci;
use EHL;

create table user_profile(
	id serial primary key,
	personal_id_type enum('паспорт', 'свидетельство о рождении') not null,
	personal_id_series int unsigned default null,
	personal_id_number int unsigned  default null,
	personal_id_photo varchar(255), -- ссылка на скан документа на ftp или в облаке
	birth_certificat varchar(20) default null,
	birth_certificat_photo varchar(255), -- ссылка на скан документа на ftp или в облаке
	insurance bigint unsigned not null comment 'СНИЛС',
	insurance_photo varchar(255), -- ссылка на скан документа на ftp или в облаке
	first_name varchar(255) not null,
	last_name varchar(255) not null,
	patronymic varchar(255) default null,
	gender char(1) not null,
	birthday date not null,
	comments text,
	record_created_date datetime default now(),
	record_update_date datetime default now() on update now(),
	
	index fst_lst_name_idx(first_name,last_name),
	index pasport_idx (personal_id_series,personal_id_number),
	index birth_cert_idx (birth_certificat),
	index insurance_idx (insurance)
	
);
-- проверку уникальности вносимых документов нужно вынести на уровень приложения.
-- не должно быть возможным внесение записи в базу с нулевой записью документа.
delimiter //
create trigger user_profile_id_check before insert on user_profile
for each row 
BEGIN 
	if ((new.personal_id_type = 'паспорт' and (new.personal_id_series is null or new.personal_id_number is null)) 
		or 
		(new.personal_id_type = 'свидетельство о рождении' and new.birth_certificat is null)) THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No possibility for name and description to be NULL simultaneously';
	end if;
END//
delimiter ;

-- типы анализов
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

-- Типы Анализов таблица 
-- id serial
-- Название кирилица индекс руками или через приложение
-- Название латиница индекс руками или через приложение
-- Норма если есть. Min max
-- Единица измерения.
-- Создать новую таблицу автоматом, если совпадает с шаблоном "имя, norma_min, norma_max" Или создать через service request с описанием нужных полей.
-- 
-- Сданные анализы - таблицы на каждый вид анализа. Создаётся руками. Авооматизаровть, если есть паттерн.
-- id serial
-- User_id индекс
-- Annalise_id индекс 
-- Показатель.
-- Alert - поле, если показатель вне границ нормы. Bit
-- Фото анализа 
-- Creation date
-- Update date
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
