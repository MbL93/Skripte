-- Übungsblatt 10 



---------------------------------------------------
-- Aufgabe 1, Bäume
-- a) 
CREATE TABLE TREE (NODE_NAME VARCHAR2(32) PRIMARY KEY, LFT INTEGER NOT NULL, RGT INTEGER NOT NULL);

-- b)
NODE_NAME	LFT	RGT
Fauna		1	12
Wirbeltiere	2	9
Säugetiere	3	4
Echsen		5	6
Fische		7	8
Schalentiere	10	11

INSERT INTO TREE VALUES('Fauna', 1, 12);
INSERT INTO TREE VALUES('Wirbeltiere',2,9);
INSERT INTO TREE VALUES('Säugetiere',3,4);
INSERT INTO TREE VALUES('Echsen',5,6);
INSERT INTO TREE VALUES('Fische',7,8);
INSERT INTO TREE VALUES('Schalentiere',10,11);

-- c) Vorgänger von Echsen
SELECT NODE_NAME FROM TREE WHERE LFT<5 AND RGT>6;

-- d) Nachfolger von Wirbeltiere
SELECT NODE_NAME FROM TREE WHERE LFT>2 AND RGT<9;

-- e) Einfügen von Saurier rechts von Säugetiere
-- Platz für den neuen Knoten
update tree
set rgt = rgt + 2
where rgt > 4;

update tree
set lft = lft + 2
where lft > 4;

-- Einfügen
insert into tree values('Saurier', 5,6);


-- f) Insekten unter Schalentiere einfügen
UPDATE tree
SET lft = lft + 2
 WHERE lft > 13;

UPDATE tree
   SET rgt = rgt+2 WHERE rgt >= 13;

INSERT INTO tree VALUES ('Insekten', 13, 14);


-- g Teilbaum Wirbeltiere löschen
-- Wirbeltiere (2,11)
undefine v_move;
def v_move = 10;

-- Knoten inkl. Kinder löschen
delete from tree
where lft between 2 and 11;

-- restliche Knoten verschieben
update tree 
set lft = lft - &v_move
where lft > 11;

update tree
set rgt = rgt - &v_move
where rgt > 2;

select * from tree;




---------------------------------------------------
-- Aufgabe 2, Nested Sets

-- a)
create table personal as select * from personal3;

-- b)
update personal
set lft = lft + 1
where lft >= 1;

update personal
set rgt = rgt + 1
where rgt >= 1;

insert into personal values('Page', 1 ,18);

-- c)
select tmp.name, sub.lvl 
from
(SELECT n.lft as id,
    COUNT(*) AS lvl
    FROM personal  n,
         personal  p
   WHERE n.lft BETWEEN p.lft AND p.rgt
GROUP BY n.lft
ORDER BY n.lft) sub,
personal tmp
where sub.id = tmp.lft;







