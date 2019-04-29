-- Nested Tables
-- Immer zuerst den Typ der Nested Table erzeugen
 create or replace type telefonnr as table of number;
-- drop type telefonnr;

-- Angaben zur Speicherung der Einträge der Nested Table notwendig
-- Speichere zu jeder Person eine Liste von Privat- und Dienstnummern
create table person (
name varchar2(100),
privat telefonnr,
dienst telefonnr
) nested table privat store as privat_tab,
  nested table dienst store as dienst_tab;

-- Einfügen
insert into Person (name, privat, dienst) values ('Endres', telefonnr(2166), null);
insert into Person (name, privat, dienst) values ('Mandl', telefonnr(2143, 0151666666), telefonnr(0816));

select * from person;

-- Einfügen mit der Funktion TABLE
insert into TABLE (select privat from person where name = 'Endres') values (0151333333);

select * from person;


-- Abfragen von Werten mit der TABLE-Funktion
-- Alle Einträge von Person
SELECT t.name n, 
       p.COLUMN_VALUE p, 
       d.COLUMN_VALUE d      -- Pseudospalte und die einzige Spalte einer Nested Table
FROM person t, 
 TABLE(t.privat) p, 
 TABLE(t.dienst) d; 
 
 select * from Person;
 
 -- ändern
 UPDATE Person SET dienst = telefonnr(888) where name = 'Endres';
 
-- alle privaten Telefonnummern von Endres
SELECT p.COLUMN_VALUE p 
FROM Person t, 
TABLE(t.privat) p
where t.name = 'Endres';


-- ändern von Werten in Nested Tables
UPDATE Person 
 SET privat= telefonnr(320, 321, 322, 324) 
 WHERE name = 'Endres';
 

select * from person;

-- ändern einer einzelnen Nummer
UPDATE TABLE( SELECT t.privat 
 FROM person t 
 WHERE t.name = 'Endres') 
 SET COLUMN_VALUE = 54321 
 WHERE COLUMN_VALUE = 321; 

select * from Person;


-- löschen von Werten
DELETE FROM TABLE(SELECT t.privat
     FROM person t 
     WHERE t.name = 'Endres') 
WHERE COLUMN_VALUE > 321;

select * from Person;

-- löschen der Parent-Tabelle
drop table person;
