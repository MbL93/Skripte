-- Oracle Kapitel 6, Bäume
-- Bäume mit Verweis aus Chef / Angestellten
CREATE TABLE personal (
	emp VARCHAR(20) PRIMARY KEY,
	boss VARCHAR(20) DEFAULT NULL REFERENCES personal (emp),
	salary DECIMAL(6,2) NOT NULL
);


-- insert data
insert into personal values('Albert', NULL, 1000);
insert into personal values('Bert', 'Albert', 900);
insert into personal values('Chuck', 'Albert', 900);
insert into personal values('Donna', 'Chuck', 800);
insert into personal values('Eddie', 'Chuck', 700);
insert into personal values('Fred', 'Chuck', 600);


-- Finde den direkten Chef für jeden Angestellten, Self-Join
SELECT b1.emp, 'ist Chef von', e1.emp
FROM personal b1, personal e1
WHERE b1.emp = e1.boss;

-- viel einfacher für 2 Ebenen
select boss, ' ist Chef von ', emp
from personal where boss is not null;

-- für 2 Ebenen in der Firmenhierarchie
SELECT b1.emp, 'ist Chef von Chef von', e2.emp
FROM personal b1, personal e1, personal e2
WHERE b1.emp = e1.boss
AND e1.emp = e2.boss;



-- für 3 Ebenen in der Firmenhierarchie
-- liefert auf obigem Beispiel-Datensatz kein Ergebnis, da es 3 Hierarchien sind.
SELECT b1.emp, 'ist Chef von Chef von Chef von ', e3.emp
FROM personal b1,
     personal e1,
     personal e2,
     personal e3
WHERE b1.emp = e1.boss
AND   e1.emp = e2.boss
AND   e2.emp = e3.boss;








-- Nested Sets
-- zuerst die alte Tabelle personal löschen
drop table personal;

CREATE TABLE personal (
emp VARCHAR(20) PRIMARY KEY,
salary DECIMAL(6,2) NOT NULL,
lft INTEGER NOT NULL UNIQUE CHECK (lft > 0),
rgt INTEGER NOT NULL UNIQUE CHECK (rgt > 1)
);


ALTER TABLE personal ADD CONSTRAINT orderOKAY
CHECK (lft < rgt);

-- Daten einfügen
insert into personal values('Albert', 1000, 1, 12);
insert into personal values('Bert', 900, 2, 3);
insert into personal values('Chuck', 900, 4, 11);
insert into personal values('Donna', 800, 5, 6);
insert into personal values('Eddie', 700, 7, 8);
insert into personal values('Fred', 600, 9, 10); 



-- Blätter ermitteln 
select * from personal where rgt - lft = 1;







-- einen Bruder rechts einfügen
-- Platz für den neuen Knoten

-- Anmerkungen
-- mit :brother_rgt wird im SQL Developer nach dem Inhalt der Variablen gefragt
-- hier wird dieser Wert auf 3 gesetzt, da RGT von Bert = 3
UPDATE personal
SET rgt = rgt+2
WHERE rgt > :brother_rgt;

UPDATE personal
SET lft = lft + 2
WHERE lft > :brother_rgt;

-- Einfügen des neuen Mitarbeiters
INSERT INTO personal
VALUES ('Gilbert', 900, :brother_rgt+1, :brother_rgt+2);

select * from personal;






-- Einen Bruder links einfügen
-- Platz für den neuen Knoten

-- hier :brother_lft = 7
UPDATE personal
SET rgt = rgt+2
WHERE rgt >= :brother_lft;

UPDATE personal
SET lft = lft + 2
WHERE lft >= :brother_lft;

-- Einfügen des neuen Mitarbeiters
INSERT INTO personal
VALUES ('Hans', 850, :brother_lft, :brother_lft+1);

select * from personal;





-- Eddie (11,12) rauswerfen
-- hier v_lft = 11, v_rgt = 12
DELETE FROM personal 
WHERE emp = 'Eddie';

-- restliche Knoten updaten
UPDATE personal
SET lft = lft - 2
 WHERE lft > :v_rgt;

UPDATE personal
SET rgt = rgt - 2
 WHERE rgt > :v_lft;


select * from personal;






-- Knoten inkl. Kinder löschen
-- Abteilung von Chuck (6,13) löschen
DELETE FROM personal
WHERE lft between :v_lft AND :v_rgt;

undefine v_move;
def v_move = 8;
-- 1. v_move := floor((v_rgt - v_lft)/2);
-- 2. v_move := 2 * (1 + v_move);

-- restliche Knoten verschieben
UPDATE personal
SET lft = lft - &v_move
 WHERE lft > :v_rgt;

UPDATE personal
SET rgt = rgt - &v_move
 WHERE rgt > :v_lft;





-- Erweiterung um ein Blatt
-- Klaus (3,4) wird hinzugefügt unter Bert (2,3)

UPDATE personal
SET lft = lft + 2
 WHERE lft > :v_rgt;

UPDATE personal
   SET rgt = rgt + 2 WHERE rgt >= :v_rgt;

INSERT INTO personal VALUES ('KLAUS', 800, :v_rgt, :v_rgt+1);

select * from personal;






-- Typische Anfragen
delete from personal;


CREATE TABLE personal333 (
emp VARCHAR(20) PRIMARY KEY,
salary DECIMAL(6,2) NOT NULL,
lft INTEGER NOT NULL UNIQUE CHECK (lft > 0),
rgt INTEGER NOT NULL UNIQUE CHECK (rgt > 1)
);


ALTER TABLE personal ADD CONSTRAINT orderOKAY
CHECK (lft < rgt);


insert into personal values('Albert', 1000, 1, 16);
insert into personal values('Bert', 900, 2, 3);
insert into personal values('Chuck', 900, 6, 15);
insert into personal values('Donna', 800, 9, 10);
insert into personal values('Eddie', 700, 11, 12);
insert into personal values('Fred', 600, 13, 14); 
insert into personal values('Gilbert', 900, 4, 5);
insert into personal values('Hans', 850, 7, 8);



select * from personal;


-- Finde die Mitarbeiter von Chuck
SELECT b.emp boss, e.emp emp
FROM personal b, personal e
WHERE e.lft BETWEEN b.lft AND b.rgt
  AND e.rgt BETWEEN b.lft AND b.rgt
  AND b.emp = 'Chuck';



-- Finde alle Chefs von Eddie und die Anzahl derer Mitarbeiter
SELECT e.emp emp, b.emp boss,
       FLOOR((b.rgt - b.lft) /2 ) ang
FROM personal b, personal e
WHERE e.lft BETWEEN b.lft AND b.rgt
  AND e.rgt BETWEEN b.lft AND b.rgt
  AND e.emp = 'Eddie';
