insert into person(id,person_name,date_of_birth,phone,gmail)
select
id,
first_name,
null,
'Unknown',
'Unknown'
from customers
select * from person
insert into customers(id,first_name,country,score)
values (7,'Sam',Null,100),
(8,'USA','Max',Null),
(9,'Andreas','Germany',Null),
(10,'Sarah',Null,Null)
--change the score of the customer with id 10 and update the country to UK
select * from customers
update customers
set score = 0,country = 'UK'
where id = 10

--update all customers score with 0 whose value is null
update customers
set score = 0
where score is Null

--delete all customers where id is greater than 5
delete from customers
where id > 5

--retrieve all the customers from germany
select * from customers
where country = 'Germany'

--not from germany
select * from customers
where country != 'Germany'

--score greater than 500
select * from customers
where score > 500

--score 500 or more
select * from customers
where score >=500

--less than 500
select * from customers
where score < 500
--less than 500 or less
select * from customers
where score <= 500
--retreice all customers from usa and score greater than 500
select * from customers
where country = 'USA' and score > 500
--either coutntry usa or score greater than 500
select * from customers
where country = 'USA' or score > 500
--score not less than 500
select * from customers
where not score < 500
--score falls between range of 100 to 500
select * from customers
where score between 100 and 500
--cusotmers in germany and usa
select * from customers
where country in ('Germany','USA')
--first name starts with m
select * from customers
where first_name like 'M%'
--first name ends with n
select * from customers
where first_name like '%n'
--contains r
select * from customers
where first_name like '%r%'
--contains r in third pos
select * from customers
where first_name like '__r%'
