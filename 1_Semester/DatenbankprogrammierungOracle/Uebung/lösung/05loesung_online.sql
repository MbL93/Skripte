-- Übungsblatt 5 - Lösungshinweise



------------------------------------------------
-- Aufgabe 1: Modellierung eines öffentlichen Verkehrsbetriebs
Vergleiche vga.pdf

Den zentralen Modellierungsaspekt bilden die Fahrten. Sie werden durch das mehrwertige Attribut Datumsangaben (z.B. Sa, So, wochentags, ...) und das Schlüsselattribut FahrtNr modelliert.

Fahrten unterliegen einem Fahrplan und bestehen aus mehreren Teilstücken, Die Teilstücke werden als schwache Entität modelliert, da die Teilstücke erst durch das Schlüsselattribut FahrtNr der Entität Fahrten eindeutig identifiziert werden.

Für eine Fahrt werden Fahrzeuge, im unserem Fall Straßenbahnen oder Busse eingesetzt. Neben dem Schlüsselattribut FahrzeugNr speichern wir auch Angaben, wieviele Personen befördert werden können bzw. zum Maximalgewicht. Das optionale Attribut Spezialausstattung kann Angaben enthalten, wie z.B. ob die Straßenbahn zur Partystraßenbahnen umfunktioniert ist.

Durchgeführt werden die Fahrten von einem Fahrer, der Angestellter des Verkehrsbetriebes ist. Vom Fahrer wollen wir auch seine Führerscheinklassen wissen. Daneben beschäftigt der Verkehrsbetrieb auch Angestellte, die in der Verwaltung tätig sind.


------------------------------------------------
-- Aufgabe 2:
Hier gibt es soviele Lösungsvorschläge, so dass hier keiner vorgestellt wird.




------------------------------------------------
-- Aufgabe 3: Ternäre Relationship
Vergleiche bineare_relation.pdf


Die Abbildung 'binaere_relation.pdf' zeigt einen Ansatz, die tenäre Beziehung 'prüfen' druch binäre Relationen auszudrücken. Durch die ursprüngliche Modellierung (Abbildung 1 auf dem Aufgabenblatt) wird folgende Konsistenzbedingung ausgedrückt:

	prüfen : Studenten x Vorlesungen ---> Professoren

Demgegenüber tritt bei der vorgeschlagenen Modellierung mittels binärer Relationen ein Semantikverlust auf. Durch die allgemeinere $N:M$-Beziehungen wird obige Konsistenzbedingung nicht mehr abgebildet. Somit ist das Modell der ternären Beziehung in diesem Fall ausdrucksstärker. Zwar lassen sich Prüfungsergebnisse in der alternativen Modellierung abbilden, allerdings geht Aussagekraft verloren. Abgebildet ist, dass Studenten über den Stoff der Vorlesung geprüft werden, sowie dass Studenten von Professoren geprüft werden. Der Zusammenhang, welche Professoren welche Studenten in welchen Vorlesungen prüfen, ist nicht mehr ohne weiteres gegeben. Indirekt lösen lässt sich dies durch die Aufnahme des zusätzlichen Attributs 'Prüfungszeit' in die Relation 'über' und auch in 'prüft'. Da der zusätzlich aufgeführte Prüfungstermin eine Prüfung eindeutig festlegt, lässt sich die Information über eine Prüfung aus beiden Relationen erhalten. Allerdings muss für eine konsistente Extension sichergestellt werden, dass zu einem Eintrag in 'über' ein passender Eintrag in 'prüft' enthalten ist. Die gezeigte alternative Modellierung weist also klare Nachteile gegenüber der ursprünglichen ternären Beziehung auf. 





-----------------------------------
-- Aufgabe 4
-- Zyklische Constraints
CREATE TABLE Person ( 
 Name  VARCHAR(20) PRIMARY KEY, 
 PRest VARCHAR(20) NOT NULL); 

CREATE TABLE Handy ( 
 Nr    INTEGER PRIMARY KEY, 
 HRest VARCHAR(20) NOT NULL); 

CREATE TABLE R ( 
 HNr   INTEGER NOT NULL REFERENCES Handy(Nr), 
 PName VARCHAR(20) NOT NULL REFERENCES Person(Name), 
 A     VARCHAR(20) NOT NULL ,
 PRIMARY KEY (HNr, PName)
); 


ALTER TABLE Person ADD CONSTRAINT PersonR_FK 
	FOREIGN KEY (Name) REFERENCES R(PName) DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE HANDY ADD CONSTRAINT HandyR_FK 
	FOREIGN KEY (Nr) REFERENCES R(HNr) DEFERRABLE INITIALLY DEFERRED;

-- Problem: add constraints geht nicht bei Oracle, da HNr und PName in R keine
-- unique / primary keys sind. Würde man die Attribute unique machen wäre die n:m
-- Beziehung verletzt, d.h. eine Person kann nicht mehrere Handys haben.
-- Lösung: Trigger (werden in einem späteren Kapitel in der VL besprochen).

-- ALTER TABLE Person DROP CONSTRAINT PersonR_FK;
-- ALTER TABLE Handy DROP CONSTRAINT HandyR_FK;

SET AUTOCOMMIT OFF;
-- SET CONSTRAINTS PersonR_FK, HandyR_FK DEFERRED;
-- Einfügen der Daten. Achtung: obige Constraints werden nicht geprüft.
INSERT INTO Person VALUES('endres', 'e_rest');
INSERT INTO Person VALUES('mandl', 'm_rest');

INSERT INTO Handy VALUES(123, 'h_rest');
INSERT INTO Handy VALUES(456, 'h_rest');

INSERT INTO R VALUES (123, 'endres', 'e_a');
INSERT INTO R VALUES (456, 'mandl', 'm_a');
COMMIT;




------------------------------------------------
-- Aufgabe 5: Subqueries
SELECT t.veranstaltung
FROM teilnahme t, student s
WHERE s.name = 'Maier'
  AND s.matrikelnr = t.student;

