-- Bäume in Oracle, Connect By

create table breeding(offspring varchar(20), sex char(1), cow varchar(20), bull varchar(20), birthdate date);

insert into breeding values('Eve', 'F', null, null, null);
insert into breeding values('Adam', 'M', null, null, null);
insert into breeding values('Bandit', 'M', null, null, null);

insert into breeding values('Betsy', 'F', 'Eve', 'Adam', '02-JAN-00');
insert into breeding values('Poco', 'M', 'Eve', 'Adam', '15-JUL-00');
insert into breeding values('Greta', 'F', 'Eve', 'Bandit', '12-MAR-01');
insert into breeding values('Mandy', 'F', 'Eve', 'Poco', '22-AUG-01');
insert into breeding values('Cindy', 'F', 'Eve', 'Poco', '09-FEB-03');
insert into breeding values('Novi', 'F', 'Betsy', 'Adam', '30-MAR-03');
insert into breeding values('Ginny', 'F', 'Betsy', 'Bandit', '04-DEC-03');
insert into breeding values('Duke', 'M', 'Mandy', 'Bandit', '24-JUL-04');
insert into breeding values('Teddi', 'F', 'Betsy', 'Bandit', '12-AUG-05');
insert into breeding values('Suzy', 'F', 'Ginny', 'Duke', '03-APR-06');
insert into breeding values('Paula', 'F', 'Mandy', 'Poco', '21-DEC-06');
insert into breeding values('Ruth', 'F', 'Ginny', 'Duke', '25-DEC-06');
insert into breeding values('Della', 'F', 'Suzy', 'Bandit', '11-OCT-08');



-- ... CONNECT BY PRIOR column1 = column2;
-- Richtung
-- Bottom Up ---> column1 = Elternknoten
--                column2 = Kindknoten

-- Top Down  ---> column1 = Kindknoten
--                column2 = Elternknoten

-- Visualisierung der familiären Beziehungen
SELECT cow,
       bull,
       lpad(' ', 6 * (LEVEL - 1), '.') || offspring AS
       offspring
FROM breeding
START WITH offspring = 'Eve'
CONNECT BY PRIOR offspring = cow;



-- From Bottom Up
-- Finde die Vorfahren von Della
SELECT cow, bull, offspring
FROM breeding
START WITH offspring = 'Della'
CONNECT BY PRIOR cow = offspring;

-- Vorfahren von Della mit Einrückungen
SELECT cow,
       bull,
       lpad(' ', 6 * (LEVEL - 1), '.') || offspring AS
       offspring
FROM breeding
START WITH offspring = 'Della'
CONNECT BY PRIOR cow = offspring;




-- From Top Down
-- Finde die Nachfahren von Betsy
SELECT cow, bull, offspring
FROM breeding
START WITH offspring = 'Betsy'
CONNECT BY PRIOR offspring = cow;



-- Nachfahren von Betsy mit Einrückungen
SELECT cow,
       bull,
       lpad(' ', 6 * (LEVEL - 1), '.') || offspring AS
       offspring
FROM breeding
START WITH offspring = 'Betsy'
CONNECT BY PRIOR offspring = cow;





-- Indivduen und Zweige ausblenden
-- Schließt Betsy und ALLE ihre Nachkommen aus
SELECT cow, bull, lpad(' ', 6 * (LEVEL - 1), '.') || offspring
                  AS offspring
FROM breeding
START WITH offspring = 'Eve'
CONNECT BY PRIOR offspring = cow
       AND offspring != 'Betsy';



-- Schließt Betsy, aber KEINE Nachkommen aus
SELECT cow, bull, lpad(' ', 6 * (LEVEL - 1), '.') || offspring
                  AS offspring
FROM breeding
WHERE offspring != 'Betsy'
START WITH offspring = 'Eve'
CONNECT BY PRIOR offspring = cow;




-- CONNECT_BY_ROOT
SELECT CONNECT_BY_ROOT(offspring), offspring
FROM breeding
CONNECT BY PRIOR cow = offspring;


-- alle Teilbäume aufzählen
--Zu jedem Rind sollen alle weiblichen Vorfahren u. das jeweilige Verwandtschaftsverhältnis ausgegeben werden:
SELECT CONNECT_BY_ROOT(offspring) kuh,
       offspring vorfahr,
       CASE
          WHEN level = 2 THEN 'Mutter'
          WHEN level = 3 THEN 'Großmutter'
          ELSE RPAD('Ur', 2 * (level - 3), 'ur') ||
               'großmutter'
       END beziehung
FROM breeding
WHERE offspring != CONNECT_BY_ROOT(offspring)
CONNECT BY PRIOR cow = offspring
ORDER BY kuh, level;




-- SYS_CONNECT_BY_PATH, Pfad von der Baumwurzel zum Wert von <Spalte> des
-- aktuellen Tupels
SELECT cow, bull, SYS_CONNECT_BY_PATH(offspring, '/') ospr      
FROM breeding
START WITH offspring = 'Eve'
CONNECT BY PRIOR offspring = cow;


-- Die mütterliche Abstammungsgeschichte aller kinderlosen Kühe
-- CONNECT_BY_ISLEAF = 1, wenn das Tupel ein Blatt ist
SELECT offspring,
       SUBSTR(SYS_CONNECT_BY_PATH(offspring,
                          ' -> '),5) abstammung
FROM breeding
WHERE CONNECT_BY_ISLEAF = 1 AND sex = 'F'
START WITH offspring = 'Eve'                          
CONNECT BY PRIOR offspring = cow;
