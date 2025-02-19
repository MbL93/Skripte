-- Oracle SQL Funktionen:

select * from forum;

-- Zeichenketten-Funktionen

-- instr
select instr('testerter', 'te', 1) from dual;
select instr('testerter', 'te', 1, 2) from dual;

-- substr
select substr('tester', 4, 2) from dual;

-- Konkatenation
select autor || ':' || text as info from forum;

-- Hängt an par links so oft fill an, bis eine Länge von len erreicht ist. Standard Leerzeichen
select autor || lpad(text, 50) as info from forum;

-- rpad: Hängt an par rechts so of fill an, bis eine Länge von len erreicht ist. Standard Leerzeichen
select autor || ' ' || rpad(text, 50, '*') as info from forum;

-- replace: Erstetzt alle Vorkommen von @ in text durch <no-spam>@
select autor, replace(text, '@', '<no-spam>@') from forum;

-- trim: entfernt Zeichen am Rand (BOTH, LEADING, TRAILING)
select trim(trailing 'a' from autor) from forum;

-- soundex: liefert phonetische Darstellung des Eingabestrings zurück
-- Algorithmus nach D. E. Knuth 
select autor, soundex(autor) from forum;
select * from forum where soundex(autor) = soundex('Maier');

-- translate
select translate('torso', 'tso', 'efg') from dual;



create table tt(ts timestamp);
drop table tt;
insert into tt values(current_timestamp);
select * from tt;
select extract(hour from ts) from tt;
select trunc(ts) from tt;



-- Abfrage von Verbindungseigenschaften: SYS_CONTEXT
-- DB_NAME, HOST, INSTANCE_NAME, IP_ADDRESS, ISDBA, LANGUAGE, ...
select sys_context('USERENV', 'LANGUAGE') from dual;
select sys_context('USERENV', 'HOST') from dual;





-- Datumsfunktionen
insert into datum_test values('11.10.2018', '13.12.2018'); 


select * from datum_test;

-- months_between
select datum, datum2, months_between(datum2, datum) from datum_test;

-- add_months
select datum, add_months(datum, 12) from datum_test;

-- next_day: Nächster Wochentag nach datum
select datum, next_day(datum, 'Mon') from datum_test;

-- last_day: letzter Tag des Monats in dem sich datum befindet
select datum, last_day(datum) from datum_test;


-- extract
select datum, extract(day from datum) as Tag, extract(year from datum) as Jahr
from datum_test;

-- Datumsfunktionen
-- Wochentag zu Datum
select sysdate, to_char(sysdate, 'DAY') from dual;

-- Monat als römische Zahl
select sysdate, to_char(sysdate, 'RM') from dual;

select sysdate, to_char('1999', 'RM') from dual;

-- Woche des Jahres
select sysdate, to_char(sysdate, 'WW') from dual;

-- Spielerei
-- TH -> Zahl als Ordnungszahl
-- SP -> Ordnungszahl wird ausgeschrieben
select datum, to_char(datum, 'MONTH "the" DTHSP "in" YEAR') from datum_test;

-- Sonstige Funktionen
-- greatest berechnet das Maximum der angegebenen Parameter
-- least berechnet das Minimum der angegebenen Parameter
select greatest(1,4,6,92) as gr, 
       least(1, 4, 6, 92) as le
from dual;


