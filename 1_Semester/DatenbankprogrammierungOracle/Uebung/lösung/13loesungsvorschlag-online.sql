-- Übungsblatt 13, Hinweise

---------------------------------------------------
-- Aufgabe 1, Connect By
-- a)
-- alle Angestellten von Albert
select distinct emp 
from hierarchie
start with boss = 'Albert'
connect by prior emp = boss;

-- b)
-- alle direkten Angestellte von Albert
select distinct emp 
from hierarchie
where level = 2
start with emp = 'Albert'
connect by prior emp = boss;

-- c)
-- alle Enkelkinder
SELECT DISTINCT emp
FROM hierarchie  
WHERE level =3
CONNECT BY PRIOR boss = emp; 


---------------------------------------------------
-- Aufgabe 2), Baumstrukturen, Windsor-Familie
-- a)
Pers			Vorgaenger
Elizabeth-1  	NULL 
Elizabeth-2   	Elizabeth-1
Charles   		Elizabeth-2
Anne   			Elizabeth-2
Andrew    		Elizabeth-2
Edward   		Elizabeth-2
Margaret Rose  	Elizabeth-1

-- b)
-- Nested Sets Variante
SELECT Person FROM WINDSOR
WHERE LEFT > (select LEFT FROM WINDSOR WHERE Person='Elizabeth-1')
  AND RIGHT < (select RIGHT FROM windsor WHERE Person='Elizabeth-1');

-- CONNECT BY Variante
SELECT Person FROM WINDSOR2 START WITH Vorgaenger = 'Elizabeth-1'
CONNECT BY PRIOR Person = Vorgaenger;


-- c)
SELECT Person FROM WINDSOR2
WHERE level = 3
CONNECT BY PRIOR Person = Vorgaenger;




