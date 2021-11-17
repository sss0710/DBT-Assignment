use dbt_01;
/*
1. Write a procedure to INSERT new department record in DEPT table. It should take following inputs. 
	- DEPTNO
	- DNAME
	- LOC
   Add exception handler to consider the department number as MAX(deptno)+10 in case provided deptno already exists.
  */
DELIMITER #
DROP PROCEDURE IF EXISTS insert_dept#
CREATE PROCEDURE insert_dept(
    IN v_deptno INT UNSIGNED,
    IN v_dname VARCHAR(20),
    IN v_loc VARCHAR(20)
)
BEGIN
    DECLARE DUPLICATE_ENTRY CONDITION FOR 1062;
    DECLARE CONTINUE HANDLER FOR DUPLICATE_ENTRY
        BEGIN
            SELECT MAX(DEPTNO) + 10 INTO v_deptno
              FROM DEPT;

            INSERT INTO DEPT
                VALUES (v_deptno, v_dname, v_loc);
        END;

    INSERT INTO DEPT
         VALUES (v_deptno, v_dname, v_loc);
END#

/*
2. Write a procedure to increase the salary of employee by x percent. It will take following inputs
	- empno
	- percent increase
	
	if provided empno is not found then raise an exception with following error
	
	Error Code : 2521; Provided employee number does not exists.
*/
DELIMITER #
DROP PROCEDURE IF EXISTS increase_salary#
CREATE PROCEDURE increase_salary(
    IN v_empno INT UNSIGNED,
    IN v_inc DECIMAL(4,2) UNSIGNED
)
BEGIN
    IF v_empno NOT IN (SELECT EMPNO
                         FROM EMP) THEN
        SIGNAL SQLSTATE '45000'
           SET MESSAGE_TEXT = 'Provided employee number does not exists.',
               MYSQL_ERRNO = 2521;
    ELSE
        UPDATE EMP
           SET SAL = ROUND(SAL * (1 + (v_inc / 100)))
         WHERE EMPNO = v_empno;
    END IF;
END#

/*
3. Write a procedure to delete the department record. In case of child records error (due to FK) from emp table, update the child records department number to NULL.
*/
DELIMITER #
DROP PROCEDURE IF EXISTS del_dept#
CREATE PROCEDURE del_dept(
    IN v_deptno INT UNSIGNED
)
BEGIN
    DECLARE CONTINUE HANDLER FOR 1451
        BEGIN
            UPDATE EMP
               SET DEPTNO = NULL
             WHERE DEPTNO = v_deptno;

            DELETE
              FROM `DEPT`
             WHERE DEPTNO = v_deptno;
        END;

    DELETE
      FROM `DEPT`
     WHERE DEPTNO = v_deptno;

END#

/*
4. Write a function to find the avg of salary of provided department number.
	- Return -1 if department does not exists
	- Raise an error is avg salary is less then 1000
*/
DELIMITER #
DROP FUNCTION IF EXISTS avg_dept_sal#
CREATE FUNCTION avg_dept_sal(
    v_deptno INT UNSIGNED
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_avgsal INT;

    IF v_deptno NOT IN (SELECT DEPTNO
                          FROM DEPT) THEN
        RETURN -1;
    ELSE BEGIN END;
    END IF;

    SELECT IFNULL(AVG(SAL), 0) INTO v_avgsal
      FROM EMP
     WHERE DEPTNO = v_deptno;

    IF v_avgsal < 1000 THEN
        SIGNAL SQLSTATE '45000'
                    SET MESSAGE_TEXT = 'Average salary of the department is less than 1000';
    ELSE BEGIN END;
    END IF;

    RETURN v_avgsal;
END#