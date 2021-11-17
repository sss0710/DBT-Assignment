/*Introduce following constraint on tables in Bank schema.

Customer table
1. Customer id in customer table must be unique and does not allow null values
2. Column fname must not allow space in it
3. First name, middle name and last name must not be same
4. Age of customer (based on date of birth) must be more then 10 years old.
*/
use bank;
desc customer;

alter table customer
modify custid varchar(6) primary key,
add constraint spc_fname_chk check(fname not like '% %');

alter table customer
add constraint unique_fname_mname_ltname1_chk unique(fname,mname,ltname);


alter table customer 
add constraint chk_age check(datediff(sysdate(), dob) > 10);

/*
Branch Table
1. Branch name must not be null
2. Branch id must be unique and not null
*/

select * from branch;

alter table branch
modify bid varchar(6) primary key,
add constraint chk_name_null check(bname is not null);

desc branch;

insert into branch values('B00020', NULL, 'Kalyan');
-- Error Code: 3819. Check constraint 'chk_name_null' is violated.

/*
Account Table
1. Account number for each record must be unique
2. Customer Id must be of valid customer and must not be left as blank
3. opening balance must be more then 10000
4. Acount opening date must not be of past dates
5. Branch id (bid) must be of valid branch 
*/

desc account;



/*
Tran_detail Table
1. Transaction number must be unique for each transaction
2. Account number must refer to valid account
*/

/*
Loan Table
1. Customer Id must be of valid customer and must not be left as blank
2. Branch id (bid) must be of valid branch 
3. One customer can take only one loan for each loan type
*/