-- Übungsblatt 01

-- Aufgabe 3, SQL-Auffrischung

-- alle Daten anschauen
SELECT * FROM correlated;

-- a)
-- nur im SQL Developer
DESCRIBE correlated;

-- d)
-- ROUND(n, m): n auf m Stellen gerundet
SELECT id, ROUND(val01*2)/2, ROUND(val02*2)/ 2
FROM correlated;

-- e)
SELECT id FROM correlated WHERE MOD(id,3)=0 AND ID <= 100;

-- f)
-- TRUNC(a, m): a auf m Stellen abschneiden
SELECT TRUNC(ID/100), 
           AVG(val01) as AVG1, AVG(val02) as AVG2
FROM correlated 
GROUP BY TRUNC(ID/100)
ORDER BY TRUNC(ID/100);
      




