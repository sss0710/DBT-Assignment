select * from orders;
select * from parts;
select * from suppliers;

select * from suppliers order by city desc;

select * from parts order by city, pname desc;

select * from suppliers where status between 10 and 20;

select * from parts where weight not between 10 and 15;

select pname from parts where pname like 'S%';

select sname from suppliers where city like 'L%';


