-- Übungsblatt 1 --
select * from correlated;
--a)
--b)
select count(*) from correlated;
--c)
select max(VAL2) from correlated;
select min(VAL1) from correlated;
select max(VAL1) from correlated;
select min(VAL2) from correlated;
--d)
select ID,round(VAL1/5,1)*5,round(VAL2/5,1)*5 from correlated;
--e)
select * from correlated where ID>=100 AND MOD(ID,3) = 0;
--f)
select trunc(VAL1),VAL1 from correlated;
select round(avg(VAL1), 6) AS AVGVAL1,round(avg(VAL2), 6) AS AVGVAL2 from correlated where ID>300 AND ID<400 union
select round(avg(VAL1), 6) AS AVGVAL1,round(avg(VAL2), 6) AS AVGVAL2 from correlated where ID>400 AND ID<500;
--while?

-- Übungsblatt 2 -- 
--a) 
create tablespace mytablespace datafile '1609792.dbf' size 5120K permanent autoextend on next 1024K maxsize unlimited;
--b)
select * from sys.v_$datafile;
