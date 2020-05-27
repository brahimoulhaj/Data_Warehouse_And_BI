set heading off
set echo off
set feedback off
set pagesize 0
SPOOL 'E:/dwh/statistics/livraison.csv'
SELECT 'Référence du produit, Catégorie, Jours de livraison, Chiffre d"affaire' FROM DUAL;
SELECT TRIM(produit_id)|| ',' ||TRIM(categorie)|| ',' ||TRIM(TO_CHAR(livraison_days))|| ',' ||TRIM(TO_CHAR(ca))
FROM(
    SELECT f.commande_id, SUM(f.chiffre_affaire) ca, p.produit_id,  p.categorie, d.livraison_days
    FROM fact_commandes f JOIN dim_produits p ON p.id = f.id_produit
    JOIN dim_dates d ON d.id = f.id_date
    GROUP BY f.commande_id, p.produit_id,  p.categorie, d.livraison_days
    ORDER BY 2
) WHERE ROWNUM <= 10;
SPOOL OFF;