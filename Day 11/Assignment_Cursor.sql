/*
Cursors
---------

1. Prepare a program to display the comma separated list of employee names in following format

   Deptno    Employees
   -------   ------------
   10        Scott, Smith, Jones
   20        Allen, Ford
   30 
*/

1. Prepare a program to display the comma separated list of employee names in following format

   Deptno    Employees
   -------   ------------
   10        Scott, Smith, Jones
   20        Allen, Ford
   30
-------------------------------------------------------------

DELIMITER //
drop procedure if exists SortEmp//
CREATE PROCEDURE SortEmp()
BEGIN
DECLARE v_deptno int unsigned;
DECLARE v_ename_1 varchar(200);
DECLARE v_ename_2 varchar(200);
DECLARE v_ename_3 varchar(200);
DECLARE v_ename_temp varchar(20);
DECLARE v_is_not_found boolean;

DECLARE newcursor CURSOR FOR SELECT deptno, ename FROM emp order by ename;
DECLARE CONTINUE HANDLER FOR not found SET v_is_not_found = TRUE;

OPEN newcursor;
FETCH NEXT FROM newcursor INTO v_deptno,v_ename_temp;
inf_loop: LOOP

IF v_is_not_found THEN
        LEAVE inf_loop;
     END IF;
     
IF v_deptno=10 THEN
SET v_ename_1=CONCAT(IFNULL(CONCAT(v_ename_1,", "),''),v_ename_temp);
end if;

IF v_deptno=20 THEN
SET v_ename_2=CONCAT(IFNULL(CONCAT(v_ename_2,", "),''),v_ename_temp);
end if;

IF v_deptno=30 THEN
SET v_ename_3=CONCAT(IFNULL(CONCAT(v_ename_3,", "),''),v_ename_temp);
end if;

FETCH NEXT FROM newcursor INTO v_deptno,v_ename_temp;

END LOOP;
CLOSE newCursor;
SELECT deptno, CASE WHEN deptno=10 THEN v_ename_1
                    WHEN deptno=20 THEN v_ename_2
                    WHEN deptno=30 THEN v_ename_3
               END Employees
FROM emp 
GROUP by deptno
ORDER by deptno;
END//
delimiter ;

call SortEmp();
/*
2. Prepare a program to show the details in following format

    Deptno   Dname      Employees
	-------  -------    -------------
	10        SALES     Scott, Smith, Jones
*/
use dbt_01;
DELIMITER //
drop procedure if exists SortEmpDept//
CREATE PROCEDURE SortEmpDept()
BEGIN
DECLARE v_deptno int unsigned;
DECLARE v_ename_1 varchar(200);
DECLARE v_ename_2 varchar(200);
DECLARE v_ename_3 varchar(200);
DECLARE v_dname varchar(20);
-- DECLARE v_dname_2 varchar(200);
-- DECLARE v_dname_3 varchar(200);
DECLARE v_ename_temp1 varchar(200);
DECLARE v_is_not_found boolean;

DECLARE c1 cursor for select dname from dept where deptno = v_deptno;
DECLARE c2 CURSOR FOR SELECT deptno, ename FROM emp order by v_deptno;
DECLARE CONTINUE HANDLER FOR not found SET v_is_not_found = TRUE;

OPEN c1;

-- FETCH next FROM C1 INTO v_deptno, v_dname, v_ename_temp;
inf_loop: LOOP
fetch from c1 into v_dname;
IF v_is_not_found THEN
        LEAVE inf_loop;
     END IF;
open c2;
inf2_loop : LOOP
fetch from c2 into v_deptno, v_ename_temp1;
IF v_is_not_found THEN
        LEAVE inf_loop;
     END IF;
IF v_deptno=10 THEN
SET v_ename_1=CONCAT(IFNULL(CONCAT(v_ename_1,", "),''),v_ename_temp1);
-- set v_dname = (select dname from dept where deptno = v_deptno);
end if;

IF v_deptno=20 THEN
SET v_ename_2=CONCAT(IFNULL(CONCAT(v_ename_2,", "),''),v_ename_temp1);
-- set v_dname = (select dname from dept where deptno = v_deptno);
end if;

IF v_deptno=30 THEN
SET v_ename_3=CONCAT(IFNULL(CONCAT(v_ename_3,', '),''),v_ename_temp1);
-- set v_dname = (select dname from dept where deptno = v_deptno);
end if;
end loop;
close c2;
-- FETCH NEXT FROM c1 INTO v_deptno, v_dname, v_ename_temp1;
END LOOP;
CLOSE c1;

SELECT e.deptno, d.dname, CASE 
WHEN e.deptno=10 THEN v_ename_1 
WHEN e.deptno=20 THEN v_ename_2 
WHEN e.deptno=30 THEN v_ename_3 
END Employees
FROM emp e, dept d
where d.deptno = e.deptno
GROUP by e.deptno
ORDER by e.deptno;
END//
delimiter ;

call SortEmpDept();
/*
3. For performance testing we are trying to increase number of records by 10 times for each department. For eg: If there are 3 employees in dept 10 then we should be able to increase the employee count to 30 using same / random values 

eg:

+-------+--------+-----------+------+------------+------+------+--------+
| EMPNO | ENAME  | JOB       | MGR  | HIREDATE   | SAL  | COMM | DEPTNO |
+-------+--------+-----------+------+------------+------+------+--------+
|  7782 | CLARK  | MANAGER   | 7839 | 1981-06-09 | 2450 | NULL |     10 |
|  7839 | KING   | PRESIDENT | NULL | 1981-11-17 | 5000 | NULL |     10 |
|  7934 | MILLER | CLERK     | 7782 | 1982-01-23 | 1300 | NULL |     10 |


should become


+-------+--------+-----------+------+------------+------+------+--------+
| EMPNO | ENAME  | JOB       | MGR  | HIREDATE   | SAL  | COMM | DEPTNO |
+-------+--------+-----------+------+------------+------+------+--------+
|  7782 | CLARK  | MANAGER   | 7839 | 1981-06-09 | 2450 | NULL |     10 |
|  7783 | CLARK  | MANAGER   | 7839 | 1981-06-09 | 2450 | NULL |     10 |
|  7784 | CLARK  | MANAGER   | 7839 | 1981-06-09 | 2450 | NULL |     10 |
|  7785 | CLARK  | MANAGER   | 7839 | 1981-06-09 | 2450 | NULL |     10 |
|  7786 | CLARK  | MANAGER   | 7839 | 1981-06-09 | 2450 | NULL |     10 |
|  7787 | CLARK  | MANAGER   | 7839 | 1981-06-09 | 2450 | NULL |     10 |
...........
|  7839 | KING   | PRESIDENT | NULL | 1981-11-17 | 5000 | NULL |     10 |
|  7840 | KING   | PRESIDENT | NULL | 1981-11-17 | 5000 | NULL |     10 |
|  7841 | KING   | PRESIDENT | NULL | 1981-11-17 | 5000 | NULL |     10 |
|  7842 | KING   | PRESIDENT | NULL | 1981-11-17 | 5000 | NULL |     10 |
|  7843 | KING   | PRESIDENT | NULL | 1981-11-17 | 5000 | NULL |     10 |
|  7844 | KING   | PRESIDENT | NULL | 1981-11-17 | 5000 | NULL |     10 |
...........
|  7934 | MILLER | CLERK     | 7782 | 1982-01-23 | 1300 | NULL |     10 |
	
*/

	
	
/*
4. Prepare a program to create clone of all tables in given schema
*/

