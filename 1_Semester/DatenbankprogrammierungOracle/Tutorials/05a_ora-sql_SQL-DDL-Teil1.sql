SQL-DDL
-- Number
create table test_number (n5 number(5), n51 number(5,1), n52 number(5,2), n53 number(5,3), n5m2 number(5,-2));

insert into test_number values(123.89,123.89,123.89,123.89,123.89);
select * from test_number;

drop table test_number;

-- Default Werte
create table test_default(nr number(5) default 1, nr2 integer);
drop table test_default;

insert into test_default(nr2) values(4);
select * from test_default;

select extract (year from sysdate) from dual;
select trunc(sysdate) from dual;
select to_char(sysdate, 'yyyy') from dual;

-- Sequenzen
create sequence pk_sequenz
increment by 2
start with 4;

create table test_sequenz(nr1 integer primary key, nr2 integer);
insert into test_sequenz values(pk_sequenz.nextval, 1);

select pk_sequenz.nextval from dual;
select pk_sequenz.currval from dual;

select * from test_sequenz;

drop sequence pk_sequenz;
drop table test_sequenz;


-- Synonyme
select * from used_cars_in_stock;
drop table used_cars_in_stock;

-- was ist, wenn man eine Tabelle mit dem gleichen Namen erstellt?
create table used_cars_in_stock(id integer primary key);
select * from used_cars_in_stock;
-- Wie kann man wieder auf die anderen Daten zugreifen?
select * from dbAdmin.used_cars_in_stock;
