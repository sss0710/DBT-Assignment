use hr_db;

show tables; 

select * from countries;
select * from departments;
select * from dependents;
select * from employees;
select * from jobs;
select * from locations;
select * from regions;

select e.first_name, e.last_name, e.department_id, d.department_name
from employees e
join departments d on e.department_id = d.department_id;

select e.first_name, e.last_name, d.department_name, l.city, l.state_province
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id;

select e.first_name, e.last_name, e.salary, j.job_title, j.min_salary, j.max_salary
from employees e
join jobs j 
on e.job_id = j.job_id;

select e.first_name, e.last_name, e.department_id, d.department_name
from employees e
join departments d on e.department_id = d.department_id
where e.department_id = 4 or e.department_id = 8;

select e.last_name, d.department_name, l.city, l.state_province
from employees e
join departments d on e.department_id = d.department_id
join locations l on d.location_id = l.location_id
where e.first_name like '%y';

select d.department_name
from departments d 
left join employees e
on d.department_id = e.department_id;

select first_name, last_name, salary
from employees
where salary < (select salary from employees where employee_id = 192);

select * from employees;
select a.first_name, b.first_name
from employees a
join employees b
on a.manager_id = b.employee_id;

select d.department_name, l.city, l.state_province
from departments d
join locations l
on d.location_id = l.location_id;

select e.first_name, e.last_name, e.department_id, d.department_name
from employees e
left join departments d 
on e.department_id = d.department_id;

select a.first_name 'Employee', b.first_name 'Manager'
from employees a
left join employees b
on a.manager_id = b.employee_id;
-- where b.manager_id is null;

select a.first_name, a.last_name, a.department_id
from employees a
left join employees b
on a.department_id = b.department_id
where b.last_name like 'Taylor';

select e.first_name, e.last_name, e.hire_date, d.department_name, j.job_title
from employees e
join departments d
on e.department_id = d.department_id
join jobs j
on e.job_id = j.job_id
having e.hire_date between '1993-01-01' and '1997-08-01';

select concat(e.first_name,' ',e.last_name) 'Name', j.job_title 'Designation', (select max(salary) from employees)-e.salary 'Remaining Salary'
from employees e
join jobs j
on e.job_id = j.job_id;

-- 16.) Write a query in SQL to display the full name (first and last name ) of employees, job title and the salary differences to their own job for those employees who is working in the department ID 8.
select concat(e.first_name,' ',e.last_name) 'Name', j.job_title 'Designation', (select max(salary) from employees where job_id = 8)-e.salary 'Remaining Salary'
from employees e
join jobs j
on e.job_id = j.job_id;

-- 17.) Write a query in SQL to display the name of the country, city, and the departments which are running there.
select c.country_name, l.city, d.department_name
from countries c
join locations l
on c.country_id = l.country_id
join departments d
on l.location_id = d.location_id;

select concat(b.first_name,' ', b.last_name) 'Manager List'
from employees a
join employees b
on a.manager_id = b.employee_id;

select j.job_title, e.salary
from jobs j
left join employees e
on j.job_id = e.job_id
where e.salary >= 12000;

select c.country_name, l.city, d.department_name, count(e.first_name) 'Count'
from countries c
join locations l
on c.country_id = l.country_id
join departments d
on l.location_id  = d.location_id
join employees e
on d.department_id = e.department_id
group by e.department_id having count >=2 ;

select d.department_name, concat(b.first_name,' ', b.last_name) 'Manager List', l.city
from employees a
join employees b
on a.manager_id = b.employee_id
join departments d
on b.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

select e.employee_id, j.job_title, datediff(sysdate(), e.hire_date)/365 'Experience'
from employees e
join jobs j
on e.job_id = j.job_id
where e.department_id = 8;

select concat(e.first_name,' ',e.last_name) 'Name', e.salary 'Salary', l.city
from employees e
join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
where l.city like 'London';

select d.department_name, count(employee_id) 'count'
from departments d
join employees e
on d.department_id = e.department_id
group by e.department_id;

select concat(e.first_name,' ',e.last_name) 'Name', e.employee_id, c.country_name
from employees e
join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
join  countries c
on l.country_id = c.country_id;