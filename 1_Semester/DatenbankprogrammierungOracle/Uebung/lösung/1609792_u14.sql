--Übungsblatt 14
--PL/SQL PRogramm für Uhrzeit/Datum
SET SERVEROUTPUT ON;
------------------------------------------------------------------------------
-- Aufgabe 1
------------------------------------------------------------------------------
DECLARE
v_date VARCHAR2(20) := TO_CHAR(CURRENT_DATE, 'MM/DD/YYYY');
v_time VARCHAR2(20) := TO_CHAR(SYSTIMESTAMP, 'HH:MI'); -- Sekunden: :SS
v_date2 VARCHAR2(20) := TO_CHAR(CURRENT_DATE, 'DD.MM.YYYY');
BEGIN
DBMS_OUTPUT.PUT_LINE(v_date);
DBMS_OUTPUT.PUT_LINE(v_time);
DBMS_OUTPUT.PUT_LINE(v_date2);
SELECT CURRENT_DATE;
END;
/
------------------------------------------------------------------------------
-- Aufgabe 2
------------------------------------------------------------------------------

DECLARE
    s_nr BINARY_INTEGER := 1;
    up BINARY_INTEGER := 100;
    val1 BINARY_INTEGER := 3;
    val2 BINARY_INTEGER := 5;
    mod_val1 BOOLEAN;
    mod_val2 BOOLEAN;
    
BEGIN
    FOR i IN s_nr..up LOOP
        mod_val1 := (MOD(i, val1) = 0);
        mod_val2 := (MOD(i, val2) = 0);
        
        IF (mod_val1 AND mod_val2) OR (NOT mod_val1 AND NOT mod_val2) THEN
            CONTINUE;
            ELSIF mod_val1 THEN
                DBMS_OUTPUT.PUT_LINE(i);
            ELSE
                DBMS_OUTPUT.PUT_LINE(i);
        END IF;
    END LOOP;
END;
/
------- gibt auch XOR: if XOR(bool, bool) THEN
------------------------------------------------------------------------------
-- Aufgabe 3
------------------------------------------------------------------------------
-- trick bei zB lalalala: da nach entfernen der As 4xL nebeneinander stehen und sich 
-- dann das resultierende 1x L von dem Urpsrungsstring Lalalala unterscheidet,
-- ersetzt man die As durch '-' und ersezt dann erst durch Zahlen

create or replace function my_soundex(inp varchar2) return varchar2
IS
    res VARCHAR2(30);
    firstc varchar2(30);
BEGIN
    --todo
    firstc := SUBSTR(inp, 1,1);
    res := substr(inp,2);
    res := regexp_replace(res,'a|e|h|i|o|u|w|y','-'); 
    --[^[:alpha:]]|[AEHIQOWY]
    res := regexp_replace(res,'b|f|p|v','1');
    res := regexp_replace(res,'c|g|j|k|q|s|x|z','2');
    res := regexp_replace(res,'d|t','3');
    res := regexp_replace(res,'l','4');
    res := regexp_replace(res,'m|n','5');
    res := regexp_replace(res,'r','6');
    res := regexp_replace(res, '1+', '1');
    res := regexp_replace(res, '2+', '2');
    res := regexp_replace(res, '3+', '3');
    res := regexp_replace(res, '4+', '4');
    res := regexp_replace(res, '5+', '5');
    res := regexp_replace(res, '6+', '6');
    res := regexp_replace(res, '-', '');
    res := firstc || res;
    --res := substr(res, 1,4);
    
    --res := rpad(res, 4, '0');
    --select regexp_replace('11111-22-345', '1+', '1') from dual;
    --select regexp_replace('11111-22-345', '(\d)+', '\1') from dual;
    return res;
END;
/

--TESTFUNKTION:
-- Test Suite for soundex
WITH test_data AS (
    -- examples from Wikipedia
    SELECT 'Robert' AS inp, 'R163' AS res FROM dual
    UNION
    SELECT 'Rupert' AS inp, 'R163' AS res FROM dual
    UNION
    SELECT 'Rubin' AS inp, 'R150' AS res FROM dual
    
    -- according to Wikipedia and oracle Soundex Documentation must be 'A261', but it's consistent with the text of the assignment
	UNION
    SELECT 'Ashcraft' AS inp, 'A226' AS res FROM dual
    UNION
    SELECT 'Ashcroft' AS inp, 'A226' AS res FROM dual


    UNION
    SELECT 'Tymczak' AS inp, 'T522' AS res FROM dual
    
    -- If two or more letters with the same number are adjacent in the original name (before step 1), only retain the first letter.
    -- This rule also applies to the first letter!
	UNION
    SELECT 'Pfister' AS inp, 'P236' AS res FROM dual

    UNION
    SELECT 'Honeyman' AS inp, 'H555' AS res FROM dual
    --------- more examples
    UNION
    SELECT 'la' AS inp, 'L000' AS res FROM dual
    UNION
    SELECT 'lala' AS inp, 'L400' AS res FROM dual
    UNION
    SELECT 'lalalalalala' AS inp, 'L444' AS res FROM dual


    -- If two or more letters with the same number are adjacent in the original name (before step 1), only retain the first letter.
    -- This rule also applies to the first letter!
    UNION
    SELECT 'llllllllll' AS inp, 'L000' AS res FROM dual
    UNION
    SELECT 'mmmnnnnmmm' AS inp, 'M000' AS res FROM dual
)
SELECT inp AS input, res AS expected, my_soundex(inp) AS actual
FROM test_data
WHERE my_soundex(inp) != res;