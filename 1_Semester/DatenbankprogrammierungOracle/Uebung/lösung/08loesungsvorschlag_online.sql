-- Übungsblatt 8, Lösungshinweise




-----------------------------------
-- 1) Sequenzen
create table R(id integer primary key, datum date default sysdate, text10 varchar(10), zahl number(5,2), ctext char(10));
              
-- drop table R;              
              
create sequence r_pk          
increment by 2
start with 999
minvalue 999
maxvalue 1003
cycle
cache 2   -- Cache muss kleiner als Intervall der Inkrement-Werte sein.
order;

insert into R(id, text10, zahl, ctext) values(r_pk.nextval, 'text', 0, 'ctext');
insert into R(id, text10, zahl, ctext) values(r_pk.nextval, 'text1', 1, 'ctext1');
insert into R(id, text10, zahl, ctext) values(r_pk.nextval, 'text2', 2, 'ctext2');
-- geht natürlich nicht wegen Primary Key auf ID
insert into R(id, text10, zahl, ctext) values(r_pk.nextval, 'text3', 3, 'ctext3');

select * from R;

drop table R;
drop sequence r_pk;


-- Anmerkung zu Date
insert into ... values(3, to_date('19.11.2012', 'dd/mm/yy'));
-- oder 
insert into ... values(2, '12-NOV-012');


-----------------------------------
-- 2) Identity Columns
-- Selbsterklärend :-)



-----------------------------------
-- 3), Nested Tables
create or replace type autorname_type as table of varchar(20);

create table kunde(kundenid integer primary key, name varchar(20) not null);

create table verkauftesbuch ( 
  buchid integer primary key,
  autorname autorname_type)
nested table autorname store as autorname_tab;

create table verkauft_an ( 
  rbuchid integer primary key references verkauftesbuch(buchid), 
  rkundenid integer not null references kunde(kundenid)
);

alter table verkauftesbuch add constraint vb_fk_va foreign key (buchid) references verkauft_an(rbuchid);

-- löschen
alter table verkauftesbuch drop constraint vb_fk_va;
drop table verkauft_an;
drop table verkauftesbuch;
drop table kunde;








---------------------------------------------------
-- 4), Objekte in Oracle
-- a)
DROP TYPE publication_obj;
DROP TYPE keyword_obj;
DROP TABLE publication_table;
DROP TABLE keyword_table;
DROP TABLE contains;

CREATE TYPE publication_obj AS OBJECT
(title varchar(20), code integer, publisher varchar(20));
CREATE TYPE keyword_obj AS OBJECT
(title varchar(20), code integer, research_area varchar(100));



CREATE TABLE publication_table OF publication_obj (PRIMARY KEY(code));
CREATE TABLE keyword_table OF keyword_obj(PRIMARY KEY(code));



CREATE TABLE contains(
	pub REF publication_obj REFERENCES publication_table,
	key REF keyword_obj REFERENCES keyword_table
);

-- b)
INSERT INTO publication_table values(publication_obj('Titel 1', 1, 'Publisher 1'));
INSERT INTO keyword_table values(keyword_obj('Titel 1', 1, 'Research Area 1'));

INSERT INTO CONTAINS SELECT REF(p), REF(k)
FROM publication_table p, keyword_table k WHERE p.code = k.code;
-- select c.pub.code, c.key.code from contains c;

-- c)-
-- unguenstig gewaehltes Beispiel
SELECT p.*, k.*
FROM publication_table p, keyword_table k, contains c
WHERE p.code = c.pub.code AND k.code = c.key.code;











