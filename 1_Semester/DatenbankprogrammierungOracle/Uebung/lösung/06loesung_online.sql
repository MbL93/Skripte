-- Übungsblatt 6, Lösungshinweise



------------------------------------------------
-- Aufgabe 1: ER nach SQL (1)
-- Relationen erstellen
CREATE TABLE Auftrag ( 
 ID INTEGER PRIMARY KEY, 
 KundenNr INTEGER NOT NULL
 CHECK ((SELECT COUNT(*)
		 FROM besteht_aus
     	 WHERE ID = BID) > 0)
); 

CREATE TABLE besteht_aus ( 
 BNr INTEGER PRIMARY KEY, 
 BID INTEGER NOT NULL REFERENCES Auftrag(ID)
);

CREATE TABLE Artikel ( 
 Nr INTEGER PRIMARY KEY REFERENCES besteht_aus(BNr), 
 LieferantenNr VARCHAR(100) NOT NULL
 ) 

ALTER TABLE besteht_aus ADD CONSTRAINT fk_bnr 
	FOREIGN KEY (BNr) REFERENCES Artikel(Nr);




------------------------------------------------
-- Aufgabe 2: ER nach SQL (2)

CREATE TABLE MannschaftUndTrainer (
	Name VARCHAR(100) PRIMARY KEY,
	Geburtsdatum DATE NOT NULL,
	Vereinsname VARCHAR(100) UNIQUE, -- NULL erlauben
	Stadt VARCHAR(100), -- NULL erlauben
	
	CHECK (
	-- keine Mannschaft erlauben (und damit kein Attribut von Mannschaft):
	(Vereinsname IS NULL AND Stadt IS NULL) OR
	Vereinsname IS NOT NULL
	)
);



-----------------------------------
-- Aufgabe 3: ER-Modellierung
-- a)
ALTER TABLE Kunde ADD CONSTRAINT fk_kunde_hat
FOREIGN KEY (KundenNr) REFERENCES hat(KundenNr);

ALTER TABLE Konto ADD CONSTRAINT fk_konto_hat
FOREIGN KEY (IBAN) REFERENCES hat(IBAN);

-- b)
-- Besser wäre ALTER TABLE ...
CREATE TABLE Kunde (
  KundenNr INTEGER PRIMARY KEY,
  KundenTyp CHAR(4) NOT NULL
  	CHECK (KundenTyp IN ('Priv', 'Gesch')),
  UNIQUE(KundenNr, KundenTyp)
);


CREATE TABLE Privatkunde ( 
  KundenNr INTEGER PRIMARY KEY, 
  KundenTyp CHAR(4) NOT NULL CHECK (KundenTyp IN ('Priv')),
  Name VARCHAR(20) NOT NULL,
  FOREIGN KEY (KundenNr, KundenTyp) REFERENCES Kunde(KundenNr, KundenTyp)
);


CREATE TABLE Geschäftskunde (
  KundenNr INTEGER PRIMARY KEY,
  KundenTyp CHAR(4) NOT NULL CHECK (KundenTyp IN ('Gesch')),
  Firma VARCHAR(20) NOT NULL,
  FOREIGN KEY (KundenNr, KundenTyp) REFERENCES Kunde(KundenNr, KundenTyp)
);





