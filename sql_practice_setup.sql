USE sql_practice;
-- Select all columns from employees.
select * from employees;
-- Select only name and salary.
select 
name,
salary
from employees;
-- Select employees whose salary is greater than 50000.
select 
name as employee_who_is_getting_more_salary
from employees
where salary > 50000;
-- Select employees whose age is less than 30.
select
name as who_age_is_less_than_30
from employees
where age < 30;
-- Select employees working in IT department
select 
name as employee_under_it
from employees
where department = 'IT';
-- Select employees whose salary is between 40000 and 60000.
SELECT
NAME AS sal_bet_40k_to_60k
from employees
where salary between 40000 and 60000;
-- Select employees whose age is not equal to 25.
select 
name as emp_who_is_not_25
from employees
where age!=25;
-- Select employees whose department is HR or Finance.
select
name as emp_det, department as dept
from employees
where department = 'HR' or department = 'Finance'; 
-- Select all employees but show only first 5 rows
SELECT *
FROM employees
LIMIT 5;
-- Select distinct departments from employees table.
select distinct
department
from employees;

