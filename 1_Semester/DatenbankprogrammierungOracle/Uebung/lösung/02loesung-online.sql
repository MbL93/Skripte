-- Blatt 1
-- Aufgabe 1, Tablespaces

-- a) 
CREATE TABLESPACE my0815tablespace
DATAFILE '/.../0815tablespace.dbf'
SIZE 5000K
AUTOEXTEND ON NEXT 1M
PERMANENT;

-- b)
SELECT DISTINCT name FROM v$datafile;


-- c)
SELECT default_tablespace
FROM user_users
WHERE username = '<matrikelnummer>';

-- d)
SELECT * FROM user_free_space;

------------------------------------------------
-- Aufgabe 2, SGA (Oracle)
SELECT * FROM v$sgainfo;
   
-- oder
  
-- im SQLDeveloper
SHOW sga;




------------------------------------------------
-- Aufgabe 2: SQL

SELECT 'A', b0.kunde, b0.datum, b0.betrag
  FROM bestellungen b0
  WHERE b0.datum = (SELECT MAX(b2.datum) FROM bestellungen b2 WHERE b0.kunde = b2.kunde)

UNION 

SELECT 'B', b0.kunde, b0.datum, b0.betrag
FROM bestellungen b0
WHERE b0.datum = (
  SELECT MAX(b1.datum)
  FROM bestellungen b1
  WHERE b1.datum < (SELECT MAX(b2.datum) FROM bestellungen b2 WHERE b0.kunde = b2.kunde) AND
        b0.kunde = b1.kunde
)
ORDER BY kunde, datum DESC;


