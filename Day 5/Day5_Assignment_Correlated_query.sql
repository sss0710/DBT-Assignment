-- 1. List department details in which no employee is working.
select dname from dept
where deptno not in (select e.deptno from emp e);

-- 2. Find list of employees which are earning less then avg salary of there department
select * from emp
where sal < (select avg(sal) from emp);

-- 3. Display list of employees which are earning more then the corresponding manager.
select * from emp
where sal > ANY(select sal from emp where EMPNO = ANY(select mgr from emp));

-- 4. Display list of employees which are not managed by anyone
select * from emp where mgr is null;

-- 5. Display department details where avg salary is more then 1000
select * from dept
where deptno in (select deptno from emp
where sal > (select avg(sal) from emp)
group by deptno);

