create database dbt_01;

use dbt_01;

show tables;

desc emp;
desc dept;
desc salgrade;
desc bonus;
desc dummy;

select * from emp;
select * from dept;
select * from bonus;
select * from salgrade;
select * from dummy;

select user();

set @ttime = sysdate();
select @ttime;

select DATE(current_date()+2),current_date();