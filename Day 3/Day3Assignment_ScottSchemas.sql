select * from salgrade;
select * from dept;
select * from emp;

select ename, job, sal, deptno from emp where sal not between (select min(losal) from salgrade) and (select max(hisal) from salgrade);

select * from dept;

select * from emp where deptno = (select deptno from dept where loc like 'Dallas');

set @min_exp = (select concat(ename, ' ' , (datediff(sysdate(),hiredate)/365)) from emp order by datediff(sysdate(),hiredate)/365 limit 1); -- and min(Exp);
set @max_exp = (select concat(ename, ' ' , (datediff(sysdate(),hiredate)/365)) from emp order by datediff(sysdate(),hiredate)/365 desc limit 1);
select @max_exp;
select @min_exp;
