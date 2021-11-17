INSERT INTO customer VALUES('C00001','Ramesh','Chandra','Sharma','Delhi','9543198345','Service','1976-12-06');
INSERT INTO customer VALUES('C00002','Avinash','Sunder','Minha','Delhi','9876532109','Service','1974-10-16');
INSERT INTO customer VALUES('C00003','Rahul',null,'Rastogi','Delhi','9765178901','Student','1981-09-26');
INSERT INTO customer VALUES('C00004','Parul',null,'Gandhi','Delhi','9876532109','Housewife','1976-11-03');
INSERT INTO customer VALUES('C00005','Naveen','Chandra','Aedekar','Mumbai','8976523190','Service','1976-09-19');
INSERT INTO customer VALUES('C00006','Chitresh',null,'Barwe','Mumbai','7651298321','Student','1992-11-06');
INSERT INTO customer VALUES('C00007','Amit','Kumar','Borkar','Mumbai','9875189761','Student','1981-09-06');
INSERT INTO customer VALUES('C00008','Nisha',null,'Damle','Mumbai','7954198761','Service','1975-12-03');
INSERT INTO customer VALUES('C00009','Abhishek',null,'Dutta','Kolkata','9856198761','Service','1973-05-22');
INSERT INTO customer  VALUES('C00010','Shankar',null,'Nair','Chennai','8765489076','Service','1976-07-12');

INSERT INTO branch VALUES('B00001','Asaf ali road','Delhi');
INSERT INTO branch VALUES('B00002','New delhi main branch','Delhi');
INSERT INTO branch VALUES('B00003','Delhi cantt','Delhi');
INSERT INTO branch VALUES('B00004','Jasola','Delhi');
INSERT INTO branch VALUES('B00005','Mahim','Mumbai');
INSERT INTO branch VALUES('B00006','Vile parle','Mumbai');
INSERT INTO branch VALUES('B00007','Mandvi','Mumbai');
INSERT INTO branch VALUES('B00008','Jadavpur','Kolkata');
INSERT INTO branch VALUES('B00009','Kodambakkam','Chennai');

INSERT INTO account (acnumber,custid,bid,opening_balance,aod,atype,astatus)
 VALUES('A00001','C00001','B00001',10000,'2012-12-15','Saving','Active');
 
INSERT INTO account (acnumber,custid,bid,opening_balance,aod,atype,astatus)
 VALUES('A00002','C00002','B00001',12000,'2012-06-12','Saving','Active');
 
INSERT INTO account (acnumber,custid,bid,opening_balance,aod,atype,astatus)
 VALUES('A00003','C00003','B00002',12500,'2012-05-17','Saving','Active');
 
INSERT INTO account (acnumber,custid,bid,opening_balance,aod,atype,astatus)
 VALUES('A00004','C00002','B00005',11300,'2013-01-27','Saving','Active');
 
INSERT INTO account (acnumber,custid,bid,opening_balance,aod,atype,astatus)
 VALUES('A00005','C00006','B00006',20000,'2012-12-17','Saving','Active');
 
INSERT INTO account (acnumber,custid,bid,opening_balance,aod,atype,astatus)
 VALUES('A00006','C00007','B00007',12000,'2010-08-12','Saving','Suspended');
 
INSERT INTO account (acnumber,custid,bid,opening_balance,aod,atype,astatus)
 VALUES('A00007','C00007','B00001',15500,'2012-10-02','Saving','Active');
 
INSERT INTO account (acnumber,custid,bid,opening_balance,aod,atype,astatus)
 VALUES('A00008','C00001','B00003',11640,'2009-11-09','Saving','Terminated');
 
INSERT INTO account (acnumber,custid,bid,opening_balance,aod,atype,astatus)
 VALUES('A00009','C00003','B00007',11000,'2008-11-30','Saving','Terminated');
 
INSERT INTO account (acnumber,custid,bid,opening_balance,aod,atype,astatus)
 VALUES('A00010','C00004','B00002',11000,'2013-03-01','Saving','Active');

INSERT INTO tran_detail(tnumber, acnumber, dot, medium_of_transaction, transaction_type, transaction_amount)
VALUES('T00001','A00001','2013-01-01','Cheque','Deposit',2000);
INSERT INTO tran_detail(tnumber, acnumber, dot, medium_of_transaction, transaction_type, transaction_amount)
 VALUES('T00002','A00001','2013-02-01','Cash','Withdrawal',1000);
INSERT INTO tran_detail(tnumber, acnumber, dot, medium_of_transaction, transaction_type, transaction_amount)
 VALUES('T00003','A00002','2013-01-01','Cash','Deposit',2000);
INSERT INTO tran_detail(tnumber, acnumber, dot, medium_of_transaction, transaction_type, transaction_amount)
 VALUES('T00004','A00002','2013-02-01','Cash','Deposit',3000);
INSERT INTO tran_detail(tnumber, acnumber, dot, medium_of_transaction, transaction_type, transaction_amount)
 VALUES('T00005','A00007','2013-01-11','Cash','Deposit',7000);
INSERT INTO tran_detail(tnumber, acnumber, dot, medium_of_transaction, transaction_type, transaction_amount)
 VALUES('T00006','A00007','2013-01-13','Cash','Deposit',9000);
INSERT INTO tran_detail(tnumber, acnumber, dot, medium_of_transaction, transaction_type, transaction_amount)
 VALUES('T00007','A00001','2013-03-13','Cash','Deposit',4000);
INSERT INTO tran_detail(tnumber, acnumber, dot, medium_of_transaction, transaction_type, transaction_amount)
 VALUES('T00008','A00001','2013-03-14','Cheque','Deposit',3000);
INSERT INTO tran_detail(tnumber, acnumber, dot, medium_of_transaction, transaction_type, transaction_amount)
 VALUES('T00009','A00001','2013-03-21','Cash','Withdrawal',9000);
INSERT INTO tran_detail(tnumber, acnumber, dot, medium_of_transaction, transaction_type, transaction_amount)
 VALUES('T00010','A00001','2013-03-22','Cash','Withdrawal',2000);
INSERT INTO tran_detail(tnumber, acnumber, dot, medium_of_transaction, transaction_type, transaction_amount)
 VALUES('T00011','A00002','2013-03-25','Cash','Withdrawal',7000);
INSERT INTO tran_detail(tnumber, acnumber, dot, medium_of_transaction, transaction_type, transaction_amount)
 VALUES('T00012','A00007','2013-03-26','Cash','Withdrawal',2000);

INSERT INTO loan(custid, bid, loan_amount, loan_type, loan_status) VALUES('C00001','B00001',100000, 'PERSONAL','ACTIVE');
INSERT INTO loan(custid, bid, loan_amount, loan_type, loan_status) VALUES('C00002','B00002',200000, 'CAR', 'ACTIVE');
INSERT INTO loan(custid, bid, loan_amount, loan_type, loan_status) VALUES('C00009','B00008',400000, 'HOME', 'ACTIVE');
INSERT INTO loan(custid, bid, loan_amount, loan_type, loan_status) VALUES('C00010','B00009',500000, 'HOME', 'ACTIVE');
INSERT INTO loan(custid, bid, loan_amount, loan_type, loan_status) VALUES('C00001','B00003',600000, 'HOME', 'ACTIVE');
INSERT INTO loan(custid, bid, loan_amount, loan_type, loan_status) VALUES('C00002','B00001',600000, 'HOME', 'DUE');

