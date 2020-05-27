set heading off
set echo off
set feedback off
set pagesize 0
SPOOL 'E:/dwh/statistics/topCatOnReg.csv'
SELECT TRIM(TO_CHAR(reg)) || ',' || TRIM(TO_CHAR(cat)) || ',' || TRIM(TO_CHAR(ca))
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