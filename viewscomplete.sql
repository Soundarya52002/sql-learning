--temp tables data will be erased  once the session is closed
select 
*
into #Orders
from Sales.Orders

select 
* from #Orders
--deleting orderstatus delivered from temp table
delete from #Orders where OrderStatus='Delivered'
--storing the new result in new table
select 
*
into Order_new
from #Orders