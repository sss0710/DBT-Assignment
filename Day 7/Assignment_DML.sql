use bank;
/*1. Update all Branch_id where referred as BR in place of B
        eg: B00001 will become BR_00001
	*/

alter table branch
modify bid varchar(8) not null;

ALTER TABLE `account`
MODIFY `bid` VARCHAR(8);
ALTER TABLE `loan`
MODIFY `bid` VARCHAR(8);

UPDATE `branch`
  SET bid = REPLACE(`bid`, 'B', 'BR_')
WHERE `bid` NOT LIKE 'BR%';

-- 2. For testing purpose create a copy of tran_detail table and use bulk insert to load 1 million records to it. Please make necessary arrangement to generate new TRAN_ID for each record

CREATE TABLE tran_detail_copy
AS SELECT * FROM tran_detail;

-- 3. Update Transaction type and medium of transaction values to upper case for all records of transaction table.

UPDATE `tran_detail` t
   SET t.`medium_of_transaction` = UPPER(t.`medium_of_transaction`),
       t.`transaction_type` = UPPER(t.`transaction_type`);

-- 4. Update phone number and base location of customer Abhishek (C00009) to 8976523191 and Pune
UPDATE `customer`
  SET `mobileno` = '8976523191',
      `city` = 'Pune'
WHERE `custid` = 'C00009';

-- 5. Add a new column customer_cnt to Branch table and update it's value based on count of customer that branch has.
ALTER TABLE `branch`
  ADD `customer_cnt` INT DEFAULT 0;


UPDATE `branch` b
  SET b.`customer_cnt` = (
    SELECT COUNT(DISTINCT a.`custid`)
    FROM `account` a
    GROUP BY a.`bid`
    HAVING a.`bid` = b.`bid`
  );

-- 6. Create a new table account_bak and copy all records of account table to account_bak
CREATE TABLE `account_bak`
AS SELECT * FROM `account`;

-- 7. Update the account status as Inavtive for account of customer 'Amit Kumar Borkar'
UPDATE `account` a
   SET a.`astatus`= 'Inactive'
 WHERE `custid` = (
 SELECT `custid`
    FROM `customer`
   WHERE `fname` = 'Amit'
     AND `mname` = 'Kumar'
     AND `ltname` = 'Borkar');

-- 8. Add a new transaction to account for all loan account customers as one time charge of 1000 Rs for current month.
SELECT DISTINCT a.`acnumber`
FROM `account` a JOIN `loan` l
  ON a.`custid` = l.`custid`;

INSERT INTO tran_detail
VALUES ('T00013', 'A00001', CURRENT_DATE, 'NEFT', 'ONE TIME CHARGE', 1000),
('T00014', 'A00002', CURRENT_DATE, 'NEFT', 'ONE TIME CHARGE', 1000),
('T00015', 'A00004', CURRENT_DATE, 'NEFT', 'ONE TIME CHARGE', 1000),
('T00016', 'A00008', CURRENT_DATE, 'NEFT', 'ONE TIME CHARGE', 1000);