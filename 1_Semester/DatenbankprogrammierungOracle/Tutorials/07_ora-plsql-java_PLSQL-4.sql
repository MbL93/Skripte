-- Aktive Inhalte in Oracle
-- PL/SQL



-- Stored Procedures
CREATE OR REPLACE PROCEDURE add_up(val01 NUMBER, val02 IN NUMBER) 
       IS
       summe NUMBER; 
BEGIN 
      summe := val01 + val02;
      DBMS_OUTPUT.PUT_LINE('Summe: ' || summe);
END add_up; 

-- Prozedur / Funktion löschen
DROP FUNCTION | PROCEDURE ...


-- Aufruf im SQL-Developer mittels CALL
EXEC add_up(1,2);



-- Stored Functions

CREATE OR REPLACE FUNCTION add_function(val01 NUMBER := 3, val02 IN NUMBER, count_neg_values OUT NUMBER) 
	 RETURN NUMBER 
IS 
   result NUMBER; 
BEGIN 
      IF val01 < 0 AND val02 < 0 THEN 
      	 count_neg_values := 2; 
      ELSIF val01 < 0 OR val02 < 0 THEN 
      	 count_neg_values := 1;
      ELSE 
         count_neg_values := 0; 
      END IF; 

      result := val01 + val02; 

      RETURN result; 
END add_function;   -- Angabe des Funktionsnamens optional



-- Aufruf einer Funktion in einem PL/SQL Block
DECLARE 
	result NUMBER; 
	count_neg_values NUMBER; 
BEGIN 
      result := add_function( 
      	     	   val02 => 0, 
		   count_neg_values => count_neg_values); 
      DBMS_OUTPUT.PUT_LINE('Summe: ' || result); 
      DBMS_OUTPUT.PUT_LINE('Summanden kleiner 0: ' || count_neg_values); 
END; 



-- Funktionsaufruf innerhalb von SQL
CREATE OR REPLACE FUNCTION tax(p_value IN NUMBER)
 RETURN NUMBER
IS
BEGIN
 RETURN (p_value * 0.08);
END tax;

SELECT id, first_name, last_name, salary, tax(salary) FROM employee;



