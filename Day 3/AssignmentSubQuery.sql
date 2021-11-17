use supplier_db;
select * from orders;
select * from parts;
select * from suppliers;

select * from suppliers where status = (select status from suppliers where sname like 'Clark');

use dbt_01;
select * from emp;
select ename from emp where deptno = (select deptno from emp where ename = 'Miller');

use supplier_db;
select * from parts;

Select pname, color, weight from parts where weight > (select max(weight) from parts where color = 'RED');
select max(weight) from parts where color = 'RED';

select pname, color, weight from parts where weight < (select min(weight) from parts where color like 'Green');

select * from orders;
select * from suppliers;
select sname from suppliers where snum = any(select snum from orders where qty = (select max(qty) from orders));

use dbt_01;
select ename, sal from emp where sal = (select min(sal) from emp);

use supplier_db;
select * from orders;
select * from suppliers;
select sname, snum from suppliers where snum = (select snum from orders group by snum order by sum(qty) desc limit 1);


use dbt_01;

select * from dept;
select ename, deptno, count(ename) from emp where deptno = 30;
select deptno, dname from dept where deptno = (select deptno as c from emp group by deptno order by count(ename) desc limit 1);
