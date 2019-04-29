alter session set "_ORACLE_SCRIPT"=true;

-- Blatt 5

-- Aufgabe 4
create table person(
    name varchar2(20) primary key,
    PRest varchar2(20) NOT NULL
);

create table handy(
    nr int primary key,
    HRest varchar2(20) NOT NULL
);

-- Problem: references handy.nr und person.name kann noch nicht gesetzt werden, weil
-- R Tabelle noch nicht existiert

create table R(
    HNr integer not null references Handy(nr),
    PName varchar2(20) not null references Person(name),
    A varchar2(20) NOT NULL,
    primary key(Hnr, pname)
);

-- foreign keys, die am Anfang ausgelassen wurden, m�ssen jetzt nachtr�glich eingef�gt werden

-- funktioniert nicht: (Begr�ndung unten)
alter table person add constraint PersonR_FK
foreign key(name) references R(pname) deferrable initially deferred;
-- deferrable hei�t, dass die Pr�fung der Constraints wird bis zum Commit verz�gert

-- funktioniert nicht: (Begr�ndung unten)
alter table handy add constraint HandyR_FK
foreign key(nr) references R(HNR) deferrable initially deferred;

-- Begr�ndung:
-- Problem: kann nur einen Prim�rschl�ssel oder unique referenzieren
-- HNr und PName ist aber nicht unique in R, weil es zusammengesetzter Schl�ssel ist


set autocommit off;

insert into Person values('tobias', 't_rest');
insert into Person values('michael', 'm_rest');

insert into Handy values(123, 'h_rest');
insert into Handy values(456, 'h_rest');

insert into R values(123, 'tobias', 't_a');
insert into R values(456, 'michael', 't_b');

commit;

drop table R;
drop table handy;
drop table person;
commit;


-- Aufgabe 5
SELECT veranstaltung FROM teilnahme
WHERE student IN (SELECT matrikelnr FROM student WHERE name = 'Maier');

-- meine L�sung
SELECT t.veranstaltung FROM teilnahme t
JOIN student s ON s.matrikelnr = t.student
WHERE s.name = 'Maier';

-- Tutor L�sung
SELECT t.veranstaltung from teilname t, student s
where s.name = 'Maier'
AND t.student = s.matrikelnr;
