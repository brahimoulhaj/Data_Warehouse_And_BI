set heading off
set echo off
set feedback off
set pagesize 0
SPOOL 'E:/dwh/statistics/score.csv'
select 'SCORE,CA' from dual;
SELECT score||','||SUM(ca)
FROM(
    SELECT f.commande_id, a.score, SUM(f.chiffre_affaire) ca
    FROM fact_commandes f JOIN dim_avis a ON a.id = f.id_avis
    GROUP BY f.commande_id, a.score
) GROUP BY score;
SPOOL OFF;