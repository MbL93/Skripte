-- Aktive Inhalte in Oracle
-- PL/SQL

SET SERVEROUTPUT ON;

-- Steuerstrukturen

-- GOTO vs. EXIT
-- Steuerstrukturen
DECLARE 
	up BINARY_INTEGER := 20; 
	square BINARY_INTEGER; 
BEGIN 
      -- Beispiel für EXIT
      <<sqr>>     -- Marke für EXIT
      FOR i IN 1..up LOOP 
        square := i * i;
        DBMS_OUTPUT.PUT_LINE(i || ' * ' || i || ' = ' || square); 

        IF square > 20 THEN 
          EXIT sqr;
        END IF; 
	  END LOOP; 
      
      DBMS_OUTPUT.PUT_LINE('EXIT wurde erfolgreich beendet');
      
      -- Beispiel für GOTO
      FOR i IN 1..up LOOP 
         square := i * i;
         DBMS_OUTPUT.PUT_LINE(i || ' * ' || i || ' = ' || square); 

        IF square > 20 THEN 
	     GOTO ende;
	  END IF; 
	  END LOOP; 
      
      <<ende>>      -- Marke für GOTO
      DBMS_OUTPUT.PUT_LINE('Das ist das Ende für GOTO');
      
END; 


-- EXIT
DECLARE 
	up BINARY_INTEGER := 20; 
	square BINARY_INTEGER; 
	temp BINARY_INTEGER; 
BEGIN 
      <<sqr>>    -- Marke
      FOR i IN 1..up LOOP 
      square := i * i;
      DBMS_OUTPUT.PUT_LINE(i || ' * ' || i || ' = ' || square); 

      temp := 0; 
      FOR j IN REVERSE 1..square LOOP 
      	  temp := temp + j; 
	  IF temp > 100 THEN 
	     EXIT sqr; 
	  ELSIF temp = 100 THEN 
	  	DBMS_OUTPUT.PUT_LINE('Summe von ' || j || ' bis ' || square || ' ist 100'); 
	  ELSE NULL; 
	  END IF; 
	  END LOOP; 
      END LOOP; 
END; 



-- SELECT-Statements mit INTO
DECLARE 
	current DATE; 
	id ROWID; 

	TYPE MYTYPE IS RECORD (dt DATE, id ROWID); 
	rec MYTYPE; 
BEGIN 
      SELECT SYSDATE, ROWID INTO current, id FROM dual; 
      DBMS_OUTPUT.PUT_LINE('Zeit: ' || current); 
      DBMS_OUTPUT.PUT_LINE('Row-ID: ' || id); 

      SELECT SYSDATE, ROWID INTO rec FROM dual; 
      DBMS_OUTPUT.PUT_LINE('Zeit: ' || rec.dt); 
      DBMS_OUTPUT.PUT_LINE('Row-ID: ' || rec.id); 
END; 





-- CURSOR

-- Cursor ohne Parameter
DECLARE 
	-- Cursor ohne Parameter 
	CURSOR emp_c IS SELECT first_name, last_name FROM employee; 
	var01 VARCHAR2(20); 
	var02 VARCHAR2(20); 
BEGIN
      -- alle Zeilen lesen 
      OPEN emp_c; 
      LOOP 
      	   FETCH emp_c INTO var01, var02; 
	   EXIT WHEN emp_c%NOTFOUND; 
	   DBMS_OUTPUT.PUT_LINE(var01 || ' ' || var02); 
      END LOOP; 
      CLOSE emp_c; 
END;





-- Cursor, der Variable benutzt 
DECLARE
	-- Cursor, der Variable benutzt 
	varSalary INTEGER := 1000;
	CURSOR emp_c IS SELECT first_name, last_name FROM employee WHERE salary = varSalary; 
	var01 VARCHAR2(20); 
	var02 VARCHAR2(20); 
BEGIN
      -- nur eine Zeile lesen 
      OPEN emp_c; 
      FETCH emp_c INTO var01, var02; 
      DBMS_OUTPUT.PUT_LINE(var01 || ' ' || var02 || ' ist ein armes Schwein.'); 
      CLOSE emp_c; 
     
      -- alle Zeilen mit einer Cursor-FOR-Schleife lesen 
      FOR line IN emp_c LOOP 
      	  DBMS_OUTPUT.PUT_LINE(line.first_name || ' ' || line.last_name || ' ist ein armes Schwein.'); 
      END LOOP; 
END;






-- Cursor mit Parameter 
DECLARE 
	-- Cursor mit Parameter 
	CURSOR with_par (varSalary INTEGER := 0) IS SELECT first_name, last_name FROM employee WHERE salary = varSalary; 
	var01 VARCHAR2(20); 
	var02 VARCHAR2(20); 
BEGIN 
  -- Aufruf mit Parameter 
      OPEN with_par(1000); 
      FETCH with_par INTO var01, var02; 
      IF with_par%FOUND THEN	-- wenn Tupel vorhanden
            DBMS_OUTPUT.PUT_LINE(var01 || ' ' || var02 || ' ist immer noch ein armes Schwein.'); 
      END IF;
      CLOSE with_par; 

      -- Aufruf mit Parameter: Standardwert verwenden 
      FOR line IN with_par LOOP 
      	  DBMS_OUTPUT.PUT_LINE(line.first_name || ' ' || line.last_name || ' ist ein armes Schwein.'); 
      END LOOP; 
END;








-- INSERT, UPDATE und DELETE
select * from employee;

drop table employee_tmp;
create table employee_tmp as select * from employee;

DECLARE 
	v_id BINARY_INTEGER := 3;
	name VARCHAR(20) := 'markus';
	v_job_id INTEGER;
	v_first_name VARCHAR2(20) := 'florian'; 
	v_last_name VARCHAR(20) := 'wenzel';
BEGIN 
      -- Gehalt neu setzen
      UPDATE employee_tmp SET salary = 100000 
      WHERE first_name = name;
      
      -- neuen Angestellten einfuegen
      INSERT INTO employee_tmp (id, first_name, last_name) 
      VALUES (v_id, v_first_name, v_last_name); 

      -- loesche Angestellten mit JOB_ID = 1
      -- Achtung: Hier wird job_id = job_id ausgewertet, also immer zu true.
      -- Damit werden alle Einträge gelöscht.
      -- Die Variable job_id muss umbenannt werden, z.B. in v_job_id
      v_job_id := 1; 
      DELETE FROM employee_tmp WHERE id = v_job_id;
END; 

