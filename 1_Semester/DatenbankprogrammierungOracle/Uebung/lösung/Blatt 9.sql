-- wenn man dieses Blatt beantworten kann, schafft man die Prüfung locker
-- in der Prüfung kommen 4 Aufgaben

-- Aufgabe 1
-- a
create table messwerte (
    datum DATE primary key,
    w1 number,
    w2 number,
    w3 number,
    w4 number,
    w5 number,
    w6 number
);

insert into messwerte values (to_date('10.12.2018', 'dd.mm.yyyy'), 1, 2, 3, 4, 5, 6);
insert into messwerte values (to_date('19.12.2018', 'dd.mm.yyyy'), 5, 7, 3, 4, 5, 6);
insert into messwerte values (to_date('20.12.2018', 'dd.mm.yyyy'), 5, 7, 3, 4, 5, 6);
-- in Klausur einfach '20.12.2018' (to_date muss nicht sein)

insert into messwerte
select sysdate+2+level, dbms_random.random, dbms_random.random, dbms_random.random, dbms_random.random, dbms_random.random, dbms_random.random
from dual
connect by level <= 10;


-- b
select datum, greatest(w1, w2, w3, w4, w5, w6) größte, least(w1, w2, w3, w4, w5, w6) kleinste
from messwerte;


-- c
select * from messwerte;

select m1.datum, m1.w1, m1.w1 - m2.w1
from messwerte m1 left outer join messwerte m2 -- left outer weil es Tage ohne Vortag gibt
on m1.datum = m2.datum + 1
order by m1.datum;


-- Aufgabe 2
-- a
-- Schaltung
-- select * from (select ... order by...) where rownum ...


-- b
select rownum, id, make, price from used_cars_sold
order by price desc fetch first 5 rows only;


-- c
-- decode