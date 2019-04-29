-- Übungsblatt 4 - Lösungshinweise


-- Oracle 18: 
alter session set "_ORACLE_SCRIPT"=true;

------------------------------------------------
-- Aufgabe 1, Benutzer 
create user freund0815
identified by albert
default tablespace oracle_students

-- Was geschieht? Anmeldung wird abgewiesen
-- Warum? Nur User die die CONNECT-Rolle haben duerfen sich verbinden
-- Was ist dagegen zu tun?
grant connect to freund0815;
drop user freund0815;




------------------------------------------------
-- Aufabe 2, Rollen
create role my0815view;

create table t1 (id number);
create table t2 (id number);
create table t3 (id number);

grant select on t1 to my0815view;
grant select on t2 to my0815view;
grant select on t3 to my0815view;

create user my0815dummy
identified by dummy
default tablespace oracle_students;

grant connect to my0815dummy;
grant my0815view to my0815dummy;

-- Als my0815dummy anmelden. 
select * from "0815".t1;

alter role my0815VIEW identified by passwort;

set role all except my0815view;
select * from "0815".t1;
set role all;
select * from "0815".t1;

drop role my0815view;
drop user my0815dummy;



---------------------------------------------------
-- Aufgabe 3, Materialized View

CREATE MATERIALIZED VIEW business 
      REFRESH FORCE
      START WITH TO_DATE('20110704 02:00', 'YYYYMMDD HH24:MI') 
            NEXT TO_DATE( '20110705 02:00', 'YYYYMMDD HH24:MI') 
    AS 
      SELECT id, name, beschreibung, vk_preis / 1.19 netto_preis
      FROM katalog;      
      
-- alternativ fuer
-- START WITH trunc(sysdate    ) + 2/24
-- NEXT       trunc(sysdate + 1) + 2/24


drop materialized view business;   


------------------------------------------------
-- Aufgabe 4:
-- a)
SELECT us.*, 'sold' status FROM used_cars_sold us
 UNION
SELECT ui.*, 'in stock' FROM used_cars_in_stock ui;


-- b)
SELECT *
FROM used_cars_in_stock
WHERE (make, color) NOT IN (SELECT make, color FROM used_cars_sold);


-- c)
SELECT *
FROM used_cars_sold
WHERE price <= ALL (SELECT price FROM used_cars_sold);


-- d)
SELECT *
FROM (SELECT * FROM used_cars_sold
      UNION
      SELECT * FROM used_cars_in_stock)
WHERE PRICE >= ALL (SELECT price FROM used_cars_sold
                    UNION
                    SELECT price FROM used_cars_in_stock);


-- e)
SELECT o.*, n.*
FROM used_cars_sold o, used_cars_sold n
WHERE o.make = n.make AND o.color = n.color
  AND o.price > n.price
  AND o.age > n.age
ORDER BY o.make, o.color;

