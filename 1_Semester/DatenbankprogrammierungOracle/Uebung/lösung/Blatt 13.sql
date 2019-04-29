-- Aufgabe 1
-- a
select emp from hierarchie
connect by prior emp = boss
start with boss = 'Albert';

-- b
select emp from hierarchie
where level = 1
connect by prior emp = boss
start with boss = 'Albert';

-- c
select distinct emp from hierarchie
where level = 3
connect by prior boss = emp;


-- Aufgabe 2
-- a
create table windsor2 (person varchar2(30), parent varchar(30));
insert into windsor2 values ('Elizabeth-1', null);
-- ...

-- b
select person from windsor
where left > (select left from windsor where person = 'Elizabeth-1')
and right < (select right from windsor where person = 'Elizabeth-1');

select person from windsor2
start with parent = 'Elizabeth-1'
connect by prior person = parent;

-- c
select person, connect_by_root(person) opaoderoma
from windsor2
where level = 3
connect by prior person = parent;