-- Написать крипт, добавляющий в БД vk, которую создали на занятии, 3 новые таблицы (с перечнем полей, указанием индексов и внешних ключей)
-- таблица news - новости, которые может публиковать пользователь. может вставлять туда медиа.
DROP TABLE IF EXISTS news;
CREATE TABLE news (
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL,
	content text,
	
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (media_id) references media(id)
);

-- таблица items - магазин услуг.

drop table if exists items;
create table items(
	id serial primary key,
	content text,

	FOREIGN KEY (user_id) REFERENCES users(id)
);

-- таблица users_items - связь М х М элементов каталога и пользователей.

drop table if exists users_items;
create table users_items(
	user_id bigint unsigned not null,
	item_id bigint unsigned not null,
	
	primary key (user_id, item_id),
	foreign key (user_id) references users(id),
	foreign key (item_id) references items(id)
);

-- таблица permissions - доступ к публикациями 

drop table if exists permissions;
create table permissions(
	owner bigint unsigned not null,
	news_permitted_user_id bigint unsigned,
	news_id bigint unsigned,
	items_permitted_user_id bigint unsigned,
	items_id bigint unsigned,
	
	foreign key (owner) references users(id),
	foreign key (news_permitted_user_id) references users(id),
	foreign key (items_permitted_user_id) references users(id),
	foreign key (news_id) references news(id),
	foreign key (items_id) references items(id)
);
