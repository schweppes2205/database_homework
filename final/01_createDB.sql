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
	personal_id_picture bigint unsigned, -- ссылка на скан документа на ftp или в облаке
	birth_certificat varchar(20) default null,
	birth_certificat_picture bigint unsigned, -- ссылка на скан документа на ftp или в облаке
	insurance bigint unsigned not null comment 'СНИЛС',
	insurance_picture bigint unsigned, -- ссылка на скан документа на ftp или в облаке
	gender char(1) not null,
	birthday date not null,
	comments text,
	record_created_date datetime default now(),
	record_update_date datetime default now() on update now(),
	
	foreign key (user_id) references users(id) on update cascade on delete restrict,
	foreign key (personal_id_picture) references pictures(id) on update cascade on delete restrict,
	foreign key (birth_certificat_picture) references pictures(id) on update cascade on delete restrict,
	foreign key (insurance_picture) references pictures(id) on update cascade on delete restrict,
	
	index pasport_idx (personal_id_series,personal_id_number),
	index birth_cert_idx (birth_certificat),
	index insurance_idx (insurance)
);

-- таблица типов анализов в самом популярном шаблоне
create table analysis_type (
	id serial primary key,
	name_сyrillic varchar(255) not null,
	name_latin varchar(255) default null,
	standard_min float(10,4) not null,
	standard_max float(10,4) not null,
	unit varchar(30) not null,
	
	index name_c_idx (name_сyrillic)
);

-- таблица данных о сданных анализах пользователей
create table user_analysis (
	id serial primary key,
	user_id bigint unsigned not null,
	analysis_id bigint unsigned not null,
	analysis_result float(10,4) not null,
	alert bit default 0 comment 'флаг внимание, если результат выходит за рамки нормы',
	analysis_picture bigint unsigned,
	record_created_date datetime default now(),
	record_update_date datetime default now() on update now(),
	
	foreign key (user_id) references users(id) on update cascade on delete restrict,
	foreign key (analysis_id) references analysis_type(id) on update cascade on delete restrict,
	foreign key (analysis_picture) references pictures(id) on update cascade on delete restrict
);

-- таблица специалистов-докторов
create table specialist (
	id serial primary key,
	name_сyrillic varchar(255),
	name_latin varchar(255),
	specialist_first_name varchar(255) not null,
	specialist_last_name varchar(255) not null,
	specialist_patronymic varchar(255) default null
);


-- таблица посещенных пользователем специалистов.
create table user_specialist (
	id serial primary key,
	user_id bigint unsigned not null,
	specialist_id bigint unsigned not null,
	report text,
	report_picture bigint unsigned,
	record_created_date datetime default now(),
	record_update_date datetime default now() on update now(),
	
	foreign key (user_id) references users(id) on update cascade on delete restrict,
	foreign key (specialist_id) references specialist(id) on update cascade on delete restrict,
	foreign key (report_picture) references pictures(id) on update cascade on delete restrict
);

-- таблица типов исследований
create table research (
	id serial primary key,
	name_сyrillic varchar(255),
	name_latin varchar(255)
);

-- таблица пройденных исследований.
create table user_research (
	id serial primary key,
	user_id bigint unsigned not null,
	research_id bigint unsigned not null,
	report text,
	report_picture bigint unsigned,
	record_created_date datetime default now(),
	record_update_date datetime default now() on update now(),
	
	foreign key (user_id) references users(id) on update cascade on delete restrict,
	foreign key (research_id) references research(id) on update cascade on delete restrict,
	foreign key (report_picture) references pictures(id) on update cascade on delete restrict
);

-- таблица анализов, которые нужны конкретному специалисту во время приема
create table specialist_analysis(
	specialist_id bigint unsigned not null,
	analysis_id bigint unsigned not null,

	foreign key (analysis_id) references analysis_type(id) on update cascade on delete restrict,
	foreign key (specialist_id) references specialist(id) on update cascade on delete restrict
);