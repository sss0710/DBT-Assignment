/*Procedure
==========
1. Prepare a program which can perform following operation
	- Lookout for tables which has missing constraints
	- Display list of those tables */
	
use information_schema;
use dbt_01;
show tables;
select * from check_constraints; -- displays the list of schemas haveing check constraints
delimiter //
drop procedure if exists proc_no_table_const//
create procedure proc_no_table_const()
begin
	select table_name from information_schema.tables where table_name <> All(select table_name from information_schema.table_constraints);
end //
delimiter ;

call proc_no_table_const;

/* 2. Prepare a program to delete the data from emp. It will receive two inputs employee number and employee name. If employee number is passed as null then delete the data based on employee name.
Backup the deleted data to employee_backup table.
*/
use dbt_01;
drop table emp_temp;
drop table emp_bkp;
create table emp_temp like emp;
insert into emp_temp select * from emp;
create table emp_bkp like emp_temp;
select * from emp_bkp;
select * from emp_temp;

delimiter //																							
drop procedure if exists proc_del_bkup//																	
create procedure proc_del_bkup(IN p_eno int, IN p_ename varchar(10))											
begin																									
	insert into emp_bkp (select * from emp_temp e where e.empno = p_eno or e.ename = p_ename);			
	select * from emp_bkp;																				
	delete from emp_temp e																				
	where e.empno = p_eno or e.ename = p_ename;															
	select * from emp_temp;																				
end //																									
delimiter ;											

SET SQL_SAFE_UPDATES = 1;				

call proc_del_bkup(NULL, 'TURNER');
/*
3. Prepare a program to insert new record in employee table. it will take the input of employee data.
If salary is provided as null then consider the salary as highest salary earned by any employee in same department. If comm is not provided then assume it as 200$
*/
use dbt_01;

delimiter //																												
drop procedure if exists proc_record_salary_comm;																				
create procedure proc_record_salary_comm(p_empno int unsigned, p_ename varchar(10), p_job varchar(9), p_mgr int unsigned, 		
p_hiredate date, p_sal float, p_comm float, p_deptno int unsigned)															
begin																														
	if p_sal is null																										
	then set p_sal = (select max(sal) from emp);																			
	end if;																													
  																															
	if p_comm is null																										
	then set p_comm = 200;																									
	end if;																													
																															
	insert into emp_bkp(empno, ename, job, mgr, hiredate, sal, comm, deptno)												
	values(p_empno, p_ename, p_job, p_mgr, p_hiredate, p_sal, p_comm, p_deptno);
    
    select * from emp_bkp where empno = p_empno;
end //																														
delimiter ;																													
select * from emp_bkp;
call proc_record_salary_comm(9875, NULL, NULL, 7900, NULL, NULL, NULL, 10);

/*
4. Prepare a procedure in sql to receive the input as table name and column name. Add primary key constraint on provided table's column.
*/
DELIMITER //
drop procedure IF exists proc_pk_table_col //
create procedure proc_pk_table_col(IN p_table_name varchar(20), IN p_col_name varchar(20))
begin
	set @tableName=CONCAT('alter table ', (select p_table_name), ' ADD PRIMARY KEY (',(select p_col_name),');');
	PREPARE stmnt1 from @table_name;
	execute stmnt1;
	deallocate prepare stmnt1;
end//
desc emp_bkp;
call proc_pk_table_col('emp_temp', 'empno');

/*
5. Prepare a program to list those employee who are earning less then avg of there deparment. This program may take input as (p_salary_fix BOOLEAN). If the input is given as true then these employees salary must be set to AVG Salary + 100$.
*/
delimiter //

drop procedure if exists proc_sal_update //
create procedure proc_sal_update(IN p_salary_fix boolean)
begin
	select ename, sal
    from emp_temp e
    where sal < (select avg(sal) from emp_temp where deptno = e.deptno group by deptno);

    if p_salary_fix
    then
        update emp_temp join (select deptno, round(avg(sal)) avgsal from emp_temp group by deptno) s
		using (deptno)
		set sal = (avgsal + 100)
        where empno in (select e.empno 
						from (select * from emp_temp) e 
                        where e.sal < (select avg(a.sal) 
										from (select * from emp_temp) a 
                                        group by a.deptno 
                                        having a.deptno = e.deptno));
    end if;
	
end // 

call proc_sal_update(false);
call proc_sal_update(true);

delimiter //
drop procedure if exists proc_exp//
create procedure proc_exp(IN f_empno int)
begin
-- declare emp_exp integer;
	set @emp_exp = (select datediff(sysdate(), hiredate)/365 from emp where empno = f_empno);
	select @emp_exp;
end //
delimiter ;

call proc_exp(7499);