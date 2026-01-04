use SalesDB
select * from Sales.Customers
select * from Sales.Employees
select * from Sales.Orders
select * from Sales.Products
--using sales db retrieve a list of all the orders along with the related customer,product and employee details
select
o.OrderID,
o.Sales,
c.FirstName,
c.LastName,
p.Product,
p.Price
from Sales.Orders as o
left join Sales.Customers as c
on o.OrderID=c.CustomerID
left join Sales.Products as p
on o.ProductID = p.ProductID

--combine the data of customer and the employee in one table
select
FirstName,
LastName
from Sales.Customers
union
select 
FirstName,
LastName
from Sales.Employees
--combine the data of customer and the employee in one table inclusing duplicates
select
FirstName,
LastName
from Sales.Customers
union all
select 
FirstName,
LastName
from Sales.Employees
--employee who are also customers
select
FirstName,
LastName
from Sales.Customers
intersect
select 
FirstName,
LastName
from Sales.Employees
