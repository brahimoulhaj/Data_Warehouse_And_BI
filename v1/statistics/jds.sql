set heading off
set echo off
set feedback off
set pagesize 0
SPOOL 'E:/dwh/statistics/jds.csv'
select 'MOIS,JDS,CA' from dual;
select trim(mois)||','||trim(jds)||','||ca from(
    select mois, jds, sum(ca) ca,rank() over(PARTITION BY mois ORDER BY sum(ca) desc) ranking
    from(
        select sum(f.chiffre_affaire) ca, d.month mois, d.day_of_week jds
        from fact_commandes f
        join dim_dates d on d.id = f.id_date
        where d.year = 2017
        group by d.month, d.day_of_week
    )
    group by mois, jds
) where ranking = 1 order by to_date(mois,'MONTH');
SPOOL OFF;