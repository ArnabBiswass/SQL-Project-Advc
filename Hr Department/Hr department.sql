create database first_project
use first_project
select * from hr_employee;

alter table hr_employee
modify join_date date;

SELECT * FROM hr_employee 
WHERE Name is null OR 
Age is null OR 
Gender is null OR 
City is null OR 
Education is null OR 
Department is null OR 
Job_Title is null OR 
Join_Date is null OR 
Years_at_Company is null OR 
Salary_INR is null OR 
Performance_Rating is null OR 
Leaves_Taken is null OR 
Employment_Status is null OR
salary_inr is null;

update hr_employee
set salary_INR = ( select AVG_salary from (select AVG(salary_INR) as avg_salary
fROM hr_employee) as temp)
where salary_INR is null;

-- dublicate value find
select Employee_ID, count(*) from hr_employee 
group by Employee_ID
having count(*) > 1  

-- Total employees kitne hain?
select count(*) from hr_employee

-- 2. Kitne unique departments hain? 
SELECT COUNT(DISTINCT Department)
FROM hr_employee;

-- 3. Gender distribution kya hai?

select gender, count(*)
from hr_employee
group by gender;

-- 4. Employees kis-kis cities me hain?

select distinct City from hr_employee;

-- 5. Har department me kitne employees hain?

SELECT Department, COUNT(*) AS count_emp
FROM hr_employee
GROUP BY Department;

-- 6. Har department ki average salary kya hai?

select department, AVG(salary_INR) as avg_salary
from hr_employee
group by department;

-- 7. Highest salary kis employee ki hai?

select * from hr_employee
order by salary_INR desc
limit 1 ;

-- 8. Lowest salary kiski hai?
select * from hr_employee
order by salary_INR asc
limit 1 ;

-- 9. 5 sabse zyada salary wale employees kaun hain?
select * from hr_employee
order by salary_INR desc
limit 5 ;

-- 10. Experience ke hisaab se average salary kya hai?

select Years_at_Company, avg(Salary_INR) as avg_salary
from hr_employee
group by Years_at_Company;

-- 11. Har city me kitne employees hain?
select city, count(*) as total_emp
from hr_employee
group by city;

-- 12. Har job role me kitne log hain?

SELECT Job_Title, COUNT(*) AS total_employees
FROM hr_employee
GROUP BY Job_Title;

-- 13. Har department ka highest salary employee kaun hai?

select * from(
			select *,
                 RANK() over (partition by department 
                 order by Salary_INR desc) as rnk
                 from hr_employee) t
where rnk =1;

-- 14. Top 3 highest paid employees per department

select * from (	
             select *,
				dense_rank() over (partition by department
                order by Salary_INR desc) as rnk
                from hr_employee) t
where rnk <=3; 

-- 15. Salary > average salary wale employees

SELECT *
FROM hr_employee
WHERE Salary_INR > (
    SELECT AVG(Salary_INR)
    FROM hr_employee
);


select avg(salary_INR) from hr_employee;

-- 16. Department-wise salary difference (max - min)

SELECT Department,
       MAX(Salary_INR) - MIN(Salary_INR) AS salary_difference
FROM hr_employee
GROUP BY Department;

-- 17. Experience 5+ wale employees ki count

SELECT COUNT(*) AS employee_count
FROM hr_employee
WHERE Years_at_Company > 5;

-- 18. Kaunsa department sabse zyada salary deta hai (avg basis)?

select department, avg(Salary_INR) as avg_salary
from hr_employee
group by department
order by avg_salary desc
limit 5;

-- 19. Kis city me highest salary mil rahi hai?

SELECT City, MAX(Salary_INR) AS highest_salary
FROM hr_employee
GROUP BY City
ORDER BY highest_salary DESC
LIMIT 5;

-- 20. High performers (Top 10% salary) identify karo

select * from (
            select *, ntile(10) over (order by Salary_INR desc)
            as percentile_rank
            from hr_employee) t
where percentile_rank =1

