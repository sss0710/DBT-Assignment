-- 1. Write a program to take the input as empno and return the experience of employee in terms of number of years.
use dbt_01;
delimiter //
drop function if exists func_exp//
create function func_exp(f_empno int)
returns integer
deterministic
begin
-- declare emp_exp integer;
	set @emp_exp = (select datediff(sysdate(), hiredate)/365 from emp where empno = f_empno);
	return @emp_exp;
end //
delimiter ;

select func_exp(7499) 'Experience in Years';

-- 2. Write a program to take the input as deptno and return the comma separated list of employee names

delimiter //
drop function if exists func_deptno_name//
CREATE function func_deptno_name(p_deptno INT)
returns varchar(300)
deterministic
BEGIN
    DECLARE v_emp_list varchar(300);
    declare v_ename VARCHAR(50);
    DECLARE is_not_found BOOLEAN;
    DECLARE c1 CURSOR FOR select ename FROM emp WHERE deptno=p_deptno;
    DECLARE continue handler for not found set is_not_found=true;
    OPEN c1;
    
    curloop: LOOP
       FETCH c1 INTO v_ename;
       
       IF is_not_found THEN
          LEAVE curloop;
	   END IF;
       
       IF v_emp_list IS NULL THEN
           SET v_emp_list = v_ename;
	   ELSE
           SET v_emp_list = CONCAT(v_emp_list,', ' ,v_ename);
	   END IF;
       fetch next from c1 into v_ename;
    END LOOP;
    
    CLOSE c1;
    
    return v_emp_list;
END//
delimiter ;

select func_deptno_name(20);

/* 3. Add a new column incentive to emp table. Write a program to calculate and update the incentive using following logic.
     If employees salary is more then avg salary of dept then incentive is 0
	 If employees salary is less then avg salary of dept then incentive is 10% of salary 
*/
drop table if exists emp_temp;
create table emp_temp like emp;
insert into emp_temp select * from emp;
alter table emp_temp
add incentive int unsigned default 0;
select * from emp_temp;
use dbt_01;    

delimiter //
drop procedure if exists func_incent//
create procedure func_incent(f_deptno int)
begin

update emp_temp 
set incentive=0 
where sal > (select avg(e.sal) 
			from (select * from emp_temp) e
            where e.deptno = f_deptno);
update emp_temp
set incentive=sal+(sal*.1) 
where sal < (select avg(e.sal) 
			from (select * from emp_temp) e
            where e.deptno = f_deptno);

end//
delimiter ;
SET SQL_SAFE_UPDATES = 0;	
call func_incent(10);

-- 4. Write a program to get the count of employees working in provided deptno

delimiter //
drop function if exists func_count//
create function func_count(f_deptno int)
returns int
deterministic
begin
	declare c int unsigned;
    set c = (select count(ename) from emp_temp group by deptno having deptno = f_deptno);
    if c is null then
		return -1;
	end if;
    return c;
end//
delimiter ;
select func_count(10) 'No of Emp';
    
