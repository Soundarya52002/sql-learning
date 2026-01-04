--
use SalesDB
select 
CustomerID,
FirstName + Coalesce(LastName,'') as name,
Coalesce(Score,0) + 10 as score_add_10
from Sales.Customers;
--sort the customers score from highest to lowest with null appearing in the last
select * from Sales.Customers;
select 
CustomerID,
FirstName,
Score
from Sales.Customers
order by Score Desc ;
--sort the customers score from lowest to highest with null appearing in the last
select 
CustomerID,
FirstName,
Score
from Sales.Customers
order by 
    case when Score is null then 1 else 0 end,
    Score
--null if checks two values, if equal then null else chose first value
--find the sales price for each order  by dividing the sales by quantity
select
OrderID as order_id,
Sales as Sales,
Quantity as quantity,
Sales/nullif(Quantity,0) as sales_price
from Sales.Orders
--is null returns true if it has null and is not null returns true if it has no null
--identify the customers who has no scores
use SalesDB
select * from Sales.Customers
select 
FirstName,
Country,
Score
from Sales.Customers 
where Score is null;
select 
FirstName,
Country,
Score
from Sales.Customers 
where Score is not null;
-- is null is also used in the left anti join
--list all ccustomers who have not placed any orders
select
c.*,
o.OrderID
from Sales.Customers as c
left join Sales.Orders as o
on c.CustomerID = o.CustomerID
where o.CustomerID is null;