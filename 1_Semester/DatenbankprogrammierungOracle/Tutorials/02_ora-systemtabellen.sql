-- Dynamic Performance Views

-- laufende DB-Instanz
select * from v$database;

-- DB-Parameter
select * from v$parameter;

-- angefragte SQL statements
select * from v$sql;

-- clear v$sql als DB-Admin
alter system flush shared_pool;


-- Data Dictionary Views


-- Infos über die in der DB vorhandenen Tabellen
-- liefert genau das gleiche wie SELECT * FROM DBA_TABLES;
SELECT * FROM sys.DBA_TABLES;

-- Tabellen des aktuellen Users
SELECT * FROM sys.USER_TABLES;


-- Welche Rechte hat die SELECT_CATALOG_ROLE
select * 
from role_tab_privs
where role='SELECT_CATALOG_ROLE';

-- Wer hat die Rolle SELECT_CATALOG_ROLE?
select *
from dba_role_privs
where granted_role='SELECT_CATALOG_ROLE';


-- Besser: alle Rollen
select * from dba_roles;

-- Rechte in den Rollen
select * from role_sys_privs;







