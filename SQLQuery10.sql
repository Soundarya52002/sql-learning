--case when
--generate a report showing the total sales for each category:
--high is  > 50, medium if b/w 20 and 50, low if less than 20
--sort by highest to lowest
select * from Sales.Orders;
select 
    t.Category,
    sum(t.Sales) as totalsales
from (
    select 
        OrderID,
        Sales,
        case 
            when Sales > 50 then 'High'
            when Sales > 20 then 'Medium'
            else 'Low'
        end as Category
    from Sales.Orders
) t
group by t.Category
order by t.Category desc;
--count how many times each customer has made an order with > 30
select 
CustomerID,
sum(Case
when Sales > 30 then 1
else 0
end) as sum_of_cus,
count(*) as total_count
from Sales.Orders 
group by CustomerID
--total number of orders
select * from Sales.Orders
select count(*) as order_total from Sales.Orders
--total sales of all orders
select sum(Sales) as total_sales from Sales.Orders
--window function is same as aggregate but row level results
--find total sales across all the orders
select sum(Sales) from Sales.Orders
--find the total sales for each products additionally provide details such as order id order date
select 
 ProductID,
 OrderID,
 OrderDate,
 sum(sales) over(partition by ProductID) as total_sales_by_product
from Sales.Orders
--find the total sales across all orders additionally provide details such order id and order date
select
OrderID,
OrderDate,
sum(Sales) over () as total_sales
from Sales.Orders
--find the total sales for each orders additionally provide details such order id and order date
select
OrderID,
OrderDate,
sum(Sales) over (partition by ProductID) as total_sales
from Sales.Orders
--find the total sales for each combo of products and order status
select
OrderID,
OrderDate,
sum(Sales) over (partition by ProductID,OrderStatus) as total_sales
from Sales.Orders
--rank each order based on their sales from highest to lowest, additionally provide details such as order id and order date
select
OrderID,
OrderDate,
Sales,
Rank() over (order by Sales Desc) as ranking
from Sales.Orders
---window function
select * from Sales.Orders
--Step 1 :total sales per customer using cte
WITH Cte_total AS (
    SELECT 
        CustomerID,
        SUM(Sales) AS total_sales
    FROM Sales.Orders
    GROUP BY CustomerID
),
-- step 2: find the last order date per customer
Cte_last_order AS (
    SELECT 
        CustomerID,
        MAX(OrderDate) AS last_order_date
    FROM Sales.Orders
    GROUP BY CustomerID
),
--rank customer based on total sales per customer
Cte_rank as(
Select 
CustomerID,
total_sales,
rank() over(order by total_sales desc) as cutomer_rank
from Cte_total 
),
--segment customer based on total orders
Cte_seg as(
select
CustomerID,
case 
when total_sales > 100 then 'High'
when total_sales > 50 then 'Medium'
else 'Low'
end as segment_value
from Cte_total
)
-- main query
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    cts.total_sales,
    lo.last_order_date,
    s.segment_value
FROM Sales.Customers AS c
LEFT JOIN Cte_total AS cts
    ON cts.CustomerID = c.CustomerID 
LEFT JOIN Cte_last_order AS lo
    ON lo.CustomerID = c.CustomerID
LEFT JOIN Cte_rank as cr
    ON cr.CustomerID = c.CustomerID
LEFT JOIN Cte_seg as s
    ON s.CustomerID = c.CustomerID;
