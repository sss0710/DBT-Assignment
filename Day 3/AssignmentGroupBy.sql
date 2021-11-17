select * from orders;
select * from parts;
select * from suppliers;

select min(status) from suppliers;

select max(weight) from parts;

select avg(weight) from parts;

select pnum, sum(qty) from orders group by pnum;

select distinct pnum, avg(qty) from orders group by pnum;

select count(sname), `status` from suppliers group by status;

select status, count(sname) from suppliers
group by status order by status asc;

select 
case
	when `status` = 10 then "Ten"
    when `status` = 20 then "Twenty"
    when `status` = 30 then "Thirty"
end as 
status, count(sname) from suppliers
where convert(status, char) group by status order by status asc;