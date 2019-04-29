-- Aktive Inhalte in Oracle
-- PL/SQL


drop table employee;
create table employee(id integer primary key, first_name varchar(20), last_name varchar(20), email varchar(200));
insert into employee values(1, 'markus', 'endres', 'endres@informatik.uni-augsburg.de');
insert into employee values(2, 'stefan', 'mandl', 'mandl@informatik.uni-augsburg.de');


-- Anonymer Block
set serveroutput on;

DECLARE
  v_myName VARCHAR2(20) := 'Stefan';
BEGIN
  v_myName := 'Markus';
  DBMS_OUTPUT.PUT_LINE('My name is: ' || v_myName);
END;


-- INSERT INTO
DECLARE
	v_name varchar(20);
BEGIN
	SELECT first_name INTO v_name FROM employee WHERE last_name = 'endres';
	DBMS_OUTPUT.PUT_LINE('First name: ' || v_name);
END;



-- Subtypen
DECLARE
  SUBTYPE VC10 IS VARCHAR2(10);
  v_myName VC10 := 'Stefan';
  v_name employee.first_name%TYPE := 'Stefan';
BEGIN
  v_myName := 'Markus';
  DBMS_OUTPUT.PUT_LINE('My name is: ' || v_myName);
  DBMS_OUTPUT.PUT_LINE('My name is: ' || v_name);
END;




-- Komplexe Zahlen, RECORDS
DECLARE
 TYPE COMPLEX IS RECORD ( 
 r NUMBER, 
 i NUMBER 
); 

val COMPLEX; 
BEGIN
 val.r := -5.0; 
 val.i := 1.2; 
 DBMS_OUTPUT.PUT_LINE('r = ' || val.r);
 DBMS_OUTPUT.PUT_LINE('i = ' || val.i);
END;




-- Records
-- %ROWTYPE
SET SERVEROUTPUT ON;

DECLARE
 v_emp_number number := 1;
 v_emp_rec employee%ROWTYPE;
BEGIN
 SELECT * INTO v_emp_rec FROM employee where id = v_emp_number;
  DBMS_OUTPUT.PUT_LINE('first_name: ' || v_emp_rec.first_name);
  DBMS_OUTPUT.PUT_LINE('last_name: ' || v_emp_rec.last_name);
  DBMS_OUTPUT.PUT_LINE('email: ' || v_emp_rec.email);
END;



