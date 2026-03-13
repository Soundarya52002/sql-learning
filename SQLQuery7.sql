--get all customers along with their orders but only for the customers who placed the order
select * from customers
inner join orders
on id = customer_id;
--get all customers along with their orders, including those without orders
select * from customers as c
left join orders as o
on c.id = o.customer_id
--get all customers along with their orders, including those without customers
select * from orders as o
right join customers as c
on o.customer_id = c.id
--get all customers and orders even with no match
select * from customers as c
full join orders as o
on c.id = o.customer_id
--get all customers who have not placed the order
select * from customers as c
left join orders as o
on c.id= o.customer_id
where o.customer_id is null
--get all orders without matching customers
select * from orders as o
right join customers as c
on o.customer_id = c.id
where c.id is null
--using sales db retrieve a list of all the orders along with the related customer,product and employee details
