--view just stores the query and the meta data rather the query
--create a view that combines details from orders,products,customers and employee
Create view Sales.V_order_details as
(
select
o.OrderID,
o.OrderDate,
p.Product,
p.Price,
p.Category,
o.Sales,
o.Quantity,
c.Firstname as Name,
c.Country,
e.Department
from Sales.Orders as o
left join Sales.Products as p
on p.ProductID = o.ProductID
left join Sales.Customers as c
on c.CustomerID = o.CustomerID
left join Sales.Employees as e
on e.EmployeeID = o.SalesPersonID
)