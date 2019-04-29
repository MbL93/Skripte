alter session set "_ORACLE_SCRIPT"=true;

create table Auftrag (
id integer primary key,
kundennr integer not null
);

create table besteht_aus(
artikelnr integer primary key,
auftragid integer not null references auftrag(id)
);

alter table auftrag add constraint artikel_mandatory CHECK(
    (select count(*) from besteht_aus where auftragid = id) > 0
);

create table artikel(
nr integer primary key references besteht_aus(artikelnr),
liefereantennr varchar2(100) not null
);

alter table besteht_aus add constraint besteht_aus_artikel_fk
foreign key (artikelnr) references Artikel(nr)
deferrable initially deferred; -- sonst kann man nichts einfügen (zuerst Artikel einfügen, dann besteht_aus)

-- zum löschen
alter table besteht_aus drop constraint besteht_aus_artikel_fk;
drop table besteht_aus;


-- Aufgabe 3b
alter table kunde add kundentyp char(5) not null;
alter table kunde add constraint ch_inh_kunde check(kundentyp in ('Priv', 'Gesch')); -- um Kunden zu erlauben, die nicht priv oder gesch sind, dritten Typ hinzufügen
alter table kunde add constraint constraint un_kunde unique (kundenNr, kundentyp);

alter table privatkunde add kundentyp char(5) not null;
alter table privatkunde add constraint ch_in_privatkunde check (kundentyp in ('Priv'));
alter table privatkunde add constraint privatkunde_kunde_fk foreign key (kundennr, kundentyp) references Kunde(kundennr, kundentyp);
-- selbes für Geschäftskunde