-- Bank Schema
drop database bank;

CREATE DATABASE IF NOT EXISTS bank;

USE BANK;

CREATE TABLE customer
   (
       custid VARCHAR(6),
       fname VARCHAR(30),
       mname VARCHAR(30),
       ltname VARCHAR(30),
       city VARCHAR(15),
       mobileno VARCHAR(10),
       occupation VARCHAR(10),
       dob DATE
   );

CREATE TABLE branch
   (
    bid VARCHAR(6),
    bname VARCHAR(30),
    bcity VARCHAR(30)
   );
   
CREATE TABLE account
   (
      acnumber VARCHAR(6),
      custid  VARCHAR(6),
      bid VARCHAR(6),
      opening_balance INT(7),
      aod DATE,
      atype VARCHAR(10),
      astatus VARCHAR(10)
    );

CREATE TABLE tran_detail
    (   
     tnumber VARCHAR(6),
     acnumber VARCHAR(6),
     dot DATE,
     medium_of_transaction VARCHAR(20),
     transaction_type VARCHAR(20),
     transaction_amount INT(7)
    );

CREATE TABLE loan
   (
    custid VARCHAR(6),
    bid VARCHAR(6),
    loan_amount INT(7),
	loan_type VARCHAR(10),
	loan_status VARCHAR(20)
   );
