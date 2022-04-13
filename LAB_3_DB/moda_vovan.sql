create database if not exists vovan_internet_shop;
use vovan_internet_shop;

-- ----------------------------------------------------------------------------------------------------------
-- drop database vovan_internet_shop;   -- НЕ НАЖИМАТЬ -- ДРОПАЕТ ВСЮ БАЗУ ДАННЫХ! (пока закомменчен)
-- ----------------------------------------------------------------------------------------------------------

create table store_employees (
id_store_employee int not null auto_increment,
`name` varchar(100) not null, 
`KPI` float not null,
`nummber_sales` int,

primary key (id_store_employee)
);

create table clients (
id_client int not null auto_increment,
`name` varchar(100) not null, 
`age` int not null,
`nummber_buys` int,
`gender` varchar(7) not null,

primary key (id_client)
);

create table value_parameters (
id_value_parameter int not null auto_increment,
`name` varchar(100) not null, 
`value` float not null,

primary key (id_value_parameter)
);

create table parameters (
id_parameter int not null auto_increment,
`color` varchar(45) not null, 
`power` float not null,
`material` varchar(45) not null,
`id_value_parameter` int not null,

primary key (id_parameter),
foreign key (id_value_parameter) references value_parameters (id_value_parameter)
);

create table delivery (
id_delivery int not null auto_increment,
`address` varchar(100) not null, 
`cost` float not null,

primary key (id_delivery)
);

create table brands (
id_brand int not null auto_increment,
`name` varchar(100) not null, 
id_client int not null,

primary key (id_brand),
foreign key (id_client) references clients (id_client)
);
-- -------------------------------------------
create table goods (
id_good int not null auto_increment,
`name` varchar(45) not null, 
id_brand int not null,
id_parameter int not null,
id_value_parameter int not null,

primary key (id_good),
foreign key (id_brand) references brands (id_brand),
foreign key (id_parameter) references parameters (id_parameter),
foreign key (id_value_parameter) references value_parameters (id_value_parameter)
);

create table feedbacks (   
id_feedback int not null auto_increment,
`content` varchar(500) not null, 
`date_time` datetime not null,
id_client int not null,
id_good int not null,

primary key (id_feedback),
foreign key (id_client) references clients (id_client),
foreign key (id_good) references goods (id_good)
);

create table stocks (
id_stock int not null auto_increment,
`condition` varchar(500) not null, 
`name` varchar(45) not null,
id_good int not null,

primary key (id_stock),
foreign key (id_good) references goods (id_good)
);

create table orders (
id_order int not null auto_increment,
`cost` float not null, 
id_client int not null,
id_delivery int not null,
id_store_employee int not null,
id_good int not null,

primary key (id_order),
foreign key (id_client) references clients (id_client),
foreign key (id_delivery) references delivery (id_delivery),
foreign key (id_store_employee) references store_employees (id_store_employee),
foreign key (id_good) references goods (id_good)
);

-- ---------------------------------------------
create table goods_to_orders (   
id_good int not null,
id_order int not null,

primary key (id_good, id_order),
foreign key (id_good) references goods (id_good),
foreign key (id_order) references orders (id_order)
);

create table parameters_to_value_parameters (   -- мода на добавление свзяи многие ко многим от параметров к значениям параметров
id_parameter int not null,
id_value_parameter int not null,

primary key (id_parameter, id_value_parameter),
foreign key (id_value_parameter) references value_parameters (id_value_parameter),
foreign key (id_parameter) references parameters (id_parameter)
);

create table goods_to_feedbacks (   
id_good int not null,
id_feedback int not null,

primary key (id_good, id_feedback),
foreign key (id_good) references goods (id_good),
foreign key (id_feedback) references feedbacks (id_feedback)
);

create table goods_to_stocks (   
id_good int not null,
id_stock int not null,

primary key (id_good, id_stock),
foreign key (id_good) references goods (id_good),
foreign key (id_stock) references stocks (id_stock)
);
-- ---------------------------------------------

alter table store_employees 
    rename column `KPI` to `efficiency`,
    rename column `nummber_sales` to `number_of_sales`;

alter table stocks
	rename sales,
    change column `condition` `condition` varchar(400) not null,
    change column `name` `name` varchar(50) not null;

alter table brands
	add column `country` varchar(45) not null,
    change column `name` `name` varchar(50) not null,
    add column `build` varchar(45) not null,  -- укажет ручная или машинная сборка
	drop foreign key brands_ibfk_1,
    drop column `id_client`;
    
alter table parameters 
	add column `age` int not null,   -- возраст пользования техникой 
    drop column `power`,
    drop column `material`,
    drop foreign key parameters_ibfk_1,
    drop column id_value_parameter;

alter table clients 
	drop column `gender`;
    
-- ------------- мода на удаление связи товаров и отзывов (т.к. уже есть связь клиета с товаров и клиента с отзывом)
-- ------------- + другие моды--------------------------------------------------------------------------------------
drop table goods_to_feedbacks;  -- убрал связь товар и отзыв 

alter table goods
	drop foreign key goods_ibfk_3,  -- удаляю связь товара и значение параметра (характеристики)
    drop column id_value_parameter;
    
alter table feedbacks
	drop foreign key feedbacks_ibfk_2,  -- удаляю свзяь отзыва и товара
    drop column id_good;
    
alter table sales
	drop foreign key sales_ibfk_1,  -- удалил лишнюю свзязь скидки с товаром (уже имеется многие ко многим)
    drop column id_good;
-- ------------------------------------------------------------------------------------------------------------------

 -- ---------- задание параметров -----------------------------------------------------------------------------------    
insert into brands value (1, 'LG', 'ручная сборка', 'Германия');
insert into clients value (2, 'Арарат', 19, 3);
insert into delivery value (3, 'ул. Хользунова 15а', 50);
insert into store_employees value (9, 'Валя', 0.89, 1293);
insert into value_parameters value (10, 'мощность', 100);
insert into parameters value (7, 'черный', 10, 18);
insert into goods value (5, 'электрический чайник', 1, 7);
insert into feedbacks value (4, 'Хороший магазин!', 20220301191722, 2);
insert into orders value (6, 319, 2, 3, 9, 5);
insert into sales value (8, 'Trade-In старого чайника', 'Великий обмен', 5);
insert into goods_to_orders value (5, 6);
insert into goods_to_stocks value (5, 8);
insert into parameters_to_value_parameters value (7, 10);