--indexes
--usually db takes the primary key as the default index. so we are creating the new table to practice the index
select *
into Sales.DBCustomers
from Sales.Customers

--default is non clustered index
--creating new cluster
create clustered index Idx_DBCustomers_CustomerID
on Sales.DBCustomers (CustomerID)
--to drop
drop index Idx_DBCustomers_CustomerID on Sales.DBCustomers
--a table can have many non clustered index but only one clustered index because it is sorted
create nonclustered index Idx_DBCustomers_Lastname
on Sales.DBCustomers(LastName)
create nonclustered index Idx_DBCustomers_Firstname
on Sales.DBCustomers(FirstName)
--composite index : means having more than one columns
create index Idx_DBCustomers_Country_and_Score
on Sales.DBCustomers(Country,Score)