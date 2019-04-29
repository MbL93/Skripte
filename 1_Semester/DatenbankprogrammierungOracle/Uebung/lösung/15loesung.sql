-- Übungsblatt 15, Lösungshinweise


---------------------------------------------------
-- Aufgabe 1
CREATE OR REPLACE
	FUNCTION getProperty	(name IN VARCHAR2)
		RETURN VARCHAR2
IS
		cResult VARCHAR2(20);
BEGIN
		IF name = 'SCHEMA' THEN
			SELECT sys_context('USERENV', 'CURRENT_SCHEMA') 
					INTO cResult FROM DUAL;
		ELSIF name = 'SERVER' THEN
			SELECT sys_context('USERENV', 'IP_ADDRESS') 
					INTO cResult FROM DUAL;
		ELSIF name = 'USER' THEN
			SELECT sys_context('USERENV', 'OS_USER') 
					INTO cResult FROM DUAL;
		ELSIF name = 'DATE' THEN
			SELECT sysdate INTO cResult FROM DUAL;
		ELSIF name = 'TIME' THEN
			SELECT current_timestamp INTO cResult FROM DUAL;
		ELSE
			cResult := 'wrong result';
		END IF;
		RETURN cResult;
END getProperty;


-- SET SERVEROUTPUT ON;

DECLARE
	result varchar2(20);
BEGIN
	result := getProperty('SCHEMA');
	DBMS_OUTPUT.PUT_LINE('SCHEMA: ' || result);
	result := getProperty('SERVER');
	DBMS_OUTPUT.PUT_LINE('SERVER: ' || result);
	result := getProperty('USER');
	DBMS_OUTPUT.PUT_LINE('USER: ' || result);
	result := getProperty('DATE');
	DBMS_OUTPUT.PUT_LINE('DATE: ' || result);
END;



---------------------------------------------------
-- Aufgabe 2
-- Primzahltest für die Zahl p:
-- teste von i = 2 bis sqrt(n), ob die Zahl p durch i teilbar ist. Wenn ja, dann nicht prim. Wenn nein, dann prim.
-- Das Verfahren beruht auf der Tatsache, dass eine natürliche Zahl n (außer 1) keinen Teiler d <= sqrt(n) besitzt, prim ist. Ist nämlich n = d1*d2 mit d1, d2 natürliche Zahlen, so ist d1 <= sqrt(n) oder d2 <= sqrt(n). 


-- Spezifikation
CREATE OR REPLACE
PACKAGE PRIME
	IS
	PROCEDURE printPrimes (low INTEGER, up  INTEGER);
END PRIME;

-- Implementierung (Rumpf)
CREATE OR REPLACE PACKAGE BODY PRIME
 IS
FUNCTION isPrime (num IN INTEGER )
	RETURN BOOLEAN
	IS
		tf BOOLEAN;
		BEGIN
	IF num < 2 THEN
		tf := FALSE;
		RETURN tf;
	ELSIF num = 2 THEN
		tf := TRUE;
		RETURN tf;
	ELSE
		IF MOD(num, 2) = 0 THEN
			tf := FALSE;
			RETURN tf;
		END IF;
		FOR i IN 3..SQRT(num)
		LOOP
			IF MOD(num, i) = 0 THEN
				tf := FALSE;
				RETURN tf;
			END IF;
		END LOOP;
		tf := TRUE;
	END IF;
	RETURN tf;
END isPrime;


PROCEDURE printPrimes (low INTEGER, up  INTEGER)
	IS
		tf               BOOLEAN;
		lowGTupException EXCEPTION;
		LTNullException  EXCEPTION;
BEGIN
	IF low > up THEN
		RAISE lowGTupException;
	END IF;
	IF low < 0 OR up < 0 THEN
		RAISE LTNullException;
	END IF;
	FOR i IN low..up
	LOOP
		tf   := isPrime(i);
		IF tf = TRUE THEN
			DBMS_OUTPUT.PUT_LINE(i || ' is prime');
		END IF;
	END LOOP;
	EXCEPTION
		WHEN lowGTupException THEN
		DBMS_OUTPUT.PUT_LINE('low > up');
		WHEN LTNullException THEN
		DBMS_OUTPUT.PUT_LINE('low or up < 0');
END printPrimes;

END PRIME;


-- SET SERVEROUTPUT ON;

BEGIN
	PRIME.PRINTPRIMES(1,100);
END;





---------------------------------------------------
-- Aufgabe 3, Moving Average

-- PL/SQL: DBMS_OUTPUT.ENABLE (buffer_size => NULL);
-- SQL Developer: set serveroutput on size unlimited

-- a)
create or replace PROCEDURE moving_average(offset NUMBER)
IS
   prev dax%ROWTYPE;
    cur dax%ROWTYPE;
    nxt dax%ROWTYPE;

    CURSOR dax_c IS SELECT datum, wert FROM dax ORDER BY datum;
BEGIN
    OPEN dax_c;
    -- first tuple
    FETCH dax_c INTO prev;
    -- print first tuple
    SYS.dbms_output.put_line(prev.datum || ' ' || prev.wert || ' ' || prev.wert);
    -- second tuple
    FETCH dax_c INTO cur;
    
    <<fin>>
    LOOP
      IF dax_c%NOTFOUND THEN
        EXIT fin;
      END IF;
      
     -- next tuple
     FETCH dax_c INTO nxt; 
     SYS.dbms_output.put_line(cur.datum || ' ' || cur.wert || ' ' || 
       ROUND((prev.wert + cur.wert + nxt.wert) / 3, 3));
     prev := cur;
     cur := nxt;
    END LOOP;
  
END moving_average;



-- b)
SELECT datum, wert, round((gestern + wert + morgen) / 3,3) dreitagesmittel 
FROM (SELECT datum, wert, 
             LAG(wert, 1) OVER (ORDER BY datum) gestern, 
             LEAD(wert, 1) OVER(ORDER BY datum) morgen 
      FROM dax
      ORDER BY datum);








---------------------------------------------------
-- Aufgabe 4, Constraints und Trigger
-- CHECK Klausel, cp. F. 25, Kapitel 4, Subquery in CHECK-Klausel
create table person (
	name varchar(20) primary key,
	prest varchar(20) not null);

create table handy (nr integer primary key, hrest varchar(20) not null);

create table R (
	hnr integer primary key references handy,
	pname varchar(20) not null references person,
	a integer not null);

CREATE OR REPLACE TRIGGER PersonHandyTrigger 
BEFORE INSERT OR UPDATE OF Name, PRest ON Person 
-- Der Trigger wirft für jede Zeile ausgeführt, die geändert wird
FOR EACH ROW
	DECLARE
	v_count INTEGER;
	BEGIN
		SELECT COUNT(*) INTO v_count FROM R WHERE PName = :NEW.Name;
		DBMS_OUTPUT.PUT_LINE('v_count = ' || v_count);  
		IF v_count <= 0 THEN
			RAISE_APPLICATION_ERROR(-20505,'Keine Handy-Referenz in R');
		END IF;
	END;











