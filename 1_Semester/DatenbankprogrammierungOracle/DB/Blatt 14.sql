-- Blatt 14
set serveroutput on;

-- 1
declare
    v_date1 varchar2(20) := TO_CHAR(CURRENT_DATE, 'mm/dd/yyyy');
    v_date2 varchar2(20) := TO_CHAR(CURRENT_DATE, 'hh:mi');
    v_date3 varchar2(20) := TO_CHAR(CURRENT_DATE, 'dd.mm.yyyy');
begin
    dbms_output.put_line(v_date1);
    dbms_output.put_line(v_date2);
    dbms_output.put_line(v_date3);
end;
/

-- 2
declare
    v_start number := 1;
    v_end number := 100;
    v_div1 boolean;
    v_div2 boolean;
begin
    for i in v_start..v_end
    loop
        v_div1 := MOD(i, 3) = 0;
        v_div2 := MOD(i, 5) = 0;
        if ((v_div1 and not v_div2) or (not v_div1 and v_div2)) then
            dbms_output.put_line(i);
        end if;
    end loop;
end;
/

-- 3
create or replace function my_soundex(inp varchar2) return varchar2
is
    res varchar2(30);
    v_first char;
begin
    res := upper(inp);
    v_first := substr(res, 1, 1);

    res := regexp_replace(res, '[^ [:alpha:]]|[AEHIOUWY]', '-');
    
    res := regexp_replace(res, '[BFPV]+', '1');
    res := regexp_replace(res, '[CGJKQSXZ]+', '2');
    res := regexp_replace(res, '[DT]+', '3');
    res := regexp_replace(res, 'L+', '4');
    res := regexp_replace(res, '[MN]+', '5');
    res := regexp_replace(res, 'R+', '6');
    
    -- doppelte Zahlen ersetzen
    res := regexp_replace(res, '1+', '1');
    res := regexp_replace(res, '2+', '2');
    res := regexp_replace(res, '3+', '3');
    res := regexp_replace(res, '4+', '4');
    res := regexp_replace(res, '5+', '5');
    res := regexp_replace(res, '6+', '6');
    
    res := v_first || substr(res, 2);
    
    res := regexp_replace(res, '-', '');
    
    res := rpad(res, 4, '0');
    
    return res;
end;
/


drop function my_soundex;


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