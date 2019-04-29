-- Übungsblatt 9 



---------------------------------------------------
-- 1), SQL, Messwerte
-- a) beliebig
-- b)
SELECT datum, 
   GREATEST(wert_1, wert_2, wert_3, wert_4, wert_5, wert_6) mx,
   LEAST(wert_1, wert_2, wert_3, wert_4, wert_5, wert_6) mi
FROM messwerte;

-- c)
SELECT datum, 
       wert_1, 
       wert_1 - LAG(wert_1) OVER (ORDER BY datum ASC)
FROM messwerte;




---------------------------------------------------
-- Aufgabe 2, SQL Formatierung, used_cars_sold

-- a)
select * from(
select u.*, rownum from used_cars_sold u
order by price desc)
where rownum <= 5
;

-- b)
SELECT * FROM used_cars_sold u
ORDER BY price DESC
FETCH FIRST 5 ROWS ONLY;§

-- c)
SELECT make,
      CASE 
        WHEN make = 'BMW' THEN 'Germany'
        WHEN make = 'Audi' THEN 'Germany'
        WHEN make = 'VW' THEN 'Germany'
        WHEN make = 'Nissan' THEN 'Japan'
        WHEN make = 'Mazda' THEN 'Japan'
        WHEN make = 'Toyota' THEN 'Japan'
        WHEN make = 'Subaru' THEN 'Japan'
        WHEN make = 'Renault' THEN 'France'
        WHEN make = 'Peugeot' THEN 'France'
        WHEN make = 'Fiat' THEN 'Italy'
        WHEN make = 'Ford' THEN 'USA'
        ELSE null
      END country,
      color,
      price,
      age
    FROM used_cars_sold;


---------------------------------------------------
-- 3), DAX
-- a)
	SELECT COUNT(DISTINCT datum) FROM dax;


-- b)
      SELECT datum, wert
      FROM dax
      WHERE wert = (SELECT MAX(wert) FROM dax)

-- c)
      SELECT rownum, datum, wert
      FROM (SELECT datum, wert, rownum
            FROM dax
            ORDER BY wert DESC)
      WHERE rownum <= 10


-- d)
      SELECT j.jahr, j.mittel, 
             (SELECT COUNT(*) FROM dax WHERE wert < j.mittel AND j.jahr = TO_CHAR(datum, 'YYYY')) kleiner,
             (SELECT COUNT(*) FROM dax WHERE wert > j.mittel AND j.jahr = TO_CHAR(datum, 'YYYY')) groesser
      FROM (SELECT TO_CHAR(datum, 'YYYY') jahr, AVG(wert) mittel
            FROM dax
            GROUP BY TO_CHAR(datum, 'YYYY')
            ) j
      ORDER BY Jahr

-- e)
      SELECT datum, wert, 
             CASE 
               WHEN LAG(wert, 1) OVER (ORDER BY datum) > wert THEN 'runter' 
               WHEN LAG(wert, 1) OVER (ORDER BY datum) < wert THEN 'rauf' 
               ELSE ''
             END tendenz
      FROM dax
      --WHERE rownum < 10
      ORDER BY datum ASC;

-- f)
      SELECT datum, wert, delta, tendenz
      FROM (
        SELECT datum, wert,
               ROUND((wert / LAG(wert, 1) OVER (ORDER BY datum) - 1)*100, 2) delta,
               rownum,
               'gestiegen' tendenz
        FROM dax
        ORDER BY delta DESC
      )
      WHERE rownum <= 10 AND delta IS NOT NULL;

      SELECT datum, wert, delta, tendenz
      FROM (
        SELECT datum, wert,
               ROUND((wert / LAG(wert, 1) OVER (ORDER BY datum) - 1)*100, 2) delta,
               rownum,
               'gefallen' tendenz
        FROM dax
        ORDER BY delta ASC
      )
      WHERE rownum <= 10 AND delta IS NOT NULL;






---------------------------------------------------
-- 4), Berichte, Bestellungen
SELECT daten.datum, NVL(zahlen.betrag, 0)
FROM
  (
    SELECT '2008-01' datum FROM dual UNION
    SELECT '2008-02' datum FROM dual UNION
    SELECT '2008-03' datum FROM dual UNION
    SELECT '2008-04' datum FROM dual UNION
    SELECT '2008-05' datum FROM dual UNION
    SELECT '2008-06' datum FROM dual UNION
    SELECT '2008-07' datum FROM dual UNION
    SELECT '2008-08' datum FROM dual UNION
    SELECT '2008-09' datum FROM dual UNION
    SELECT '2008-10' datum FROM dual UNION
    SELECT '2008-11' datum FROM dual UNION
    SELECT '2008-12' datum FROM dual
  ) daten
  LEFT OUTER JOIN
  (
    SELECT to_char(datum,'YYYY-MM') datum, SUM(betrag) betrag
      FROM bestellungen
      GROUP BY to_char(datum,'YYYY-MM')
  ) zahlen
  ON daten.datum = zahlen.datum
  ORDER BY daten.datum;






