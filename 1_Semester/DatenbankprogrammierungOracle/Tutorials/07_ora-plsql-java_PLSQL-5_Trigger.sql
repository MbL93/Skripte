-- Aktive Inhalte in Oracle
-- Trigger und PL/SQL

-- Duplikate
-- Wann immer ein Datensatz mit ID1 > 200 in TAB1 eingefügt wird, 
-- soll automatisch davon eine Kopie in TAB2 abgelegt werden.
create table tab1(ID1 integer, text1 varchar(200));
create table tab2(ID2 integer, text2 varchar(200));

CREATE OR REPLACE TRIGGER duplikate 
AFTER INSERT ON tab1 
FOR EACH ROW 
WHEN (new.ID1 > 200) 
BEGIN 
INSERT INTO tab2 VALUES (:new.ID1,:new.Text1);  -- :new 
END; 

insert into tab1 values(1, 'text 1');
select * from tab1;
select * from tab2;
insert into tab1 values(201, 'text 201');




