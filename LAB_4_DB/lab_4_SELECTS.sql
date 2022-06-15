-- -------------------------------------------------------------------- INSERT
insert into trips value (null, 20, "ул. Хользунова 4", "пр. Победы 47", 3, 35, 11, 105);
insert into trips value (null, 21, "ул. Иловая 13 ", "ул. Карпатская 7в", 1, 34, 13, 102);
insert into taxi_drivers values (null,"Octavian", 9); -- новые таксисты, которые только заступили на службу и не имеют контрактов и автомобилей
insert into taxi_drivers values (null,"TaxiMus", 13);
insert into taxi_drivers values (null, "DoEdIm_VaX", 9);
insert into taxi_drivers values (null, "Bogom_dan_Bogdan", 7);
insert into clients values (null, "79173706710", "Pupkin_007");  -- новые клиенты, не заказывающие еще поездки
insert into clients values (null, "79128246683", "ЛОСЬ_ИНОКЕНТИЙ");  
insert into reviews values (null, "2022-02-11 11:21:31", "ВСЕ КЛЕВО!",33, 40);
insert into reviews values (null, "2022-02-15 21:52:01", "Very GOOD!",33, 41);

alter  table forms_of_payment 
	rename column `id_forms-of_payment` to `id_forms_of_payment`;   -- была ошибка в названиии колонки, присутствовал неразрешенный символ
 
 -- -------------------------------------------------------------------- Функциональные требования в запросах\
 select color, brand, name, number from autos
    group by color, brand, name;           -- показать цвет машин, марку, модель и номер

select name from classes;        -- показать классы машин

select name from additional_options;        -- показать доп. опции

select name, rating from taxi_companies
	order by rating;                       -- показать оценки фирм такси
    
select nickname, driving_experience from taxi_drivers
	order by driving_experience desc;                   -- показать стаж вождения таксиста

select date_time, content, clients.nickname, taxi_companies.name from reviews
	join clients on clients.id_clients = reviews.clients_id_clients
    join taxi_companies on taxi_companies.id_taxi_companies = reviews.taxi_companies_id_taxi_companies
    where datediff(current_date(), date_time) <= 7
    order by date_time desc;                                                   -- показать отзыв о такси компании, написанный не более 7-ми дней назад
     
select group_concat(name), rating from taxi_companies
    group by rating
    order by rating desc
    limit 3;                                    -- показать топ 3 самых лучших фирм такси по рейтингу
    
select taxi_companies.name, taxi_drivers.nickname, taxi_drivers.driving_experience, autos.number, autos.color, autos.name, autos.brand from contracts
	join taxi_companies on taxi_companies.id_taxi_companies = contracts.taxi_companies_id_taxi_companies
    join taxi_drivers on taxi_drivers.id_taxi_drivers = contracts.taxi_drivers_id_taxi_drivers
    join autos on autos.id_autos = contracts.autos_id_autos
	order by driving_experience desc
    limit 5;                           -- показать топ 5 самых лучших таксистов по стажу вождения (*дополнительно где и на чем работают)
   
select taxi_companies.name, content, date_time from reviews
	join taxi_companies on taxi_companies.id_taxi_companies = reviews.taxi_companies_id_taxi_companies
    where taxi_companies.name like "Yandex"  and datediff(current_date(), date_time) <= 7
    order by date_time desc;                             -- вывести все отзывы по компании (*в примере - Yandex) за неделю

select clients.nickname, clients.telephone_number, count(trips.clients_id_clients) from trips
		join clients on clients.id_clients = trips.clients_id_clients
        where  clients.id_clients = trips.clients_id_clients 
        group by clients.nickname
        order by count(trips.clients_id_clients) desc
        limit 3;                                         -- вывести топ 3 самых активных клиентов 
        
 -- -------------------------------------------------------------------- UPDATE
update additional_options 
	set name = "еда и напитки" where name = "перевоз велосипеда";  -- в доп. опции заменить "перевоз велосипеда" на "еда и напитки"

update autos 
	set color = "пурпурный" where color = "белый";    -- в доп. опции заменить "белый" на "пурпурный"
    
update classes 
	set name = "VIP" where name = "Вип";   -- в доп. опции заменить "Вип" на "еда и VIP"

update clients 
	set nickname = "Никитос" where nickname = "Никитка";  -- в доп. опции заменить "Никитка" на "Никитос"
    
update order_methods
	set name = "SMS" where name = "смс";   -- в доп. опции заменить "смс" на "SMS"
    
 -- --------------------------------------------------------------------  DELETE FROM   
delete from  order_methods where name = "очное посещение";  -- удалить из методов заказа - "очного посещения"
delete from forms_of_payment where name = "долг";    -- удалить из способов оплаты- "долга"
delete from taxi_drivers where nickname = "Я не таксист";   -- удалить из водителей такси - "Я не таксист"
delete from clients where nickname = "***********";        -- удалить из клиентов - "***********"
delete from autos where brand = "УАЗ" and name = "Патриот";  -- удалить из машин с названем - "Патриот" и бренд - "УАЗ" 

-- --------------------------------------------------------------------  SELECT DISTINCT
select distinct color from autos;  -- отобразить цвета всех машин
select distinct nickname from clients;  -- отобразить все никнеймы клиентов1
select distinct name from taxi_companies;  -- отобразить все названия такси компаний 
select distinct number from autos;         -- отобразить номера всех машин 
select distinct name from order_methods;   -- отобразить все методы заказа поездки
select distinct name from classes;         -- отобразить все классы автомобилей 
select distinct name from additional_options;  -- отобразить все доп. опции 

-- --------------------------------------------------------------------  SELECT *FROM WHERE
select color, name, brand from autos 
	where color in ("белый", "серый");   -- отобразить все авто белого и серого цвета
    
select * from trips 
	where estimation = 5 or estimation = 4;   -- отобразить все поездки с оценками "5" или "4"
    
select *from trips 
	where departure_address = "ул. Хользунова 4" and arrival_address = "пр. Победы 47";  -- отобразить по просьбе МЧС поздки от "ул. Хользунова 4" до "пр. Победы 47"
    
select * from contracts 
	where end_date = "2022-03-23";  -- отобразить контракт, который закончился "23.03.22"
    
select telephone_number, nickname from clients 
	where telephone_number = "79021527509";  -- отобразить кдиента с номером телефона "79021527509"
    
select name from forms_of_payment
	where name not in ("наличные", "электронные деньги");  -- отобразить все типы оплаты, кроме "наличные, электронные деньги"

select * from trips 
	where estimation is not null;  -- отобразить поездки, на который была поставлена хоть какая-то оценка

-- --------------------------------------------------------------------  простые запросы с датой, без join, сложнеее имеется 7 штук в 13 пункте
  select date_time, content from reviews
    where extract(hour from date_time) between extract(hour from current_time()) and extract(hour from current_time()+1)
    order by date_time desc
    limit 3;                                              -- отобразить комментарий АНОНИМНО написанный +- в текущий час ранее 
    
select date_time, datediff(current_date(), date_time), content from reviews
    order by date_time desc;                                                   -- отобразить комментарий АНОНИМНО и кол-во дней с момента его написания    

select date_time, content from reviews
    where datediff(current_date(), date_time) > 30
    order by date_time desc;                                                   -- отобразить комментарий АНОНИМНО, написанный более 30 дней назад  
    
select contracts.taxi_drivers_id_taxi_drivers, contracts.taxi_companies_id_taxi_companies, date_format(entry_date, "%d %M %Y"), date_format(end_date, "%d %M %Y") from contracts;       -- отобразить контракты с читаемой датой (засшифрованным месяцем)

 select date_format(date_time, '%d %M %Y %r'), content from reviews
    order by date_time desc;                                               -- ообразить комментарии АНОНИМНО с читаемым форматом даты и времени

-- --------------------------------------------------------------------  SELECT *FROM WHERE BETWEEN   
select *from contracts
	where entry_date  between "2019-01-01" and "2021-12-31";  -- отобразить контракты, дата вхождения которых между датами "2019-01-01" и "2021-12-31"

select date_time, content from reviews
	where date_time between "2021-01-01 00:00:00" and "2021-12-31 23:59:59";  -- отобразить дату и время и контент отзыва, написанного между "2021-01-01 00:00:00" и "2021-12-31 23:59:59"   
    
select nickname, driving_experience from taxi_drivers 
	where driving_experience between "20" and "40";      -- отобразить никнейм, опыт вождения таксистов между 20 и 40 годами
-- --------------------------------------------------------------------  SELECT *FROM WHERE LIKE
select *from contracts 
	where entry_date like '2019%';     -- отобразить контракты, год вхождения которых 2019
    
select *from contracts 
	where end_date like '2023%';    -- отобразить контракты год окончания которых 2023 
    
select nickname, telephone_number from clients 
	where telephone_number like '7800%';  -- вывести всех клиентов кто звонит с телефона компаний (потому что номер 800 только для компаний)
    
select color, number, autos.name, brand, classes.name from autos
	join classes on classes.id_classes = autos.classes_id_classes 
	where number like 'а%3%';   -- вывести машины с номерами начинающимися на "а" и имеющими цифру "3" в номере    
    
select *from trips 
	where departure_address like '%Иловая%' or arrival_address like '%Иловая%';    -- отобразить кто ездил на улицу «Иловая»
    
select date_time, content, clients.nickname, taxi_companies.name  from reviews
	join clients on clients.id_clients = reviews.clients_id_clients
    join taxi_companies on taxi_companies.id_taxi_companies = reviews.taxi_companies_id_taxi_companies
	where content like '%водитель%';    -- отобразить отзывы, в которых  говорится про водителей 
    
select name, rating from taxi_companies
	where rating like '4%' or rating like '5';    -- отобразить название и рейтинг такси компаний с рейтингом выше четверки или равный 5

select nickname, telephone_number from clients
	where upper(nickname) like upper("D%");        -- отобразить никнеймы и телефоны клиентов, никнеймы которых начинаются на большую букву "D"
    
-- --------------------------------------------------------------------  SELECT *FROM WHERE ORDER BY
select nickname, driving_experience from taxi_drivers 
	order by driving_experience desc;     -- вывести в порядке убывания по стажу вождения никнейм, дату вождени таксистов
    
select name, rating from taxi_companies 
	order by rating asc;         -- отобразить название и рейтинг такси компании

select taxi_companies.name, taxi_drivers.nickname, taxi_drivers.driving_experience, autos.number, autos.color, autos.name, autos.brand, entry_date, end_date from contracts
	join taxi_companies on taxi_companies.id_taxi_companies = contracts.taxi_companies_id_taxi_companies
    join taxi_drivers on taxi_drivers.id_taxi_drivers = contracts.taxi_drivers_id_taxi_drivers
    join autos on autos.id_autos = contracts.autos_id_autos
	order by entry_date desc;            -- отобразить в порядке убывания имя, авто и стаж вождения контрактов по дате вхождения     

select date_time, datediff(current_date(), date_time), content, clients.nickname, taxi_companies.name from reviews
	join clients on clients.id_clients = reviews.clients_id_clients
    join taxi_companies on taxi_companies.id_taxi_companies = reviews.taxi_companies_id_taxi_companies
    order by date_time desc;                                                   -- отобразить комментарий и кол-во дней с момента его написания   

select trips.departure_address, trips.arrival_address, forms_of_payment.name, order_methods.name, clients.nickname
	from trips
	join forms_of_payment on forms_of_payment.id_forms_of_payment = trips.forms_of_payment_id_forms_of_payment
    join order_methods on order_methods.id_order_methods = trips.order_methods_id_order_methods
    join clients on clients.id_clients = trips.clients_id_clients
    order by order_methods.name;                   -- отобразить адрес назначения, адрес отбытия, тип оплаты и способ заказа поездки, никнейм и отсортировать по способу заказа

select name, rating from taxi_companies
    where rating = ALL(select MIN(rating) from taxi_companies)
    order by rating ;                                            -- вывести самую худшую по рейтингу компанию

select nickname, driving_experience from taxi_drivers
    where driving_experience = ALL(select MAX(driving_experience) from taxi_drivers)
    order by driving_experience;                                            -- вывести самого опытного таксиста по стажу вождения

-- -------------------------------------------------------------------- SELECT *FROM WHERE GROUP BY
select nickname, telephone_number from clients 
	where nickname like "D%" or nickname like "P%"
    group by nickname
    order by nickname;                    -- отобразить клиентов и их номера телефонов, никнеймы которых начинаются на "D" или "P"

select name, brand, color, count(color) from autos
	where color = "белый"
    group by color, name, brand;    -- отобразить имя, бренд, цвет машин и показать кол-во таких машин белого цвета
    
select min(date_time), content from reviews
    group by date_time
    order by date_time;   -- отобразить дату и время, контент из отзывов и отсортировать все в возрастающем порядке по дате и времени
    
select nickname, max(driving_experience) from taxi_drivers		
    group by nickname
    order by driving_experience desc
    limit 3;                         -- отобразить никнейм и дату вождения 3-х самых "опытных" водителей и расположить их в убывающем по опыту вождения порядке

select nickname, driving_experience from taxi_drivers
	group by driving_experience 
    having driving_experience > ALL(select AVG(driving_experience) from taxi_drivers)
    order by driving_experience;                                                      -- с HAVING показывает таксистов, стаж вождения, которых больше среднего стажа вождения среди таксистов

select name, rating from taxi_companies 
	where rating like "3%"
    group by name
    order by rating
    limit 5;   -- отобразить название и рейтинг такси компаний, рейтинг которых +- равен 3 и вывести 5 штук в возрастающем порядке по рейтингу 
    
select name, rating from taxi_companies 
	group by rating 
    having rating > 4;                    -- с HAVING показывает такси компании, у которых рейтинг больше "четверки"
    
select count(nickname), group_concat(nickname), driving_experience from taxi_drivers
    group by driving_experience;   
    
select group_concat(nickname), telephone_number, count(trips.clients_id_clients) from clients
	join trips on trips.clients_id_clients = clients.id_clients
    group by telephone_number;                                    -- отобразить сколько поездок какой клиент заказывал и вывести его телефонный номер                                                     

select group_concat(name), rating from taxi_companies
    group by rating
    order by rating desc
    limit 3;                                    -- отобразить топ 3 такси компании по рейтингу, если совпадают рейтинг, то записать названия через запятую
    
-- --------------------------------------------------------------------   CREATE COPY TABLES для дальнейшего inser select
create table copy_taxi_drivers like taxi_drivers;  -- создать копию таблицы такси драйверов 
create table copy_clients like clients;  -- создать копию таблички клиентов
create table copy_autos like autos;       -- создать копию таблицы авто
-- -------------------------------------------------------------------- INSERT SELECT	
insert into copy_taxi_drivers select *from taxi_drivers;    -- перенос данных из таблички таксистов в табличку копии таксистов
insert into copy_clients select *from clients;     -- перенос данных из таблички клиентов в табличку копии клиентов 
insert into copy_autos  select *from autos;      -- перенос данных из таблички авто в табличку копии авто

-- -------------------------------------------------------------------- SELECT INNER JOIN 
select taxi_companies.name, taxi_drivers.nickname, taxi_drivers.driving_experience    
	from contracts
	join taxi_companies on taxi_companies.id_taxi_companies = contracts.taxi_companies_id_taxi_companies
    join taxi_drivers on taxi_drivers.id_taxi_drivers = contracts.taxi_drivers_id_taxi_drivers;    -- просмотреть какой таксист в контракте в какой такси компании работает
	
select reviews.content, clients.nickname, taxi_companies.name
	from reviews 
    join clients on clients.id_clients = reviews.clients_id_clients
    join taxi_companies on taxi_companies.id_taxi_companies = reviews.taxi_companies_id_taxi_companies;    -- отобразить контент отзывов, никнейм автора отзыва и такси компанию, на которую адресован отзыв
 
select trips.departure_address, trips.arrival_address, forms_of_payment.name, order_methods.name
	from trips
	join forms_of_payment on forms_of_payment.id_forms_of_payment = trips.forms_of_payment_id_forms_of_payment
    join order_methods on order_methods.id_order_methods = trips.order_methods_id_order_methods;   -- отобразить адрес назначения, адрес отбытия, тип оплаты и способ заказа поездки
    
-- --------------------------------------------------------------------  RIGHT OUTER JOIN 
select clients.nickname    
	from trips
    right join clients on trips.clients_id_clients = clients.id_clients;    -- показать всех клиентов

select taxi_drivers.nickname
	from contracts
    right join taxi_drivers on taxi_drivers.id_taxi_drivers = contracts.taxi_drivers_id_taxi_drivers;   -- показать всех таксистов
    
select taxi_drivers.nickname
	from contracts
    right join taxi_drivers on taxi_drivers.id_taxi_drivers = contracts.taxi_drivers_id_taxi_drivers
    where contracts.id_contracts is null;                                                             -- показать таксистов, которые ЕЩЕ НЕ были на заказах

-- -------------------------------------------------------------------- LEFT OUTER JOIN
 select trips.estimation, clients.nickname    
	from trips
    left join clients on trips.clients_id_clients = clients.id_clients;      -- показать клиентов, которые УЖЕ заказывали хотя бы 1 поездку

select reviews.date_time, reviews.content, clients.nickname, taxi_companies.name
	from reviews
    left join clients on clients.id_clients = reviews.clients_id_clients
    left join taxi_companies on taxi_companies.id_taxi_companies = reviews.taxi_companies_id_taxi_companies;   -- показать отзыв, дату, кто оставил и на какую компанию
    
 select nickname, driving_experience, contracts.entry_date, contracts.end_date  
	from taxi_drivers
    left join contracts on contracts.taxi_drivers_id_taxi_drivers = taxi_drivers.id_taxi_drivers
    group by contracts.entry_date, contracts.end_date
    limit 10;      -- показать таксистов и их стаж, дату заключения и окончания их контракта, максимум 1- штук

-- -------------------------------------------------------------------- FULL OUTER JOIN - не поддерживается данной СУБд

-- -------------------------------------------------------------------- CROSS JOIN
select taxi_companies.name, taxi_drivers.nickname, taxi_drivers.driving_experience   
	from contracts
	cross join taxi_companies 
    cross join taxi_drivers;   -- просмотреть компании такси, никнеймы таксистов и стаж вождения
    
select reviews.content, clients.nickname, taxi_companies.name
	from reviews 
    cross join clients 
    cross join taxi_companies;  -- отобразить контент отзыва, никнейм автора и такси компании на которые он направлен
 
select trips.departure_address, trips.arrival_address, forms_of_payment.name, order_methods.name
	from trips
	cross join forms_of_payment
    cross join order_methods;   -- отобразить адрес отправления, адрес прибытия, тип оплаты  и способ заказа поездки

-- --------------------------------------------------------------------  NATURAL JOIN
select taxi_drivers.nickname, taxi_drivers.driving_experience, contracts.entry_date, contracts.end_date       
	from taxi_drivers
    natural join contracts
    where driving_experience > 10 and id_contracts is not null;   -- отобразить никнейм таксиста, опыт вождения таксиста, даты вхождения и окончания контракта, по которому он работает
    
select name, brand, name
	from autos
    natural join classes;   -- отобразить название, брэнд, класс автомобиля

select taxi_drivers.nickname-- 
	from contracts
    natural join taxi_drivers;      -- отобразить никнеймы таксистов, которые работают по контракту 

-- --------------------------------------------------------------------  UNION  -- ОСТАЛЬНЫЕ - НЕ ПОДДЕРЖИВАЕТ
select nickname from taxi_drivers   
	union 
	select nickname from clients;    -- вывести все никнеймы, которые заняты среди таксистов и клиентов 

select name from additional_options 
	union 
	select name from order_methods;    -- показывает способы заказа и  доп опции

select name, brand from autos  
	union 
	select number, color from autos;     -- вывести все цвета, номера и брэнды и названия машин

-- --------------------------------------------------------------------  вложенные запросы с SELECT
select name, rating from taxi_companies 
	where rating >= ALL (select AVG(rating) from taxi_companies);  -- показать такси компании и их рейтинг, которые имеют рейтинг выше среднего (ALL)

select date_time from reviews
	where date_time = ANY(select MAX(date_time) from reviews);     -- отобразить самый новый отзыв о такси компании
    
select nickname, driving_experience from taxi_drivers 
	group by driving_experience
	having driving_experience < (select AVG(driving_experience) from taxi_drivers);    -- показать таксистов, которые по опыту вождения - ниже среднего (GROUP BY)
    
select nickname, telephone_number from clients
	where NOT EXISTS (select clients_id_clients from trips 
    where clients.id_clients = trips.clients_id_clients);  -- показать клиентов, которые еще не заказывали
	
select nickname, driving_experience from taxi_drivers
	where EXISTS (select taxi_drivers_id_taxi_drivers from contracts
    where taxi_drivers.id_taxi_drivers = contracts.taxi_drivers_id_taxi_drivers);  -- показать подителей, котоыре состоят в контракте

-- -------------------------------------------------------------------- WITH      
with nickname_exp as 
	(select nickname, driving_experience  from taxi_drivers)
    select nickname, driving_experience from nickname_exp
    where driving_experience >= 10;                       -- отобразить никнейм и стаж вождения таксистов, стаж вождения которых больше 10
    
with phone_number_and_nick as 
	(select nickname, telephone_number from clients)
    select nickname, telephone_number  from phone_number_and_nick        
    where nickname like "p%";                                           -- отобразить никнейм, номер телефона клиентов, никнейм которых начинается на "P"
    
with feedback as 
	(select date_time, content, nickname from reviews 
    join clients on clients.id_clients = reviews.clients_id_clients)
    select date_time, content, nickname from feedback                      
    where nickname = "QuanRy";                                        -- отобразить дату и время, содержание и никнейм автора отзыва, автор которых "QunaRy" 

-- -------------------------------------------------------------------- запросы со ВРЕМЕНЕМ И ДАТОЙ
select taxi_drivers.nickname, taxi_companies.name, entry_date, end_date from contracts 
	join taxi_drivers on taxi_drivers.id_taxi_drivers = contracts.taxi_drivers_id_taxi_drivers
    join taxi_companies on taxi_companies.id_taxi_companies = contracts.taxi_companies_id_taxi_companies
	where end_date > current_date();                --                                                    -- отобразить ник, компанию, дату вхождения и окончания контракта
 
 select date_time, content, clients.nickname, taxi_companies.name from reviews
	join clients on clients.id_clients = reviews.clients_id_clients
    join taxi_companies on taxi_companies.id_taxi_companies = reviews.taxi_companies_id_taxi_companies
    where date_time < current_timestamp()
    order by date_time desc
    limit 5;                                                 -- отобразить 5 последних отзывов, написанных, до сегодняшней даты 
    
  select date_time, content, clients.nickname, taxi_companies.name from reviews
	join clients on clients.id_clients = reviews.clients_id_clients
    join taxi_companies on taxi_companies.id_taxi_companies = reviews.taxi_companies_id_taxi_companies
    where extract(hour from date_time) between extract(hour from current_time()) and extract(hour from current_time()+1)
    order by date_time desc
    limit 3;                                              -- отобразить комментарий написанный +- в текущий час ранее 
    
select date_time, datediff(current_date(), date_time), content, clients.nickname, taxi_companies.name from reviews
	join clients on clients.id_clients = reviews.clients_id_clients
    join taxi_companies on taxi_companies.id_taxi_companies = reviews.taxi_companies_id_taxi_companies
    order by date_time desc;                                                   -- отобразить комментарий и кол-во дней с момента его написания    

select date_time, content, clients.nickname, taxi_companies.name from reviews
	join clients on clients.id_clients = reviews.clients_id_clients
    join taxi_companies on taxi_companies.id_taxi_companies = reviews.taxi_companies_id_taxi_companies
    where datediff(current_date(), date_time) > 30
    order by date_time desc;                                                   -- отобразить комментарий, написанный более 30 дней назад  
    
select taxi_drivers.nickname, taxi_companies.name, date_format(entry_date, "%d %M %Y"), date_format(end_date, "%d %M %Y") from contracts 
	join taxi_drivers on taxi_drivers.id_taxi_drivers = contracts.taxi_drivers_id_taxi_drivers
    join taxi_companies on taxi_companies.id_taxi_companies = contracts.taxi_companies_id_taxi_companies;       -- отобразить контракты с читаемой датой (засшифрованным месяцем)

 select date_format(date_time, '%d %M %Y %r'), content, clients.nickname, taxi_companies.name from reviews
	join clients on clients.id_clients = reviews.clients_id_clients
    join taxi_companies on taxi_companies.id_taxi_companies = reviews.taxi_companies_id_taxi_companies
    order by date_time desc;                                                 -- отобразить отзывы в читаемом формате (указанием месяца и PM(AM) во времени)
			
-- -------------------------------------------------------------------- СЛОЖНЫЕ ЗАПРОСЫ    
select taxi_companies.name, taxi_drivers.nickname, taxi_drivers.driving_experience, autos.number, autos.color, autos.name, autos.brand, entry_date, end_date from contracts
	join taxi_companies on taxi_companies.id_taxi_companies = contracts.taxi_companies_id_taxi_companies
    join taxi_drivers on taxi_drivers.id_taxi_drivers = contracts.taxi_drivers_id_taxi_drivers
    join autos on autos.id_autos = contracts.autos_id_autos
    where contracts.end_date >= "2022-04-29"
	order by entry_date desc
    limit 10;                                 -- вывести контракты, которые еще актуальны в убывающем порядке по дате вхождения и максимум 10 штук
   
select date_time, content, clients.nickname, taxi_companies.name, taxi_companies.rating  from reviews
	join clients on clients.id_clients = reviews.clients_id_clients
    join taxi_companies on taxi_companies.id_taxi_companies = reviews.taxi_companies_id_taxi_companies
	where content like '%водитель%'
    group by date_time
    order by rating desc
    limit 3;                       -- отобразить отзывы, в которых  говорится про водителей, сгруппировать по дате и вывести в порядке убывания по рейтингу такси компаний, вывести 3 штуки    
  
select trips.departure_address, trips.arrival_address, forms_of_payment.name, order_methods.name
	from trips
	join forms_of_payment on forms_of_payment.id_forms_of_payment = trips.forms_of_payment_id_forms_of_payment
    join order_methods on order_methods.id_order_methods = trips.order_methods_id_order_methods
    where forms_of_payment.name like "наличные" and order_methods.name = "звонок"
	order by forms_of_payment.name 
    limit 5;                      -- отобразить адрес назначения, адрес отбытия, тип оплаты - "наличные" и способ заказа поездки - "звонок", вывести максимум 5 штук
    
select taxi_companies.name, taxi_drivers.nickname, taxi_drivers.driving_experience, autos.number, autos.color, autos.name, autos.brand from contracts
	join taxi_companies on taxi_companies.id_taxi_companies = contracts.taxi_companies_id_taxi_companies
    join taxi_drivers on taxi_drivers.id_taxi_drivers = contracts.taxi_drivers_id_taxi_drivers
    join autos on autos.id_autos = contracts.autos_id_autos
    where driving_experience > ALL(select avg(driving_experience) from taxi_drivers)
	order by taxi_drivers.driving_experience  desc
    limit 3;                                 -- вывести контракты, в которых стаж вождения таксистов больше среднего стажа вождения таксистов и вывести их топ 3 по стажу  
    
select taxi_companies.name, autos.number, autos.color, autos.name, autos.brand, classes.name from contracts
	join taxi_companies on taxi_companies.id_taxi_companies = contracts.taxi_companies_id_taxi_companies
    join autos on autos.id_autos = contracts.autos_id_autos
    join classes on classes.id_classes = autos.classes_id_classes
    where classes.name like "эконом"
    group by color
	order by autos.name desc
    limit 5;                                 -- вывести автомобили, такси компании, в которых они находятся, их класс, который = "эконом", вывести максимум 5 штук
    
select trips.departure_address, trips.arrival_address, forms_of_payment.name, order_methods.name, clients.nickname
	from trips
	join forms_of_payment on forms_of_payment.id_forms_of_payment = trips.forms_of_payment_id_forms_of_payment
    join order_methods on order_methods.id_order_methods = trips.order_methods_id_order_methods
    join clients on clients.id_clients = trips.clients_id_clients
    group by forms_of_payment.name
    order by order_methods.name
    limit 4;                   -- отобразить адрес назначения, адрес отбытия, тип оплаты и способ заказа поездки, никнейм и вывестимакс 4 штуки и отсортировать по способу заказа
    
-- -------------------------------------------------------------------- МОДА
select taxi_companies.name, taxi_drivers.nickname, taxi_drivers.driving_experience, autos.number, autos.color, autos.name, autos.brand, SUM(estimation)
	from trips
    join contracts on contracts.id_contracts = trips.contracts_id_contracts
    join taxi_companies on taxi_companies.id_taxi_companies = contracts.taxi_companies_id_taxi_companies
    join taxi_drivers on taxi_drivers.id_taxi_drivers = contracts.taxi_drivers_id_taxi_drivers
    join autos on autos.id_autos = contracts.autos_id_autos
 group by contracts_id_contracts
 order by sum(estimation) desc
 limit 3;                            -- показать топ 3 самых лучших таксистов за оценки по поездкам (2)
 
select taxi_companies.name, count(*) as count
	from reviews
    join taxi_companies on taxi_companies.id_taxi_companies = reviews.taxi_companies_id_taxi_companies
    where date_time between "2022-01-01" and "2022-03-30"  
    group by taxi_companies.name
    having count = (select max(count) from (select count(*) as count from reviews join taxi_companies on taxi_companies.id_taxi_companies = reviews.taxi_companies_id_taxi_companies
					group by taxi_companies.name) as Result) 
    order by count(*) desc;                                               -- отобразить топ 1 компанию по кол-ву отзывов с 01-01-22 по 30-03-22 (3)

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

