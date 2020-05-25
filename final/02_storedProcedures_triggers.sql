use EHL;
delimiter //
-- централизованное заведение пользователя одной процедурой.
drop procedure if exists insert_user_data //
create procedure insert_user_data (
	first_name_data varchar(255),
	last_name_data varchar(255),
	patronymic_data varchar(255),
	personal_id_type_data varchar(30),
	personal_id_series_data int unsigned,
	personal_id_number_data int unsigned,
	personal_id_picture_data bigint unsigned,
	birth_certificat_data varchar(20),
	birth_certificat_picture_data bigint unsigned,
	insurance_data bigint unsigned,
	insurance_picture_data bigint unsigned,
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
	insert into user_profile (user_id,personal_id_type,personal_id_series,personal_id_number,personal_id_picture,birth_certificat,birth_certificat_picture,insurance,insurance_picture,gender,birthday,comments)
				values (@last_id_in_table1,personal_id_type_data,personal_id_series_data,personal_id_number_data,personal_id_picture_data,
						birth_certificat_data,birth_certificat_picture_data,insurance_data,insurance_picture_data,gender_data,birthday_data,comments_data);
	commit;
end//

-- не должно быть возможным внесение записи в базу с нулевой записью выбранного документа. для проверки выполнения этого условия создан триггер.
drop trigger if exists insert_user_profile_id_check//
create trigger insert_user_profile_id_check before insert on user_profile
for each row 
BEGIN 
	if ((new.personal_id_type = 'паспорт' and (new.personal_id_series is null or new.personal_id_number is null)) 
		or 
		(new.personal_id_type = 'свидетельство о рождении' and new.birth_certificat is null)) THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Нельзя оставить поле выбранного документа пустым';
	end if;
END//

-- обновление записи alert, сообщающей о том, что на результат анализа нужно обратить внимание.
-- флаг поднят, если результат ниже или выше границ нормы.
drop trigger if exists insert_user_analysis_alert_calculate//
create trigger insert_user_analysis_alert_calculate before insert on user_analysis
for each row 
BEGIN 
	if (new.analysis_result > (select standard_max from analysis_type at1 where at1.id = new.analysis_id)
		or
		new.analysis_result < (select standard_min from analysis_type at1 where at1.id = new.analysis_id)) THEN 
		set new.alert = 1;
	end if;
END//

-- проверка, что при внесении в список анализов значение минимального порога меньше максимального
drop trigger if exists insert_analysis_type_check//
create trigger insert_analysis_type_check before insert on analysis_type
for each row 
BEGIN 
	if (new.standard_min > new.standard_max) THEN 
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Минимальное значение порога не должно быть больше максимального';
	end if;
END//

delimiter ;
