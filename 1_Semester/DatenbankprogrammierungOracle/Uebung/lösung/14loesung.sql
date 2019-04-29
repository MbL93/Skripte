-- Übungsblatt 14

---------------------------------------------------
-- Aufgabe 1, PL/SQL Ausgabe
declare
v_dt DATE :=sysdate;
v_tx VARCHAR2(2000);
begin
	v_tx:=to_char(v_dt,'mm/dd/yyyy');
	DBMS_OUTPUT.put_line(v_tx);
	v_tx:=to_char(v_dt,'hh24:mi');
	DBMS_OUTPUT.put_line(v_tx);
	v_tx:=to_char(v_dt);
	DBMS_OUTPUT.put_line(v_tx);
end;


---------------------------------------------------
-- Aufgabe 2, PL/SQL (Oracle)
DECLARE
low BINARY_INTEGER := 1;
up BINARY_INTEGER := 100;
BEGIN
	FOR i IN low..up LOOP
		IF MOD(i,3) = 0 THEN
			IF MOD(i,5) != 0 THEN
				DBMS_OUTPUT.PUT_LINE(i);
			END IF;
		END IF;
		IF MOD(i,5) = 0 THEN
			IF MOD(i,3) != 0 THEN
				DBMS_OUTPUT.PUT_LINE(i);
			END IF;
		END IF;   
	END LOOP;
END;





---------------------------------------------------
-- Aufgabe 3, SOUNDEX
-- ist garantiert ausbaufähig
create or replace
PROCEDURE soundex2(inp VARCHAR2)
IS
   phonetic VARCHAR2(20);
   input VARCHAR(20) := inp;
   v_length NUMBER;
BEGIN
  -- erster Buchstaben der Zeichenkette
  SELECT LOWER(input) INTO input FROM dual;
  SELECT SUBSTR(input, 1, 1) INTO phonetic FROM dual;

  -- restliche Zeichenkette in input zurueckschreiben
  SELECT SUBSTR(input, 2) INTO input FROM dual;

  -- Entferne a, e, h, i, o, u, w, y, d.h. ersetze durch '' (case-insensitiv)
  SELECT REGEXP_REPLACE(input, '[a,e,h,i,o,u,w,y]') INTO input FROM dual;

  -- Entferne alle Nicht-Buchstaben
  SELECT REGEXP_REPLACE(input, '[^[:alpha:]]') INTO input FROM dual;

  -- 1 <- b,f,p,v
  SELECT REGEXP_REPLACE(input, '[b,f,p,v]', '1') INTO input FROM dual;
  
  -- 2 <- c,g,j,k,q,s,x,z
  SELECT REGEXP_REPLACE(input, '[c,g,j,k,q,s,x,z]', '2') INTO input FROM dual;
 
  -- 3 <- d,t
 SELECT REGEXP_REPLACE(input, '[d,t]', '3') INTO input FROM dual;
 
  -- 4 <- l
 SELECT REGEXP_REPLACE(input, '[l]', '4') INTO input FROM dual;
 
  -- 5 <- m,n
 SELECT REGEXP_REPLACE(input, '[m,n]', '5') INTO input FROM dual;
 
  -- 6 <- r
 SELECT REGEXP_REPLACE(input, '[r]', '6') INTO input FROM dual;

 -- Duplikate eliminieren
 SELECT REGEXP_REPLACE(input, '(1+)', '1') INTO input FROM dual;
 SELECT REGEXP_REPLACE(input, '(2+)', '2') INTO input FROM dual;
 SELECT REGEXP_REPLACE(input, '(3+)', '3') INTO input FROM dual;
 SELECT REGEXP_REPLACE(input, '(4+)', '4') INTO input FROM dual;
 SELECT REGEXP_REPLACE(input, '(5+)', '5') INTO input FROM dual;
 SELECT REGEXP_REPLACE(input, '(6+)', '6') INTO input FROM dual;

  SELECT LENGTH(input) INTO v_length FROM dual;

 	IF v_length >= 3 THEN
	   SELECT SUBSTR(input, 1, 3) INTO input FROM dual;
 	ELSE -- v_length < 3
	   SELECT RPAD(input, 3, '0') INTO input FROM dual;
	END IF;

    DBMS_OUTPUT.PUT_LINE('Soundex: ' || phonetic || input);
END;




