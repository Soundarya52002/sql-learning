create table person(
id int not null,
person_name varchar(50) not null,
date_of_birth date,
phone varchar(15) not null,
constraint pk_person PRIMARY KEY(id)
)

--ad the column email in the table
alter table person
add gmail varchar(20) not null

select * from person
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'person';

--remove the column phone
alter table person
drop column phone;

--inserting new values
insert into customers(id,first_name,country,score)
values (6,'Anna','Germany',87)

select * from customers