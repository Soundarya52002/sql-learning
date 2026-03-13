--window function 
--generate a seq num of 1 to 20
-- anchor query
with series as
(
select 1 as number
union all
--recursive part
select number+1
from series 
where number < 20
)
select * from series
--show the employee hierarchy by displaying each employee's level with other
select * from Sales.Employees
WITH cte_hie AS (
    -- Anchor query (top boss)
    SELECT 
        EmployeeID,
        FirstName,
        LastName,
        ManagerID,
        1 AS level
    FROM Sales.Employees
    WHERE ManagerID IS NULL

    UNION ALL

    -- Recursive query (employees under manager)
    SELECT 
        e.EmployeeID,
        e.FirstName,
        e.LastName,
        e.ManagerID,
        ct.level + 1 AS level
    FROM Sales.Employees AS e
    INNER JOIN cte_hie AS ct
        ON e.ManagerID = ct.EmployeeID
)
SELECT *
FROM cte_hie;
