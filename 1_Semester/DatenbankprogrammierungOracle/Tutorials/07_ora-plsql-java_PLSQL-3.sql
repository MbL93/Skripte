-- Aktive Inhalte in Oracle
-- PL/SQL
SET SERVEROUTPUT ON;

-- Exception Handling

DECLARE 
	nothing_here EXCEPTION; 
	PRAGMA EXCEPTION_INIT(nothing_here, 100); 

BEGIN 
      IF TRUE THEN 
      	 RAISE nothing_here; 
      END IF;  

      EXCEPTION 
      	WHEN NO_DATA_FOUND THEN   -- NO_DATA_FOUND = 100
	DBMS_OUTPUT.PUT_LINE('nothing found'); 
END; 


