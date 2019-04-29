
-- alle Tablespaces anzeigen
select * from dba_tablespaces;

-- anlegen eines Tablespaces, keine Rechte für Oracle-Studierende!
create tablespace mytablespace
datafile 'mytablespace.dbf' size 1000K permanent;

-- loeschen eines Tablespaces inkl. Inhalt und Daten-File
drop tablespace mytablespace including contents and datafiles;

-- anlegen einer Tabelle im Tablespace mytablespace
create table customer(id integer primary key) tablespace mytablespace;
insert into customer values(1);


-- alle Benutzertabellen mit dem entsprechenden Tablespace anzeigen
select table_name, tablespace_name from user_tables;

-- alle Tabellen im Tablespace mytablespace anzeigen
select table_name, tablespace_name from user_tables where tablespace_name=upper('mytablespace');

-- Tablespace offline setzen
alter tablespace mytablespace offline;

-- geht nicht, Tablespace offline
select * from customer;

-- Tablespace online setzen
alter tablespace mytablespace online;


-- Welche Benutzer liegen im Tablespace ORACLE_STUDENTS
SELECT username, created, default_tablespace 
FROM dba_users
WHERE default_tablespace='ORACLE_STUDENTS';




-- Wiederholung Views
create table autos(marke varchar(20), ps integer, ek integer, vk integer);
insert into autos values('Audi', 200, 2000, 4000);
insert into autos values('BMW', 400, 30000, 40000);
select * from autos;

create view kundenview as select marke, ps, vk from autos;

select * from kundenview;

