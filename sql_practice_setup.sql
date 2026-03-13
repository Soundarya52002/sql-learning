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
-- Find employees whose salary is greater than 60000.
select 
name, salary
from employees
where salary > 60000;
-- Find employees whose age is between 25 and 35.
select 
name, age
from employees
where age between 25 and 35;
-- Find employees whose name starts with A.
select
name as emp_name_start_with_a
from employees
where name like 'a%';
-- Find employees whose name ends with n.
select 
name as emp_name_end_with_n
from employees
where name like '%n';
-- Find employees whose name contains ar.
select 
name as emp_name_contains_ar
from employees
where name like '%ar%';
-- Find employees whose department is not HR.
select
name, department
from employees
where department!= 'HR';
-- Find employees whose salary is not between 30000 and 40000.
select 
name, salary
from employees
where salary not between 30000 and 40000;
-- Find employees whose age is greater than 25 AND salary greater than 50000.
select 
name
from employees
where age > 25 and salary > 50000;
-- Find employees whose department is IT OR salary > 70000.
select 
name
from employees
where department = 'IT' or salary > 70000;
-- Find employees where department is NULL.
select
name
from employees 
where department is null;
-- Show employees sorted by salary ascending.
select 
name, salary
from employees
order by salary asc;
-- Show employees sorted by salary descending.
select
name, salary
from employees
order by salary desc;
-- Sort employees by age then salary.
select
name,age,salary
from employees
order by age, salary;
-- Show top 3 highest salary employees.
select 
name, salary
from employees
order by salary desc
limit 3;
-- Show lowest salary employee.
select 
name, salary
from employees
order by salary 
limit 1;
-- Find total number of employees.
select
count(*) as total_num_of_employees
from employees;
-- Find maximum salary.
select
max(salary) as max_sal
from employees;
-- Find minimum salary.
select
min(salary) as min_sal
from employees;
-- Find average salary.
select
avg(salary) as avg_sal
from employees;
-- Find total salary paid to employees
select
sum(salary) as total_sal
from employees;
-- count number of employees in IT department.
select
count(*) as emp_in_it
from employees
where department = 'IT';
-- Find average age of employees
SELECT
avg(age) as aver_age
from employees;
-- Find total employees whose salary > 50000
select
count(*) as total_emp
from employees
where salary > 50000;
-- Find difference between max and min salary.
select
max(salary)-min(salary) as diff_sal
from employees;
-- Find average salary of employees older than 30.
select
avg(salary) as avg_sal_older_30
from employees
where age > 30;
-- Count employees in each department.
select
department ,count(name) as count
from employees
group by department;
-- Find average salary per department.
select
avg(salary) as avg_sal, department
from employees
group by department;
-- Find maximum salary per department.
select
max(salary) as max_sal, department
from employees
group by department;
-- Find minimum age per department.
select
min(age) as min_age, department
from employees
group by department;
-- Find total salary per department.
select
sum(salary) as total_sal, department
from employees
group by department;
-- Find departments having more than 5 employees.
SELECT 
    department,
    COUNT(*) AS total_employees
FROM employees
GROUP BY department
HAVING COUNT(*) > 5;
-- Find departments where average salary > 50000.
SELECT
    department,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 50000;
-- Find number of employees per age.
select
count(*),age
from employees
group by age;
-- Find total salary paid per age group.
select
sum(salary) as total_sal, age
from employees
group by age;
-- Find department with highest average salary.
SELECT department,
       AVG(salary) AS avg_salary
FROM employees
GROUP BY department
ORDER BY avg_salary DESC
LIMIT 1;
-- Show departments having more than 3 employees.
select
department
from employees
group by department
having count(name) > 3;
-- Show departments where average salary > 60000.
select
department
from employees
group by department
having avg(salary) > 60000;
-- Show age groups where count > 2.
select
age
from employees
group by age
having count(age) > 2; 
-- Show departments where max salary > 80000.
select
department
from employees
group by department
having max(salary) > 80000;
-- Show departments where total salary > 200000.
select
department
from employees
group by department 
having sum(salary) > 200000;
-- Show employee name with department name.
SELECT 
    e.name AS emp_name,
    d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.department = d.dept_name;
-- Show all employees even if department missing
SELECT 
    e.name AS emp_name,
    d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.department = d.dept_name;
-- Show all departments even if no employees.
SELECT 
    e.name AS emp_name,
    d.dept_name
FROM employees e
RIGHT JOIN departments d
ON d.dept_name = e.department;
-- Show employees working in IT department.
SELECT 
    e.name AS emp_name,
    d.dept_name
FROM employees e
LEFT JOIN departments d
ON e.department = d.dept_name
where e.department = 'IT';
SELECT 
    d.dept_name,
    COUNT(e.name) AS total_employees
FROM departments d
LEFT JOIN employees e
ON e.department = d.dept_name
GROUP BY d.dept_name;