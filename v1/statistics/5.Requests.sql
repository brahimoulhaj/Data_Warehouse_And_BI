/*_________ top 10 chiffres d'affaire par rapport au villes _________*/
set colsep ','
set heading off
set echo off
set feedback off
set termout off
SET verify off
SET term off
set pagesize 0
SET trims ON
SET trimspool ON
set underline off
SPOOL 'E:/dwh/statistics/ca_ville.csv'
SELECT 'VILLE', 'CA' FROM dual;
SELECT * FROM (
    SELECT dl.ville, SUM(f.chiffre_affaire) ca
    FROM fact_commandes f JOIN dim_lieux dl ON dl.id = f.id_lieu
    GROUP BY dl.ville ORDER BY SUM(f.chiffre_affaire) DESC
) WHERE ROWNUM <= 20;
SPOOL OFF;

/*_________ Chiffres d'affaire par rapport au régions _________*/
set colsep ','
set heading off
set echo off
set feedback off
set termout off
SET verify off
SET term off
set pagesize 0
SET trims ON
SET trimspool ON
set underline off
SPOOL 'E:/dwh/statistics/ca_region.csv'
SELECT 'REGION', 'CA' FROM dual;
SELECT dl.region, SUM(f.chiffre_affaire) ca
FROM fact_commandes f JOIN dim_lieux dl ON dl.id = f.id_lieu
GROUP BY dl.region;
SPOOL OFF;

/*_________ Chiffre d'affaire de chaque jour de chaque mois de l'année 2017 _________*/
set colsep ','
set heading off
set echo off
set feedback off
set termout off
SET verify off
SET term off
set pagesize 0
SET trims ON
SET trimspool ON
set underline off
SPOOL 'E:/dwh/statistics/ca_day_of_month_2017.csv'
    SELECT 'MOIS', 'JOUR', 'CA' FROM dual;
    SELECT dd.month mois, dd.day_of_month jour, SUM(fc.chiffre_affaire) ca
    FROM dim_dates dd JOIN fact_commandes fc ON fc.id_date = dd.id
    WHERE dd.year = 2017
    GROUP BY dd.month, EXTRACT(MONTH FROM dd.date_id), dd.day_of_month
    ORDER BY EXTRACT(MONTH FROM dd.date_id), jour;
SPOOL OFF;

/*_________ Chiffre d'affaire de chaque mois des années 2016,2017 et 2018 _________*/
set colsep ','
set heading off
set echo off
set feedback off
set termout off
SET verify off
SET term off
set pagesize 0
SET trims ON
SET trimspool ON
set underline off
SPOOL 'E:/dwh/statistics/ca_months_161718.csv'
SELECT 'ANNEE', 'MOIS', 'CA' FROM dual;
SELECT dd.year, dd.month, SUM(fc.chiffre_affaire) ca
FROM fact_commandes fc JOIN dim_dates dd ON fc.id_date = dd.id
GROUP BY dd.year, dd.month, EXTRACT(MONTH FROM dd.date_id)
ORDER BY dd.year, EXTRACT(MONTH FROM dd.date_id);
SPOOL OFF;

/*_________ Top 10 des categories des produits qui sont trés vendu dans la region de SauPaulo en 2018 _________*/
set colsep ','
set heading off
set echo off
set feedback off
set termout off
SET verify off
SET term off
set pagesize 0
SET trims ON
SET trimspool ON
set underline off
col cat format A40
SPOOL 'E:/dwh/statistics/top10Cat_SP_2018.csv'
SELECT 'CATEGORIE', 'CA' FROM dual;
SELECT * FROM(
    SELECT dp.categorie cat, SUM(fc.chiffre_affaire) ca
    FROM fact_commandes fc 
    JOIN dim_produits dp ON fc.id_produit = dp.id
    JOIN dim_dates dd ON fc.id_date = dd.id
    JOIN dim_lieux dl ON fc.id_lieu = dl.id
    WHERE dd.year = 2018 AND dl.region = 'SP' AND categorie IS NOT NULL
    GROUP BY dp.categorie
    ORDER BY ca DESC
) WHERE ROWNUM <= 10;
SPOOL OFF;

/*____________________________ la categorie des produits qui a été trés vendu dans chaque region ________________________________*/
set colsep ','
set heading on
set echo off
set feedback off
set termout off
SET verify off
SET term off
set pagesize 0
SET trims ON
SET trimspool ON
set underline off
col CATEGORIE format A40
col REGION format A10
col CHIFFRE_AFFAIRE format A30
SPOOL 'E:/dwh/statistics/topCatOnReg.csv'
SELECT reg AS REGION, cat AS CATEGORIE, ca AS CHIFFRE_AFFAIRE
FROM(
    SELECT l.region reg, p.categorie cat, sum(chiffre_affaire) ca,
    RANK() OVER(PARTITION BY l.region ORDER BY sum(chiffre_affaire) DESC) ranking
    FROM fact_commandes 
    JOIN dim_produits p ON (id_produit = p.id)
    JOIN dim_lieux l ON (id_lieu = l.id)
    GROUP BY l.region, p.categorie
) 
WHERE ranking = 1
ORDER BY ca DESC;
SPOOL OFF;