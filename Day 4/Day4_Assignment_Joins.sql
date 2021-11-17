-- JC015122283IN
use dbt_01;

select * from emp;
select * from emp
where hiredate < (select hiredate from emp where ename like 'Scott');

select * from dept
where deptno = (select deptno from emp group by deptno having count(empno) = 3);

select d.dname, min(e.sal), max(e.sal) 
from dept d
join emp e
on d.deptno = e.deptno
group by e.deptno;

select *
from emp e
right join dept d
on e.deptno = d.deptno;

select *
from emp e
left join dept d
on e.deptno = d.deptno;

select distinct d.dname
from emp e
join dept d
on e.deptno
where d.deptno not in (select deptno from emp);

select d.deptno, d.dname
from emp e
join dept d
on e.deptno = d.deptno
group by e.deptno
having count(e.empno) >= 1
order by d.deptno;

select ename from emp where job!= 'manager';

select ename, sal, grade, dname, loc 
from emp e
join salgrade s
on (e.sal > losal and e.sal <= hisal)
join dept d
on e.deptno = d.deptno;

select ename, loc 
from emp e
join dept d
on e.deptno = d.deptno
where loc like 'Dallas';