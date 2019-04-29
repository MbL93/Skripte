-- Blatt 10

-- Aufgabe 1
-- a
create table tree(
node_name varchar2(30) primary key,
lft integer not null unique check(lft > 0),
rgt integer not null unique check(rgt > 1),
constraint check_order check (lft < rgt)
);

-- b
-- Siehe Mitschrift (Blatt)

insert into tree values ('Fauna', 1, 12);
insert into tree values ('Wirbeltiere', 2, 9);
insert into tree values ('Säugetiere', 3, 4);
insert into tree values ('Echsen', 5, 6);
insert into tree values ('Fische', 7, 8);
insert into tree values ('Schalentiere', 10, 11);
commit;

select * from tree;

-- c
select node_name from tree
where lft < (select lft from tree where node_name = 'Echsen')
and rgt > (select rgt from tree where node_name = 'Echsen');

select v.node_name from tree v, tree n
where n.node_name = 'Echsen'
and n.lft > v.lft
and n.rgt < v.rgt;

-- d
select * from tree
where lft > (select lft from tree where node_name = 'Wirbeltiere')
and rgt < (select rgt from tree where node_name = 'Wirbeltiere');

select n.node_name from tree v, tree n
where v.node_name = 'Wirbeltiere'
and n.lft < n.lft
and n.rgt > n.rgt;

-- e
undefine rgt;
def rgt = 4;
select &rgt from dual;

update tree set rgt = rgt + 2 where rgt > &rgt;
update tree set lft = lft + 2 where lft > &rgt;
insert into tree values ('Saurier', &rgt + 1, &rgt + 2);
commit;

select * from tree;

-- f
undefine v_rgt;
def v_rgt = 13;

update tree set lft = lft + 2 where lft > &v_rgt;
update tree set rgt = rgt + 2 where rgt >= &v_rgt;
insert into tree values ('Insekten', &v_rgt, &v_rgt + 1);
commit;

select * from tree;

-- g
declare
    v_lft integer;
    v_rgt integer;
    v_move integer;
begin
    select lft, rgt into v_lft, v_rgt from tree where node_name = 'Wirbeltiere';
    
    v_move := floor((v_rgt - v_lft) / 2);
    v_move := 2* (1 + v_move);
    
    Delete from tree where lft between v_lft and v_rgt;
    
    -- restliche Knoten verschieben
    update tree set lft = lft - v_move where lft > v_rgt;
    update tree set rgt = rgt - v_move where rgt > v_rgt;
    -- wenn es den constraint gibt, dass lft < rgt gelten muss,
    -- müsste ggf. die Reihenfolge der updates getauscht werden
end;
/

commit;
select * from tree;


-- Aufgabe 2
-- a
create table personal as select * from personal3;
-- Achtung: Es werden nur die Daten kopiert, nicht aber die constraints!

commit;


-- b
update personal set lft = lft + 1, rgt = rgt + 1;
insert into personal values ('Page', 1, 18);
commit;

select * from personal;


-- c
select e.name, count(*) "level"
from personal b, personal e
where e.lft between b.lft and b.rgt
group by e.name
order by "level";
