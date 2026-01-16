--SUB QUERY 
--query within another query
--find the products that have a price higher than the average price of all products
-- find the products that have a price higher than the average price of all products
SELECT 
    t.ProductID,
    t.Product
FROM (
    SELECT
        ProductID,
        Product,
        Price,
        AVG(Price) OVER () AS average_price
    FROM Sales.Products
) AS t
WHERE t.Price > t.average_price;
--rank the customers based on the total amount of sales
select 
*,
rank() over(Order by t.total_sales desc) as rank_of_the_customers
from
(
select
CustomerID,
sum(Sales) as total_sales
from Sales.Orders
group by CustomerID
)as t
--sub queries in select NOTE: the result must be in scalar i.e.one row and one col
--show the productid, name,prices and total number of orders
select 
ProductID,
Product,
Price,
--subquery
(select
count(*)
from Sales.Orders) as total_order
From Sales.Products
--in operator
--show the details of the orders made by the customers in germany
use SalesDB
select * from Sales.Orders
where CustomerID IN (
                    select CustomerID from Sales.Customers
                    where Country ='Germany')
--show the details of the orders made by the customers  not in germany
select * from Sales.Orders
where CustomerID  NOT IN (
                    select CustomerID from Sales.Customers
                    where Country ='Germany')
--ANY operator will chose atleast one value is true
--find the females employees whose salaries are greater than the male employee
select
EmployeeID,
FirstName,
Salary
from Sales.Employees
where Gender = 'F'
and Salary > any(select
                    Salary
                    from Sales.Employees
                    where Gender = 'M')
--all query should satisy all the values
select
EmployeeID,
FirstName,
Salary
from Sales.Employees
where Gender = 'F'
and Salary > all(select

                    Salary
                    from Sales.Employees
                    where Gender = 'M')
--correlated subqueries means sub query is dependent on the main query
select 
*,
(select count(*) from Sales.Orders as o where o.CustomerID = c.CustomerID) 
from Sales.Customers as c 
--exits returns the same row present in another table
--show the details of the orders made by the customers in germany
select * 
from Sales.Orders as o
where exists(
            select 1
            from Sales.Customers as c
            where Country = 'Germany'
            and o.CustomerID=c.CustomerID)
