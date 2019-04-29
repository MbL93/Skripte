SQL-DML
-- dual
select * from dual;

select user from dual;
select sysdate from dual;
select current_date from dual;
select current_timestamp from dual;

select rowid from dual;
select m.*, rowid from used_cars_in_stock m;

-- rownum
create table test(id integer);
insert into test values(3);
insert into test values(2);
insert into test values(2);

select * from test;

select id, rownum from test;

select id, rownum from test order by id;

select id from test order by id;

select tmp.*, rownum from (select id from test order by id) tmp;

select * from (select id from test order by id) where rownum <= 1;

-- ACHTUNG: Reihenfolge der Auswertung, ein 
-- select u.*, rownum from used_cars_in_stock u where rownum <= 10 order by make; 
-- funktioniert nicht
-- ACHTUNG: ein where rownum < 10 funktioniert nicht, da die Nummer den Tupeln fest zugeordnet ist!
-- select * from used_cars_in_stock where rownum <= 3;

-- "seitenweise"
select * from (
 select tab.*, rownum rnum
 from used_cars_in_stock tab
 where rownum <= 6)
where rnum >= 3;

select m.*, rownum from used_cars_in_stock m;



-- Joins

create table R1 (attr1 varchar(20), attr2 integer, attr3 varchar(20));
create table R2 (attr1 integer, attr2 integer);


insert into R1 values('a', 1, 'b');
insert into R1 values('c', 2, 'd');
insert into R1 values('e', 3, 'f');
insert into R1 values('g', 2, 'h');

insert into R2 values(1, 17);
insert into R2 values(3, 24);
insert into R2 values(4, 10);



-- auf dbAdmin
select * from R1;
select * from R2;

-- Fehler: "Invalid Number"
SELECT * FROM R1 NATURAL JOIN R2;

-- Left Outer Join
SELECT * FROM R1, R2 WHERE R1.attr2 = R2.attr1 (+);

-- Right Outer Join
SELECT * FROM R1, R2 WHERE R1.attr2 (+) = R2.attr1;

-- Full Outer Join
SELECT * FROM R1 FULL OUTER JOIN R2 ON R1.attr2 = R2.attr1;

-- Union Join
-- select * from R1 union join r2;
SELECT R1.*, R2.* FROM R1 FULL OUTER JOIN R2 ON 0 = 1;

