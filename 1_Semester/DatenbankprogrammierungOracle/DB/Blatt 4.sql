alter session set "_ORACLE_SCRIPT"=true;

-- Blatt 4

-- Aufgabe 1
create user freund1601894
identified by "1601894"
default tablespace oracle_students;

-- CREATE SESSION privilege fehlt
-- Recht geben:
GRANT CREATE SESSION TO freund1601894;
-- auch gehen würde:
GRANT CONNECT TO freund1601894;
-- allerdings ist CONNECT deprecated, eine Rolle in früheren Oracle-Systemen
-- die neben CREATE SESSION noch viele weitere Rechte hatte, die heute alle
-- gestrichen wurden

-- Löschen:
DROP USER freund1601894;


-- Aufgabe 2
CREATE ROLE my1601894VIEW;

create table t1(id integer);
insert into t1 values (1);
commit;

grant select on t1 to my1601894VIEW;
-- WITH GRANT OPTION kann nicht an eine Rolle vergeben werden!!
-- nur an Benutzer

CREATE user my1601894dummy
IDENTIFIED BY "1601894"
default tablespace oracle_students;

grant create session, my1601894view to my1601894dummy;

-- im Dummy-Account auslesen mit:
select * from "1601894".t1;

-- Rolle entziehen
revoke my1601894view from my1601894dummy;

-- Rolle deaktivieren (muss vom Dummy-Account ausgeführt werden)
set role all except my1601894view;
-- wieder einschalten: (auch vom Dummy-Account ausführen)
set role all;

-- Passwort geben
ALTER ROLE my1601894view identified by "passwort";

-- im Dummy-Account ausführen um für Rolle anzumelden:
SET ROLE my1601894view identified by "passwort";

-- alles löschen
DROP Role my1601894view;
drop user my1601894dummy;
drop table t1;


-- Aufgabe 3
create table katalog(id integer primary key, name varchar2(20),
beschreibung varchar2(100), ek_preis float, vk_preis float);

INSERT INTO katalog(id, name, ek_preis, vk_preis) VALUES (2, 'art2', 5, 20); -- für beschreibung with NULL eingefügt
INSERT INTO katalog(id, name, ek_preis, vk_preis) VALUES (3, 'art3', 19, 20);
INSERT INTO katalog(id, name, ek_preis, vk_preis) VALUES (4, 'art2', 22, 40);
INSERT INTO katalog(id, name, ek_preis, vk_preis) VALUES (5, 'art3', 50, 100);
INSERT INTO katalog(id, name, ek_preis, vk_preis) VALUES (6, 'art3', 19, 20);
INSERT INTO katalog(id, name, ek_preis, vk_preis) VALUES (7, 'art1', 22, 40);
INSERT INTO katalog(id, name, ek_preis, vk_preis) VALUES (8, 'art1', 50, 100);
INSERT INTO katalog(id, name, ek_preis, vk_preis) VALUES (9, 'art1', 19, 20);
INSERT INTO katalog(id, name, ek_preis, vk_preis) VALUES (10, 'art1', 22, 40);
COMMIT;


CREATE MATERIALIZED VIEW LOG ON katalog; -- sonst geht refresh fast nicht

CREATE MATERIALIZED VIEW business
REFRESH FAST
START WITH DATE '2018-11-15' + 2/24
NEXT DATE '2018-11-16' + 2/24
AS SELECT id, name, beschreibung, vk_preis / 1.19 netto_preis FROM katalog;


SELECT * FROM business;


-- Aufgabe 4
-- a
select uis.*, 'in stock' status
from used_cars_in_stock uis
UNION ALL -- union wirft duplikate weg, union all nicht
select us.*, 'sold' status
from used_cars_sold us;

-- b
select * from used_cars_in_stock
where (make, color) not in (
select make, color from used_cars_sold);

-- oder:
select make, color from used_cars_in_stock
MINUS
select make, color from used_cars_sold; -- aber zeigt nicht die Autos selbst

-- c
SELECT * FROM used_cars_sold ORDER BY price ASC
fetch next 1 rows only;

-- oder:
SELECT * FROM used_cars_sold 
WHERE price <= ALL(SELECT price from used_cars_sold);

-- d
WITH used_cars as (
    select uis.*, 'in stock' status
    from used_cars_in_stock uis
    UNION ALL -- union wirft duplikate weg, union all nicht
    select us.*, 'sold' status
    from used_cars_sold us
)
select * from used_cars
where price >= All(SELECT PRICE FROM used_cars);


-- e
SELECT distinct o.* FROM used_cars_sold o, used_cars_sold N
where o.make = n.make AND o.color = n.color
AND o.price > n.price AND o.age > n.age
order by o.make, o.color;