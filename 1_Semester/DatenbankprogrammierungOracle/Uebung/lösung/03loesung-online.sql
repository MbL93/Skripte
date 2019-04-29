-- Übungsblatt 3, Lösungshinweise

-- Aufgabe 1, Systemtabellen
-- a)
select * from dba_role_privs where granted_role = 'STUDENT_ROLE';

-- b)
select * from role_tab_privs where role = 'STUDENT_ROLE';

-- c)
select * from DBA_views where view_name like 'V$%';

-- Grund: Die meisten der Views haben intern das Präfix V_$ statt V$. 
-- Abhilfe: Entweder nach V_$ fragen oder

select * from DBA_synonyms where synonym_name like 'V$%';




-- Aufgabe 2: SQL Puzzle

SELECT Auftrag
FROM Projekte P1
WHERE Abschnitt = 0
AND Status = 'C'
AND 'R' = ALL (SELECT Status
			FROM Projekte P2
			WHERE Abschnitt <> 0
			AND P1.Auftrag = P2.Auftrag);




-- Aufgabe 3: Views
-- a) Views auf Views OK, keine Zyklen erlaubt.
-- b) 
-- - FROM-Klausel enthält genau eine Relation, die updatable ist (normale Relation oder updatable View) 
-- - kein ORDER BY, GROUP BY, HAVING, DISTINCT, Mengenoperationen, arithmetische Operationen, Aggregatsfunktionen, Subqueries 
-- - die Option WITH READ ONLY wurde nicht angegeben
-- 
-- c)
-- - explizit: DROP VIEW <name> 
-- - implizit: bei Löschen einer Basisrelation oder eines Views, auf die sich der View abstützt. War in älteren Oracle-Versionen möglich. In neueren Versionen bleibt der View ohne Basisrelation vorhanden!
-- 
-- d)
-- i) Ja
-- ii) Ja, sofern die neuen Daten die WHERE Klausel erfüllen, Stichwort WITH CHECK OPTION.
-- iii) Bei ``ausgeblendeten'' NOT NULL-Attributen ist nicht klar, welchen Wert es bei einem INSERT auf den View bekommen soll. Fehler.



