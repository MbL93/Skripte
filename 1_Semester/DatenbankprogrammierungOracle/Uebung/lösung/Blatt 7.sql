-- Blatt 7
-- Info: In Aufgabe 2 soll Aufgabe 1 mithilfe von Identitätsspalten umgesetzt werden

-- Aufgabe 2

CREATE SEQUENCE r_id_seq
START WITH 999 -- könnte weggelassen werden weil MINVALUE gesetzt ist
INCREMENT BY 2
MINVALUE 999
MAXVALUE 1003
CYCLE
CACHE 2
ORDER; -- sonst könnte passieren dass der nextval out of order ausgegeben wird

SELECT r_id_seq.nextval FROM dual;

DROP SEQUENCE r_id_seq;

CREATE TABLE r (
    id integer default r_id_seq.nextval primary key, -- integer entspricht NUMBER(38)
    datum date default sysdate, -- standardmäßig aktuelles Datum
    text10 varchar2(10),
    zahl number(5,2),
    ctext char(10) -- wenn kürzer als 10 Zeichen wird mit Leerzeichen aufgefüllt
);

INSERT INTO r (text10, zahl, ctext) VALUES ('text', 0, 'ctext');
INSERT INTO r (datum, text10, zahl, ctext) VALUES (TO_DATE('13.12.2018', 'dd.mm.yyyy'), 'text', 0, 'ctext');
INSERT INTO r (datum, text10, zahl, ctext) VALUES (DATE '2018-12-13', 'text', 0, 'ctext');

SELECT * FROM r;
DROP TABLE r;

-- Aufgabe 2
CREATE TABLE r2 (
    id integer GENERATED ALWAYS AS IDENTITY (
        START WITH 999 -- könnte weggelassen werden weil MINVALUE gesetzt ist
        INCREMENT BY 2
        MINVALUE 999
        MAXVALUE 1003
        CYCLE
        CACHE 2
        ORDER
    ) primary key,
    datum date default sysdate,
    text10 varchar2(10),
    zahl number(5,2),
    ctext char(10)
);

INSERT INTO r2 (text10, zahl, ctext) VALUES ('text', 0, 'ctext');

SELECT * FROM r2;


-- Aufgabe 3
CREATE TABLE kunde (
    kundenid integer primary key,
    name varchar2(20) NOT NULL
);

CREATE OR REPLACE TYPE autorenname as table of varchar2(20);
/

create table verkauftesbuch (
    buchid integer primary key,
    autorennamen autorenname,
    kundenid integer NOT NULL references kunde(kundenid)
)
nested table autorennamen store as autorennamen_tab;
/

-- letzte Aufgabe freiwillig, deshalb vermutlich nicht prüfungsrelevant