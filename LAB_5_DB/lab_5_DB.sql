-- delete from taxi_companies where id_taxi_companies >=100;   -- 	ДЛЯ ВНЕСЕНИЯ КОРРЕКТИВ В ДАННЫЕ

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\autos.csv' INTO TABLE autos -- добавить 10к записей в авто
	FIELDS TERMINATED BY ','
    ENCLOSED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES
    (id_autos, color, number, name, brand, classes_id_classes);
		SELECT * FROM autos;
    
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\additional_opt.csv' INTO TABLE additional_options -- добавить 10к записей в доп. опции
	FIELDS TERMINATED BY ','
    ENCLOSED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES
    (id_additional_options, name);
		SELECT * FROM additional_options;
        
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\classes.csv' INTO TABLE classes -- добавить 10к записей в классы
	FIELDS TERMINATED BY ','
    ENCLOSED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES
    (id_classes, name);
		SELECT * FROM classes;
        
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\forms_of_payment.csv' INTO TABLE forms_of_payment -- добавить 10к записей в формы оплаты
	FIELDS TERMINATED BY ','
    ENCLOSED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES
    (id_forms_of_payment, name);
		SELECT * FROM forms_of_payment;
        
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\clients.csv' INTO TABLE clients -- добавить 10к записей в клиентов
	FIELDS TERMINATED BY ','
    ENCLOSED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES
    (id_clients, telephone_number, nickname);
		SELECT * FROM clients;
        
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\order_methods.csv' INTO TABLE order_methods -- добавить 10к записей в способ заказа
	FIELDS TERMINATED BY ','
    ENCLOSED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES
    (id_order_methods, name);
		SELECT * FROM order_methods;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\taxi_drivers.csv' INTO TABLE taxi_drivers -- добавить 10к записей в таксистов
	FIELDS TERMINATED BY ','
    ENCLOSED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES
    (id_taxi_drivers, nickname, driving_experience);
		SELECT * FROM taxi_drivers;
        
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\taxi_companies.csv' INTO TABLE taxi_companies -- добавить 10к записей в такси компании
	FIELDS TERMINATED BY ','
    ENCLOSED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES
    (id_taxi_companies, name, rating);
		SELECT * FROM taxi_companies;
        
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\reviews.csv' INTO TABLE reviews -- добавить 10к записей в отзывы
	FIELDS TERMINATED BY ','
    ENCLOSED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES
    (id_reviews, date_time, content, clients_id_clients, taxi_companies_id_taxi_companies);
		SELECT * FROM reviews;
        
LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\contracts.csv' INTO TABLE contracts -- добавить 10к записей в контракты
	FIELDS TERMINATED BY ','
    ENCLOSED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES
    (id_contracts, taxi_companies_id_taxi_companies, autos_id_autos, taxi_drivers_id_taxi_drivers, entry_date, end_date);
		SELECT * FROM contracts;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\trips.csv' INTO TABLE trips -- добавить 10к записей в поездки
	FIELDS TERMINATED BY ','
    ENCLOSED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES
    (id_trips, forms_of_payment_id_forms_of_payment, departure_address, arrival_address, estimation, clients_id_clients, order_methods_id_order_methods, contracts_id_contracts);
		SELECT * FROM trips;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\addit_to_trips.csv' INTO TABLE additional_options_has_trips -- добавить 10к записей в связь доп. опции и поездки
	FIELDS TERMINATED BY ','
    ENCLOSED BY ','
    LINES TERMINATED BY '\r\n'
    IGNORE 1 LINES
    (additional_options_id_additional_options, trips_id_trips);
		SELECT * FROM additional_options_has_trips;
        
-- ---------------------------------------------------------------------------- ИНДЕКСЫ ----------------------------------------------------------------------------------------------
 -- drop index idx_contracts_end_date on contracts ;

-- создадим индекс по цвету, т.к. поиск осуществляется по нему
create index idx_color_autos on autos (color);
	select color, name, brand from autos 
		where color in ("белый", "серый");   -- отобразить все авто белого и серого цвета

-- создадим УНИКАЛЬНЫЙ индекс по номеру телефона, т.к. он не повторяется
create unique index idx_phone_number_clients on clients (telephone_number);
	select telephone_number, nickname from clients 
		where telephone_number = "79021527509";  -- отобразить кдиента с номером телефона "79021527509"

-- создадим индекс по никнейму в таблице клиент, потому что именно вней перебираются все никнеймы
create index idx_clients_nickname on clients (nickname);
	select trips.departure_address, trips.arrival_address, forms_of_payment.name as forms_of_payment, order_methods.name as order_methods, 
	clients.nickname, estimation, taxi_companies.name as taxi_companies, taxi_drivers.nickname as taxi_drivers, autos.number, autos.color, autos.name as autos_name, autos.brand
		from trips
		join forms_of_payment on forms_of_payment.id_forms_of_payment = trips.forms_of_payment_id_forms_of_payment
		join order_methods on order_methods.id_order_methods = trips.order_methods_id_order_methods
		join clients on clients.id_clients = trips.clients_id_clients
		join contracts on contracts.id_contracts = trips.contracts_id_contracts
		join taxi_companies on taxi_companies.id_taxi_companies = contracts.taxi_companies_id_taxi_companies
		join taxi_drivers on taxi_drivers.id_taxi_drivers = contracts.taxi_drivers_id_taxi_drivers
		join autos on autos.id_autos = contracts.autos_id_autos
    
		where clients.nickname = "QuanRy";             --  вывести всю информацию о поздке для клиента QuanRy (1)

-- создадим индекс по названиям классов, т.к. по ним идет проверка 
create index idx_classes on classes (name);
	select taxi_companies.name, autos.number, autos.color, autos.name, autos.brand, classes.name from contracts
		join taxi_companies on taxi_companies.id_taxi_companies = contracts.taxi_companies_id_taxi_companies
		join autos on autos.id_autos = contracts.autos_id_autos
		join classes on classes.id_classes = autos.classes_id_classes
		where classes.name = "эконом"
		group by color
		order by autos.name desc
		limit 5;                                 -- вывести автомобили, такси компании, в которых они находятся, их класс, который = "эконом", вывести максимум 5 штук
 
 -- создадим индекс по типу оплаты, т.к. поиск осуществляется по нему 
create index idx_forms_of_payment on forms_of_payment (name);
	select trips.departure_address, trips.arrival_address, forms_of_payment.name, order_methods.name
		from trips
		join forms_of_payment on forms_of_payment.id_forms_of_payment = trips.forms_of_payment_id_forms_of_payment
		join order_methods on order_methods.id_order_methods = trips.order_methods_id_order_methods
		where forms_of_payment.name = "наличные" 
		order by forms_of_payment.name 
		limit 5;                      -- отобразить адрес назначения, адрес отбытия, тип оплаты - "наличные"  вывести максимум 5 штук

-- ---------------------------------------------------------------------------- ПРОЦЕДУРЫ ----------------------------------------------------------------------------------------------
-- drop procedure pr_auto_white;  -- удаление процедуры

-- процедура без параметров (возвращающая марку, название, цвет, номер авто белого цвета)
DELIMITER $$
CREATE PROCEDURE pr_auto_white()
BEGIN
    select name, brand, color, number from autos 
    where color = "белый";
END $$
DELIMITER ;
	CALL pr_auto_white; -- вызов процедуры для отображения белых авто

-- процедура с одним входным параметром - IN (возвращающая никнейм и стаж вождения таксиста, у которого стаж больше входного значения)
DELIMITER $$
CREATE PROCEDURE pr_driving_exp_more (in in_driving_experience int)
BEGIN
	SELECT nickname, driving_experience FROM taxi_drivers
	WHERE driving_experience  > in_driving_experience
    ORDER BY driving_experience  ASC;
END $$
DELIMITER ;
	CALL pr_driving_exp_more (30);  -- вызов процедуры для отображения более опытных таксистов по стажу входному


-- процедура с одним входным параметром - IN (возвращающая никнейм и стаж вождения таксиста, если введен не "клиент", если наоборот, то вывести никнейм и телефон клиента)
DELIMITER $$
CREATE PROCEDURE pr_client_or_driver (in in_name  varchar(45))
BEGIN
IF (in_name = "клиент") THEN
	SELECT nickname, telephone_number FROM clients;
ELSE
	SELECT nickname, driving_experience FROM taxi_drivers;
END IF;
END $$
DELIMITER ;
	CALL pr_client_or_driver ("кл");  -- вызов процедуры для отображения клиентов или таксистов
    
-- процедура с одним входным параметром - IN и join (возвращает информацию о контракте, стаж вождения водителя которого равен введенному)
DELIMITER $$
CREATE PROCEDURE pr_driv_exp_ (in in_driv_exp int)
BEGIN
	select taxi_companies.name as taxi_company, taxi_drivers.nickname, taxi_drivers.driving_experience, autos.number, autos.color, autos.name, autos.brand, entry_date, end_date from contracts
	join taxi_companies on taxi_companies.id_taxi_companies = contracts.taxi_companies_id_taxi_companies
    join taxi_drivers on taxi_drivers.id_taxi_drivers = contracts.taxi_drivers_id_taxi_drivers
    join autos on autos.id_autos = contracts.autos_id_autos
    where in_driv_exp = taxi_drivers.driving_experience
	order by taxi_drivers.driving_experience desc;
END $$
DELIMITER ;
	CALL pr_driv_exp_ (30);  -- вызов процедуры для отображения контрактов, с таким же стажом вождения    
    
-- ---------------------------------------------------------------------------- ФУНКЦИИ----------------------------------------------------------------------------------------------   
-- функция для вывода или кол-ва таксистов, у которых стаж в рамках допустимого значения [2;82] и равен введенному
delimiter $$
create function func_driv_exp (in_driv_exp  int)
returns int
deterministic
begin
	declare s int default 0;
    
    if (in_driv_exp  >= 2 and in_driv_exp  <= 82) then 
		SELECT count(id_taxi_drivers) FROM taxi_drivers
		WHERE driving_experience  = in_driv_exp into s;
    end if;
    return s;
    
end $$
delimiter ;
	select func_driv_exp (81);  -- вызов функции для вывода кол-ва таксистов с таким стажем

-- drop function func_driv_exp; -- для удаления функций

-- Функция для вывода максимального стажа вождения в введенной такси компании
delimiter $$
create function func_max_dr_exp (in_taxi_comp varchar(100))
returns int
deterministic
begin
	declare s int default 0;
	
    select max(taxi_drivers.driving_experience) from contracts
	join taxi_drivers on contracts.taxi_drivers_id_taxi_drivers = taxi_drivers.id_taxi_drivers
    join taxi_companies on taxi_companies.id_taxi_companies = contracts.taxi_companies_id_taxi_companies
    where taxi_companies.name = in_taxi_comp into s;
    
    return s;
end $$
delimiter ;
	select  func_max_dr_exp('Yandex'); -- вызов функции для нахождения максимального стажа в такси компании

-- функция для вывода позиции в рейтинге среди такси компаний
delimiter $$
create function func_rat_pos (in_taxi_rat  int)
returns int
deterministic
begin
	declare s int default 0;
    
    if (in_taxi_rat > 1 and in_taxi_rat <= 5 ) then 
		SELECT count(id_taxi_companies) FROM taxi_companies
		WHERE rating >= in_taxi_rat into s;
    end if;
    return s;
    
end $$
delimiter ;
	select func_rat_pos (4.1);  -- вызов функции для вывода позиции  такси компании в рейтинге

-- ---------------------------------------------------------------------------- ПРЕДСТАВЛЕНИЯ---------------------------------------------------------------------------------------------- 
-- представление для вывода топ 3 таксиста по сумме отзывов за поездки
create view top_3_drivers
as
	select taxi_companies.name as taxi_company, taxi_drivers.nickname as taxi_driver, taxi_drivers.driving_experience, autos.number as auto_number, autos.color, autos.name as auto_name, autos.brand as auto_brand, SUM(estimation)
		from trips
		join contracts on contracts.id_contracts = trips.contracts_id_contracts
		join taxi_companies on taxi_companies.id_taxi_companies = contracts.taxi_companies_id_taxi_companies
		join taxi_drivers on taxi_drivers.id_taxi_drivers = contracts.taxi_drivers_id_taxi_drivers
		join autos on autos.id_autos = contracts.autos_id_autos
		group by contracts_id_contracts
		order by sum(estimation) desc
		limit 3;                            -- показать топ 3 самых лучших таксистов за оценки по поездкам 
select * from top_3_drivers;  -- вызов представления

-- представление о отзывах, в которых говорится про водителей
create view review_about_driver
as
	select date_time, content, clients.nickname, taxi_companies.name, taxi_companies.rating  from reviews
		join clients on clients.id_clients = reviews.clients_id_clients
		join taxi_companies on taxi_companies.id_taxi_companies = reviews.taxi_companies_id_taxi_companies
		where content like '%водитель%'
		group by date_time
		order by rating desc
		limit 3;                       -- отобразить отзывы, в которых  говорится про водителей, сгруппировать по дате и вывести в порядке убывания по рейтингу такси компаний, вывести 3 штуки  
select * from review_about_driver;  -- вызов представления

-- представление о топ 10-ти контрактах по дате вхождения (самых новеньких)
create view top_10_new_contr
as
	select taxi_companies.name as taxi_company, taxi_drivers.nickname as taxi_driver, taxi_drivers.driving_experience as driving_experience, autos.number, autos.color, autos.name, autos.brand, entry_date, end_date from contracts
		join taxi_companies on taxi_companies.id_taxi_companies = contracts.taxi_companies_id_taxi_companies
		join taxi_drivers on taxi_drivers.id_taxi_drivers = contracts.taxi_drivers_id_taxi_drivers
		join autos on autos.id_autos = contracts.autos_id_autos
		where contracts.end_date >= "2022-04-29"
		order by entry_date desc
		limit 10;                                 -- вывести контракты, которые еще актуальны в убывающем порядке по дате вхождения и максимум 10 штук
select * from top_10_new_contr;  -- вызов представления

-- ---------------------------------------------------------------------------- ТРИГГЕРЫ----------------------------------------------------------------------------------------------  
-- триггер для замены букв номера автомобиля в нижнем регистре. на буквы в верхнем регистре
Delimiter $$
create trigger auto_number
before insert on autos
for each row
begin
	SET new.number = concat ( upper(left (new.number, 7 ) ), lower (substring(new.number, 7) ) );
end $$
delimiter ;

-- drop trigger auto_number;  -- дропнуть триггер

-- добавляем номер с буквами в нижнем регистре
insert into autos values (null, 'зеленый', 'h274hр', 'SHUMA_III', 'KIA', '73');

-- выолняем проверку и получаем номер с верхним регистром:
select * from autos where name = 'SHUMA_III';
      
-- ---------------------------------------------------------------------------- МОДА ---------------------------------------------------------------------------------------------- 
-- ИНДЕКС -- 
update trips set trips.arrival_address = "Darwin" where clients_id_clients = 2250;
select * from clients where nickname = "Ana";  -- 3302, 7761 (2)  2250 (3)

-- создадим индекс по никнейму в таблице клиент, затем создадим индекс по улицам прибытия и отбытия и оценке поездки в поездках, потому что выборка происходит именно по этим полям
create index idx_clients_nickname on clients (nickname);
create index idx_trips_address on trips (departure_address, arrival_address, estimation);
	select trips.departure_address, trips.arrival_address, forms_of_payment.name as forms_of_payment, order_methods.name as order_methods, 
	clients.nickname, estimation, taxi_companies.name as taxi_companies, taxi_drivers.nickname as taxi_drivers, autos.number, autos.color, autos.name as autos_name, autos.brand
		from trips
		join forms_of_payment on forms_of_payment.id_forms_of_payment = trips.forms_of_payment_id_forms_of_payment
		join order_methods on order_methods.id_order_methods = trips.order_methods_id_order_methods
		join clients on clients.id_clients = trips.clients_id_clients
		join contracts on contracts.id_contracts = trips.contracts_id_contracts
		join taxi_companies on taxi_companies.id_taxi_companies = contracts.taxi_companies_id_taxi_companies
		join taxi_drivers on taxi_drivers.id_taxi_drivers = contracts.taxi_drivers_id_taxi_drivers
		join autos on autos.id_autos = contracts.autos_id_autos
    
		where clients.nickname = "Ana" and (trips.departure_address or trips.arrival_address = "Darwin") and trips.estimation >= 4;    --  вывести всю информацию о поздке для клиента Ana, по улице "Darwin" с оценкой больше или равной 4


-- ПРОЦЕДУРА --
-- процедура с одним входным параметром - IN (id_driver) и двумя выходными OUT (кол-во поездок (num_trips) и  средняя оценка за поездки (avg_estimation)) 
DELIMITER $$
CREATE PROCEDURE info_driver_trips (in id_driver int, out num_trips int, out avg_estimation float)
BEGIN
	select taxi_drivers.nickname as taxi_driver, AVG(estimation), count(id_trips) as num_trips from trips         
		join contracts on contracts.id_contracts = trips.contracts_id_contracts
		join taxi_drivers on taxi_drivers.id_taxi_drivers = contracts.taxi_drivers_id_taxi_drivers
        where taxi_drivers.id_taxi_drivers = id_driver
		group by taxi_drivers.nickname 
		order by num_trips desc;            -- вывести таксиста, средний рейтинг по оценкам за поездки и кол-во поездок 
        
        select (select AVG(estimation) from trips 
			join contracts on contracts.id_contracts = trips.contracts_id_contracts
			join taxi_drivers on taxi_drivers.id_taxi_drivers = contracts.taxi_drivers_id_taxi_drivers
			where taxi_drivers.id_taxi_drivers = id_driver) into avg_estimation;
            
        select (select count(id_trips) from trips         
			join contracts on contracts.id_contracts = trips.contracts_id_contracts
			join taxi_drivers on taxi_drivers.id_taxi_drivers = contracts.taxi_drivers_id_taxi_drivers
			where taxi_drivers.id_taxi_drivers = id_driver) into num_trips;
 END $$
DELIMITER ;
	CALL info_driver_trips (4116,  @num_trips, @avg_estimation);  -- вызов процедуры для отображения более опытных таксистов по стажу входному
    select @avg_estimation;
    select @num_trips;
    
-- drop procedure info_driver_trips;


-- ТРИГГЕР -- 
-- триггер для добавление доп. опции "Wi-Fi" при заказе поездки через приложение
Delimiter $$
create trigger add_opt_for_mob_app
before insert on additional_options_has_trips
for each row
begin
	if ((select order_methods_id_order_methods from trips where new.trips_id_trips = id_trips) = 12) then   -- если метод заказа "приложение"
			set new.additional_options_id_additional_options = 5;           -- доп. опция - Wi-Fi
    end if;
end $$
delimiter ;

drop trigger add_opt_for_mob_app;  -- дропнуть триггер

insert into additional_options_has_trips values (1, 102);    -- добавить значение

select trips.departure_address, trips.arrival_address, forms_of_payment.name as forms_of_payment, order_methods.name as order_methods, 
	clients.nickname, estimation, taxi_companies.name as taxi_companies, taxi_drivers.nickname as taxi_drivers, autos.number, autos.color,
    autos.name as autos_name, autos.brand, group_concat(additional_options.name separator ", ") as additional_options
		from trips
		join forms_of_payment on forms_of_payment.id_forms_of_payment = trips.forms_of_payment_id_forms_of_payment
		join order_methods on order_methods.id_order_methods = trips.order_methods_id_order_methods
		join clients on clients.id_clients = trips.clients_id_clients
		join contracts on contracts.id_contracts = trips.contracts_id_contracts
		join taxi_companies on taxi_companies.id_taxi_companies = contracts.taxi_companies_id_taxi_companies
		join taxi_drivers on taxi_drivers.id_taxi_drivers = contracts.taxi_drivers_id_taxi_drivers
		join autos on autos.id_autos = contracts.autos_id_autos
        join additional_options_has_trips on additional_options_has_trips.trips_id_trips = trips.id_trips
        join additional_options on additional_options.id_additional_options = additional_options_has_trips.additional_options_id_additional_options
        where trips.id_trips = 102
        group by trips.id_trips;                 -- вывести всю информацию о поездке и вывести через запятую все доп. оцпии этой поездки (поездка с id 90)
        
    

