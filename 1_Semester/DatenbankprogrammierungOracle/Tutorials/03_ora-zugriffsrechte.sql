
-- Oracle 18: 
alter session set "_ORACLE_SCRIPT"=true;

-- 2.1 Benutzerkonten

-- Benutzer erstellen
CREATE USER ora_benutzer IDENTIFIED BY ora_passwort;

-- Tablespace zuweisen
CREATE USER ora_benutzer IDENTIFIED BY ora_passwort DEFAULT TABLESPACE oracle_students;
-- Versuchen sich als ora_benutzer einzuloggen geht schief wegen fehlender
-- Rechte


-- Rechte zum einloggen vergeben
GRANT CREATE SESSION TO "ORA_BENUTZER";


-- Passwort ändern
ALTER USER ora_benutzer IDENTIFIED BY new_ora_passwort;

-- SQL Befehle in 'Edit User' im SQL Developer anschauen
-- z.B. Tablespace ändern
ALTER USER ora_benutzer DEFAULT TABLESPACE DB1_Students;


-- Connect to ora_benutzer geht schief, da er keine Rechte hat
-- Es müssen entsprechende Rechte vergeben werden

-- Benutzer löschen
DROP USER ora_benutzer CASCADE;


-- Tabelle anlegen in 0815
CREATE TABLE lectures(id integer primary key, name varchar(200));
INSERT INTO lectures VALUES(1, 'Oracle');


-- abfragen in ein anderes Schema
SELECT * FROM "0815".lectures;

-- geht nicht, wenn die Daten noch nicht festgeschrieben wurden
COMMIT;



-- 2.2 Benutzerrechte und Rollen

-- einloggen erlauben
GRANT CREATE SESSION TO ora_benutzer;

-- Versuche Tabelle in ora_benutzer anzulegen
CREATE TABLE test(id integer);
-- geht schief, da keine Rechte, 
-- also Rechte vergeben
GRANT CREATE TABLE TO ora_benutzer;

-- create table geht immer noch schief, da Rechte auf Tablespace fehlen
CREATE TABLE test(id integer);

-- also unbegrenzten Speicherbereich geben
GRANT UNLIMITED TABLESPACE TO ora_benutzer;
-- alternativ: ALTER USER ora_benutzer QUOTA 10M ON oracle_students;



-- z.B. Rolle CONNECT hinzufügen
-- Recht der eigenen Rolle ora_role hinzufügen
GRANT CONNECT TO ora_benutzer;

-- dann kann man sich als Benutzer ora_benutzer einloggen, aber immer noch
-- keine Tabellen erstellen
GRANT CREATE TABLE TO ora_benutzer;
GRANT UNLIMITED TABLESPACE TO ora_benutzer;


-- einfacher: Alle notwendigen Rechte in einer eigenen Rolle verwalten:
-- Rolle anlegen
CREATE ROLE ora_role;

GRANT CONNECT TO ora_role;
GRANT CREATE TABLE TO ora_role;
GRANT UNLIMITED TABLESPACE TO ora_role;

-- Rolle dem Benutzer ora_benutzer zuweisen
GRANT ora_role TO ora_benutzer; 



-- löschen einer Rolle
DROP ROLE ora_role;




-- Objektrechte auf z.B. Tabellen vergeben
-- als ora_benutzer geht NICHT, weil keine Rechte vorhanden sind
SELECT * FROM "0815".lectures

-- als 0815 Benutzer das Objektrecht auf lectures für ora_benutzer gewähren
GRANT SELECT ON lectures TO ora_benutzer;

-- jetzt kann man als ora_benutzer auf "0815".lectures zugreifen
select * from "0815".lectures;

-- Rechte können wieder entzogen werden
REVOKE SELECT ON lectures FROM ora_benutzer;





-- Welche Rechte hat ein User
-- Systemprivilegien
select * from user_sys_privs;
select * from dba_sys_privs;
select * from session_privs;


-- Objektprivilegien
select * from all_tab_privs;
select * from user_tab_privs;
select * from dba_tab_privs;




-- Welche Rollen gibt es?
SELECT * FROM dba_roles;

-- Welche System- und Objektprivilegien wurden einer Rolle zugewiesen
select * from role_sys_privs;
select * from role_tab_privs;
select * from role_role_privs;


-- Welche System- und Objektprivilegien wurden einer Rolle gegeben? 
-- Wurden einer Rolle noch weitere Rollen zugewiesen?

select * from role_sys_privs where role = 'STUDENT_ROLE';
select * from role_tab_privs where role = 'STUDENT_ROLE';
select * from role_role_privs where role = 'STUDENT_ROLE';


-- Welche Rollen hat der User ora_benutzer erhalten
select * from dba_role_privs where grantee = '0815';


-- Rollen anzeigen
SELECT DISTINCT role FROM role_tab_privs;


-- Rechte der Rollen anzeigen
select * from role_tab_privs where role='SELECT_CATALOG_ROLE';

