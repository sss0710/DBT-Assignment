select distinct job from emp
order by job;

select concat(ename,' is earning ',sal,' dollars') 'Name and Salary' from emp;

select ename 'Employee Name', job 'Designation' from emp;

select ename, ((sal*12)+1000)+coalesce(comm,0) 'Annual Salary' from emp;

select distinct coalesce(mgr,'NA') 'Manager Number' from emp;

select ename,  sal, coalesce(comm, 1500) from emp;

select * from emp where deptno = 10;

select ename 'Name', sal 'Salary' from emp where job like 'clerk' or 'salesman';

select ename, hiredate from emp;
select ename 'Name' from emp where year(hiredate)>1981;

select ename 'Name' from emp where year(hiredate)=1981;

select * from emp where job like 'Clerk' and sal > 1000;

select * from emp where comm is null or comm = 0;

select * from emp where (sal+coalesce(comm,0)) > 2000;

select * from emp where deptno in (10,30);

-- INFORMATION_SCHEMA---------------------------------------------------------------------------------------------

use information_schema;

show tables;

select * from tables;

select table_name from tables where table_schema like 'dbt_01';

select * from columns;