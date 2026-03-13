select * from customers;

select first_name,country
from customers;

-- retrive cus where score is not zero
select * 
from customers
where score != 0;

-- retireve cus who is in germany
select * from customers where country='Germany';

-- retrive all the customer and sort the results by highest score first and then by lowest
select * from customers order by score DESC;
select * from customers order by score ASC;

--retrive all the customer by asc and then sort the by the highest score
select * from customers order by country ASC, score DESC;

--find the total score for each country
select country, sum(score) from customers
group by country;

-- find the total score and total number of customers for each country
select sum(score) as total_score, count(id) as total_customers
from customers
group by country;

/*find the average score for each country considering customers with score not equal
to 0 and return only those country with an average
score greater than 430
*/
select avg(score) as avg_score, 
                       country
from customers
where score != 0
group by country
having sum(score)>430;