-- 1. Create a trigger to raise error if employee salary is less then avg salary of corresponding department.
select avg(sal) from emp_temp where deptno = 30;

delimiter //
drop trigger if exists empSapTrig//
create trigger empSalTrig1
before insert on emp_temp
for each row
begin
	if new.sal < (select avg(sal) from emp_temp where deptno = new.deptno) then
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Salary cannot be less than avg salary of dept';
	end if;
end//
delimiter ;

select * from temp;
desc temp;
INSERT INTO tEMP VALUES(7863, 'Sheshank',  'Dehchori', 7902, STR_TO_DATE('13-APR-1998', '%d-%b-%Y'),  800, NULL, 20);

/*2. Add an additional column called to emp table called as last_updated_by and last_updated_date.
   Upon each update issued on emp table, these columns must be updated by database user and current date (use function current_user() and SYSDATE())*/

alter table temp
add last_updated_by varchar(50); 
alter table temp
add last_updated_date DATE;   

delimiter //
drop trigger if exists updatedByTrigger//
create trigger updatedByTrigger
after insert on emp_temp
for each row
begin
	update emp_temp
		set last_updated_by = user()
        where empno = new.empno;
	update temp
    set last_updated_date = sysdate()
    where empno = new.empno;
end//
delimiter ;

select * from emp_temp;
INSERT INTO emp_tEMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7863, 'Sheshank',  'Dehchori', 7902, STR_TO_DATE('13-APR-1998', '%d-%b-%Y'),  3800, NULL, 10);
INSERT INTO emp_tEMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
VALUES(7863, 'Sheshank',  'Dehchori', 7902, STR_TO_DATE('13-APR-1998', '%d-%b-%Y'),  3800, NULL, 10);
select * from emp_temp;

-- 3.  Upon delete of department records from dept table. The corresponding employees records must be deleted as well. Implement this requirement with trigger

delimiter //
drop trigger if exists DelRecordsTrigger//
create trigger DelRecordsTrigger
after delete
on dept1
for each row
begin
	delete from emp1
		where deptno = old.deptno;
end//
delimiter ;
-- set SQL_SAFE_UPDATES=0;
delete from dept1
where deptno = 10;

select ename from emp1 where empno = Any(select empno from emp1 where deptno = 10);

/*drop table if exists dept1;
create table dept1 as table dept;
select * from dept1;
select * from emp1;
drop table if exists emp1;
create table emp1 as table emp;
*/

/*4. Create a table with following design

      Table NAme : scott_schema_audit
	   Columns : table_name, operation_name, db_user, change_date

   Populate this table each time the user perform any DML command on emp,dept or salgrade table. Sample data will look like
                 table_name, operation_name, db_user, change_date
				 emp          update         root@localhost   2020-09-14
				 dept         delete         root@localhost   2020-09-15
				 ....*/
                 
CREATE TABLE dac_dbt.scott_schema_audit
(
    table_name VARCHAR(64),
    operation_name VARCHAR(20),
    db_user VARCHAR(64),
    change_date DATE
)

-- EMP
DELIMITER #
DROP TRIGGER IF EXISTS emp_audit_insert#
CREATE TRIGGER emp_audit_insert
AFTER INSERT
ON EMP
FOR EACH ROW
BEGIN
    INSERT INTO scott_schema_audit
         VALUES ('emp', 'insert', CURRENT_USER(), DATE(SYSDATE()));
END#

DELIMITER #
DROP TRIGGER IF EXISTS emp_audit_update#
CREATE TRIGGER emp_audit_update
AFTER UPDATE
ON EMP
FOR EACH ROW
BEGIN
    INSERT INTO scott_schema_audit
         VALUES ('emp', 'update', CURRENT_USER(), DATE(SYSDATE()));
END#

DELIMITER #
DROP TRIGGER IF EXISTS emp_audit_delete#
CREATE TRIGGER emp_audit_delete
AFTER DELETE
ON EMP
FOR EACH ROW
BEGIN
    INSERT INTO scott_schema_audit
         VALUES ('emp', 'delete', CURRENT_USER(), DATE(SYSDATE()));
END#

-- DEPT
DELIMITER #
DROP TRIGGER IF EXISTS dept_audit_insert#
CREATE TRIGGER dept_audit_insert
AFTER INSERT
ON DEPT
FOR EACH ROW
BEGIN
    INSERT INTO scott_schema_audit
         VALUES ('dept', 'insert', CURRENT_USER(), DATE(SYSDATE()));
END#

DELIMITER #
DROP TRIGGER IF EXISTS dept_audit_update#
CREATE TRIGGER dept_audit_update
AFTER UPDATE
ON DEPT
FOR EACH ROW
BEGIN
    INSERT INTO scott_schema_audit
         VALUES ('dept', 'update', CURRENT_USER(), DATE(SYSDATE()));
END#

DELIMITER #
DROP TRIGGER IF EXISTS dept_audit_delete#
CREATE TRIGGER dept_audit_delete
AFTER DELETE
ON DEPT
FOR EACH ROW
BEGIN
    INSERT INTO scott_schema_audit
         VALUES ('dept', 'delete', CURRENT_USER(), DATE(SYSDATE()));
END#

-- SALGRADE
DELIMITER #
DROP TRIGGER IF EXISTS salgrade_audit_insert#
CREATE TRIGGER salgrade_audit_insert
AFTER INSERT
ON SALGRADE
FOR EACH ROW
BEGIN
    INSERT INTO scott_schema_audit
         VALUES ('salgrade', 'insert', CURRENT_USER(), DATE(SYSDATE()));
END#

DELIMITER #
DROP TRIGGER IF EXISTS salgrade_audit_update#
CREATE TRIGGER salgrade_audit_update
AFTER UPDATE
ON SALGRADE
FOR EACH ROW
BEGIN
    INSERT INTO scott_schema_audit
         VALUES ('salgrade', 'update', CURRENT_USER(), DATE(SYSDATE()));
END#

DELIMITER #
DROP TRIGGER IF EXISTS salgrade_audit_delete#
CREATE TRIGGER salgrade_audit_delete
AFTER DELETE
ON SALGRADE
FOR EACH ROW
BEGIN
    INSERT INTO dept_schema_audit
         VALUES ('salgrade', 'delete', CURRENT_USER(), DATE(SYSDATE()));
END#

delimiter ;