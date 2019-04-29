-- Oracle 18
-- alter session set "_ORACLE_SCRIPT"=true;

-- Entitätstyp Land
CREATE TABLE Land (
		Name VARCHAR(20) PRIMARY KEY,
		Flaeche NUMBER,
		KFZAbkz VARCHAR(4) NOT NULL UNIQUE
	);


drop table R;
drop table Person;
drop table Handy;


-- m:n Beziehung, beide optional
CREATE TABLE Person ( 
 Name  varchar(20) PRIMARY KEY, 
 PRest varchar(20) NOT NULL); 

CREATE TABLE Handy ( 
 Nr    varchar(20) PRIMARY KEY, 
 HRest varchar(20) NOT NULL); 

CREATE TABLE R ( 
 HNr   varchar(20) NOT NULL REFERENCES Handy(Nr), 
 PName varchar(20) NOT NULL REFERENCES Person(Name), 
 PRIMARY KEY (HNr, PName)
); 



insert into Person values('Markus', 'mp_rest');
insert into Person values('Stefan', 'sp_rest');
insert into Handy values('0815', 'mh_rest');
insert into Handy values('0816', 'sh_rest');

insert into R values('0815', 'Markus');

select * from Person p, Handy h, R r
where p.name = r.pname and r.hnr = h.nr;


-- n:1 Beziehung, beide optional
drop table R;
drop table Person;
drop table Handy;

CREATE TABLE Person ( 
 Name  varchar(20) PRIMARY KEY, 
 PRest varchar(20) NOT NULL); 

CREATE TABLE Handy ( 
 Nr    varchar(20) PRIMARY KEY, 
 HRest varchar(20) NOT NULL); 

CREATE TABLE R ( 
 HNr   varchar(20) PRIMARY KEY REFERENCES Handy(Nr), 
 PName varchar(20) NOT NULL, 
); 




-- 1:1 Beziehung ohne Optionalitäten
-- Zyklische Constraints

CREATE TABLE Person ( 
 Name  varchar(20) PRIMARY KEY, 
 PRest varchar(20) NOT NULL); 

CREATE TABLE Handy ( 
 Nr    varchar(20) PRIMARY KEY, 
 HRest varchar(20) NOT NULL); 

CREATE TABLE R ( 
 HNr   varchar(20) PRIMARY KEY REFERENCES Handy(Nr), 
 PName varchar(20) NOT NULL UNIQUE REFERENCES Person(Name), 
 A     varchar(20) NOT NULL ); 

-- Constraints hinzufügen
ALTER TABLE Person ADD CONSTRAINT PersonR_FK FOREIGN KEY(Name) 
REFERENCES R(PName) DEFERRABLE;

ALTER TABLE Handy ADD CONSTRAINT HandyR_FK FOREIGN KEY(Nr) 
REFERENCES R(HNr) DEFERRABLE;

-- geht schief wegen REFERENCES
INSERT INTO person VALUES('Markus', 'MRest');
INSERT INTO handy VALUES('0815', 'rest');
INSERT INTO R VALUES('0815', 'Markus', 'A');

-- Transaktion starten
SET AUTOCOMMIT OFF;

-- Constraints auf COMMIT Zeitpunkt verschieben
SET CONSTRAINTS handyr_fk DEFERRED;
SET CONSTRAINTS personr_fk DEFERRED;

INSERT INTO person VALUES('Markus', 'MRest');
INSERT INTO handy VALUES('0815', 'rest');
INSERT INTO R VALUES('0815', 'Markus', 'A');

-- COMMIT: Constraints werden überprüft
COMMIT;


select * from R;
select * from Person;
select * from Handy;

-- Löschen der Tabellen geht nur, nachdem die Constraints gelöscht wurden
alter table handy drop constraint handyr_fk;
alter table person drop constraint personr_fk;

drop table R;
drop table person;
drop table handy;

