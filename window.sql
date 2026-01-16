--window functions
--group by but with so many details for each row
--find the total sales across all order
use SalesDB
select 
sum(Sales) as total_sales
from Sales.Orders
--total sales for each product
select
ProductID,
sum(Sales) as total_sales
from Sales.Orders
group by ProductID
--total sales for each product with orderid,productid
select 
OrderID,
ProductID,
sum(Sales) over() as total_sales1,
sum(Sales) over(partition by ProductID) as total_sales
from Sales.Orders
--for aggregate functions in windows, we dont need to have the order by, but for rank it is necessary
--rank each order based on the sales from highest to lowest, additionaly provide the details such as order id and order date
select 
OrderID,
ProductID,
Sales,
OrderDate,
rank() over(order by Sales desc) as ranksales
from Sales.Orders
--going to aggregate functions in window function
--count function if * is used null value is also counted if not specifed by col then null is not calculated
--find the total orders additionally provide order id and order date
select
OrderID,
OrderDate,
count(*) over() as total_rows
from Sales.Orders
--find total orders for each customers
select
OrderID,
OrderDate,
CustomerID,
count(*) over(partition by CustomerID) as total_customer_orders
from Sales.Orders
--find total number of customers addititonally provide all customers details
--find the total non-null scores
select 
CustomerID,
*,
count(*) over() as total_customers,
count(Score) over() as total_scores_without_null
from Sales.Customers
--count is used to find if the duplicate is present, we can query the primary key to fins if it has any duplicates
select
*,
count(*) over(partition by OrderID) as check_for_primary_key_duplicate
from Sales.Orders
--the below table contains the duplicates
select
*,
count(*) over(partition by OrderID) as check_for_primary_key_duplicate
from Sales.OrdersArchive
--find the total sales across all orders, and total sales for each product. additionally provide details such as order id and order date
select
OrderID,
OrderDate,
Sales,
ProductID,
sum(Sales) over() as total_sales,
sum(Sales) over(partition by ProductID) as total_sales_for_each_product
from Sales.Orders
--find the percentage contribution of each product's sales to the total sales
select
OrderID,
ProductID,
Sales,
sum(Sales) over() as total_sales,
round(cast(Sales as float)/sum(Sales) over() * 100, 2) as percentage
from Sales.Orders
--find the average sales across all orders and the average sales for each product. additionally provide details such as order id and order date
select
OrderID,
OrderDate,
ProductID,
Sales,
avg(Sales) over() as avg_sales,
avg(Sales) over (partition by ProductID) as avg_sales_by_productid
from Sales.Orders
--find the average scores of the customers. provide details such as first name and last name
--since this has null we use coalese
select
CustomerID,
LastName,
Score,
avg(Score) over() as avg_score,
avg(coalesce(Score,0)) over() as avg_score_with_nulls_handled,
avg(coalesce(Score,0)) over (partition by CustomerID) as avg_score_by_customerid
from Sales.Customers
--find all the orders where sales are higher than the average sales across all orders
SELECT
    *
FROM (
    SELECT
        OrderID,
        OrderDate,
        ProductID,
        Sales,
        AVG(Sales) OVER (PARTITION BY ProductID) AS avg_sales_by_productid
    FROM Sales.Orders
) AS t
WHERE t.Sales > t.avg_sales_by_productid;
--find the highest and lowest sales across all the orders.and highest and lowest sales for each product, additionally add order id and order date
select 
OrderID,
OrderDate,
min(Sales) over() as lowest_sales,
min(Sales) over(partition by ProductID) as min_sales_by_productid,
max(Sales) over() as lowest_sales,
max(Sales) over(partition by ProductID) as min_sales_by_productid
from Sales.Orders
--show the highest salaray employee
SELECT *
FROM (
    SELECT *,
           MAX(Salary) OVER () AS highest_salary
    FROM Sales.Employees
) AS t
WHERE t.Salary = t.highest_salary;
---ranking functions have no values inside it but we need to have the order by that is must
--row number functions gives unique rank to each row even if two rows have same value
select
OrderID,
ProductID,
Sales,
ROW_NUMBER() OVER(ORDER BY Sales DESC) as salesrank_row 
from Sales.Orders
--rank will have a shared rank that is if two ranks are same then it skips the third rank and passes to 4th
select
OrderID,
ProductID,
Sales,
RANK() OVER(ORDER BY Sales DESC) as salesrank
from Sales.Orders
--dense rank will have the shared rank but will not leave any gap
select
OrderID,
ProductID,
Sales,
ROW_NUMBER() OVER(ORDER BY Sales DESC) as salesrank_row,
RANK() OVER(ORDER BY Sales DESC) as salesrank,
DENSE_RANK() OVER(ORDER BY Sales DESC) as dense_salesrank
from Sales.Orders
--find the top highest sales for each product
SELECT
*
FROM
(
    SELECT
        OrderID,
        ProductID,
        Sales,
        ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) AS HIGHEST_SALES
    from Sales.Orders
) AS t
where t.HIGHEST_SALES = 1
--FIND THE LOWEST 2 CUSTOMERS BASED ON THEIR SALES
SELECT *
FROM (
    SELECT
        CustomerID,
        SUM(Sales) AS total_sales,
        ROW_NUMBER() OVER(ORDER BY SUM(Sales)) as total_Sales_rank
    FROM Sales.Orders
    GROUP BY CustomerID
) AS t
WHERE t.total_Sales_rank <= 2;
--ntile is used to create a bucket, formula = num of rows/ntile given value
SELECT
OrderID,
ProductID,
Sales,
NTILE(1) OVER(ORDER BY Sales) as one_bucket,
NTILE(2) OVER(ORDER BY Sales) as two_bucket,
NTILE(3) OVER(ORDER BY Sales) as three_bucket
FROM Sales.Orders
--find the product that fall within highest 40% of the prices
SELECT 
*,
CONCAT((t.percentage * 100),'','%') as total_on_percentage
FROM
(
SELECT
ProductID,
Product,
Price,
CUME_DIST() OVER(ORDER BY Price DESC) as percentage
FROM Sales.Products
) as t
WHERE percentage <= 0.4
--lead means down value and lag means up value
--analyze the month over month performance sales between current and previous month
SELECT 
*,
(t.total_monthly_sales - t.Previous_month_sales) as difference_month_over_month,
round((cast(t.total_monthly_sales - t.Previous_month_sales as float)/t.total_monthly_sales)*100,1) as difference_month_over_month_percentage
FROM
(
SELECT
MONTH(OrderDate) as Month_order,
Sum(Sales) as total_monthly_sales,
LAG(Sum(Sales)) OVER(ORDER BY MONTH(OrderDate)) AS Previous_month_sales,
LEAD(Sum(Sales)) OVER(ORDER BY MONTH(OrderDate)) AS Next_month_sales
FROM
Sales.Orders
GROUP BY MONTH(OrderDate)
)AS t
--analyse the customer's loyalty by ranking customers based on the average number of days between the orders
SELECT
    t.CustomerID,
    AVG(t.difference_between_each_days) AS average_days_between_orders
FROM (
    SELECT
        OrderID,
        CustomerID,
        OrderDate AS current_order_date,
        LEAD(OrderDate) OVER (
            PARTITION BY CustomerID 
            ORDER BY OrderDate
        ) AS next_order_date,
        DATEDIFF(
            DAY,
            OrderDate,
            LEAD(OrderDate) OVER (
                PARTITION BY CustomerID 
                ORDER BY OrderDate
            )
        ) AS difference_between_each_days
    FROM Sales.Orders
) AS t
WHERE t.difference_between_each_days IS NOT NULL
GROUP BY t.CustomerID;

