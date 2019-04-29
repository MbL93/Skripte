-- Übungsblatt 7, Lösungshinweise



-----------------------------------
-- 1), ER-Modellierung

create table Gebäude (
  GebNr INTEGER PRIMARY KEY,
  Höhe NUMBER NOT NULL,
  CHECK ((SELECT COUNT(*) FROM Raum WHERE Raum.GebNr = GebNr) > 0);
);

-- besser wäre folgende Anweisung nach Erstellung der Tabelle Raum:
ALTER TABLE Gebäude ADD CONSTRAINT ch_raum_exists CHECK ((SELECT COUNT(*) FROM Raum WHERE Raum.GebNr = GebNr) > 0);

create table Ausgänge (
	Ausgang VARCHAR(20) NOT NULL,
	GebNr INTEGER NOT NULL REFERENCES Gebäude,
	PRIMARY KEY(Ausgang, GebNr)
);

CREATE TABLE Raum (
  RaumNr INTEGER NOT NULL,
  GebNr INTEGER NOT NULL REFERENCES Gebäude,
  Fläche NUMBER NOT NULL,
  PRIMARY KEY(RaumNr, GebNr)
);



-- oder mit Hilfe von NESTED TABLES:
CREATE TYPE Ausgänge AS TABLE OF VARCHAR(20);

CREATE TABLE Gebäuede (
  GebNr INTEGER PRIMARY KEY,
  Höhe NUMBER NOT NULL,
  Ausgang Ausgänge,  
  CHECK ( (SELECT COUNT(*) 
           FROM Raum 
	   WHERE Raum.GebNr = GebNr) > 0
  ) NESTED TABLE Ausgang STORE AS Ausgang_tab;


CREATE TABLE Raum (
  RaumNr INTEGER NOT NULL,
  GebNr INTEGER NOT NULL REFERENCES Gebäude,
  Fläche NUMBER NOT NULL,
  PRIMARY KEY(RaumNr, GebNr)
);




-----------------------------------
-- 2) RegExp 

-- Mailadressen
select * from forum
where regexp_like(text,'[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$');


-- besser ist: 
select * from forum
where regexp_like(text,'[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,63}', 'i');

-- -> ausbaufähig, z.B. zu
SELECT * FROM forum
where regexp_like(text,'(^|\s|\()[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,63}($|\s|[[:punct:]])', 'i');


-- Internetadressen
-- Ausbaufähig!
select * from forum where regexp_like(text, '(http(s)?://)+|(www.)+');

-- Allerdings: Obiges würde auch 'wwwawwwbwwwc' matchen (da '.' nicht durch '\' escaped ist).

-- Es sollten Adressen gematched werden, die mit http://, https:// oder mit www. anfangen
-- also z.B. 'abc.abc' nicht, aber 'www.abc.abc' schon)
-- wäre eine etwas bessere Lösung:

SELECT * FROM forum WHERE REGEXP_LIKE(text, '((https?://)|(www\.))[a-z0-9.-]+\.[a-z]{2,63}', 'i');

-- Reguläre Ausdrücke für Emails und Internetadressen sind natürlich immer noch ausbaufähig und bei weitem nicht RFC-konform (z.B. wird 'http://-25google.......de' als eine Adresse erkannt, doch um das zu verhindern, wäre die Lösung viel länger). 








