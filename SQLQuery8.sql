select * from customers
--string functions
select 
first_name,
country,
concat(first_name,' ',country) as namecountry
from customers
--firstname to lowercase
select 
first_name,
country,
lower(first_name) as lowerversion,
upper(first_name) as upperversion
from customers
--find the customer who has the trailing or leading spaces
select 
first_name 
from customers
where first_name != trim(first_name)
--replace phone number and fileformat
select 
'123-456-789' as phone ,
'report.csv' as fileformat,
replace('123-456-789','-','') as phonenumber,
replace('report.csv','.csv','.txt') as newformat
--length of each customers firstname
select 
first_name,
len(first_name) as length
from customers
--retrieve first 2 characters of the firstname
select 
first_name,
left(first_name,2) as first_two_characters
from customers
--last 2 characters
select 
first_name,
right(first_name,2) as last_two_characters
from customers
--remove first character and then need rest of the name
select 
first_name,
substring(first_name,2,len(first_name)) as name_withouot_first_letter
from customers
--rounding the values
select 3.5628,
round(3.5628,2) as round_2,
round(3.5628,1) as round_1,
round(3.5628,3) as round_3
--absolute numbers
select -5,
abs(-5) as absolute_value
-----
use SalesDB
select
OrderID,
CreationTime,
YEAR(CreationTime) as year,
month(CreationTime) as month,
day(CreationTime) as day
from Sales.Orders
--find the average score of customers
select * from Sales.Customers
select 
avg(Score) as average_score
from Sales.Customers