DROP TABLE dim_dates;
CREATE TABLE dim_dates (
    id NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY START WITH 1,
    date_id DATE,
    year NUMBER(4),
    month VARCHAR(20),
    day_of_week VARCHAR(20),
    day_of_month NUMBER(2),
    livraison_days NUMBER
);

INSERT INTO dim_dates(date_id, year, month, day_of_week, day_of_month, livraison_days)
SELECT DISTINCT c.getDate(), c.getYear(), c.getMonth(), 
c.getDayOfWeek(), c.getDayOfMonth(), c.getLivraisonJours()
FROM commandes c;

ALTER TABLE dim_dates ADD CONSTRAINT dim_dates_pk PRIMARY KEY (id);

/*__________________________________*/


DROP TABLE dim_produits;
CREATE TABLE dim_produits (
    id NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY START WITH 1,
    produit_id VARCHAR2(100),
    categorie VARCHAR(100),
    name_length NUMBER,
    desc_length NUMBER,
    num_pics NUMBER,
    poid_gramme NUMBER
);

INSERT INTO dim_produits(produit_id, categorie, name_length,
desc_length, num_pics, poid_gramme)
SELECT p.getId(), p.getCategorie(), p.getNameLength(),
p.getDescLength(), p.getNumPics(), p.getPoid()
FROM produits p;

ALTER TABLE dim_produits ADD CONSTRAINT dim_produits_pk PRIMARY KEY (id);

/*__________________________________*/

DROP TABLE dim_avis;
CREATE TABLE dim_avis(
    id NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    avis_id VARCHAR(100),
    score NUMBER(1),
    title VARCHAR2(100),
    message VARCHAR(255),
    date_creation DATE
);

INSERT INTO dim_avis(avis_id, score, title, message, date_creation)
SELECT a.getId(), a.getScore(), a.getTitle(), a.getMessage(), a.getDate()
FROM avis a;

ALTER TABLE dim_avis ADD CONSTRAINT dim_avis_pk PRIMARY KEY (id);

/*__________________________________*/

DROP TABLE dim_lieux;
CREATE TABLE dim_lieux(
    id NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    code_postal VARCHAR2(10),
    ville VARCHAR2(50),
    region VARCHAR2(50)
);

INSERT INTO dim_lieux(code_postal, ville, region)
SELECT DISTINCT l.getCodePostal(), l.getVille(), l.getRegion()
FROM locations l;

ALTER TABLE dim_lieux ADD CONSTRAINT dim_lieux_pk PRIMARY KEY (id);

/*_______________ REMOVE REDANDANTE VALUES IN SOME TABLE __________________*/
DROP TABLE dim_lieux2;
CREATE TABLE dim_lieux2(
    id NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY START WITH 1,
    code_postal VARCHAR2(10),
    ville VARCHAR2(50),
    region VARCHAR2(50)
);

SET SERVEROUTPUT ON
DECLARE
cmp number := 0;
code VARCHAR2(10);
v_ville VARCHAR2(50);
v_region VARCHAR2(50);
CURSOR codes IS SELECT DISTINCT code_postal FROM dim_lieux;
BEGIN
    DELETE FROM dim_lieux2;
    OPEN codes; 
    LOOP 
    FETCH codes into code;
        EXIT WHEN codes%notfound;
        SELECT ville, region INTO v_ville, v_region FROM dim_lieux WHERE code_postal = code AND ROWNUM = 1;
        INSERT INTO dim_lieux2(code_postal, ville, region) 
        VALUES(code, v_ville, v_region);
        cmp := cmp + 1;
    END LOOP; 
    DBMS_OUTPUT.PUT_LINE(cmp || 'rows inserted to dim_lieux2 table.');
    CLOSE codes;
END;
/

DELETE FROM dim_lieux;
INSERT INTO dim_lieux SELECT * FROM dim_lieux2;
DROP TABLE dim_lieux2;



CREATE TABLE dim_avis2(
    id NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
    avis_id VARCHAR(100),
    score NUMBER(1),
    title VARCHAR2(100),
    message VARCHAR(255),
    date_creation DATE
);
ALTER TABLE dim_avis2 ADD CONSTRAINT dim_avis_pk PRIMARY KEY (id);

insert into dim_avis2 (avis_id,score,title,message,date_creation) 
select distinct avis_id, score, title, message, date_creation from dim_avis;

delete from dim_avis;
insert into dim_avis select * from dim_avis2;
drop table dim_avis2;


COMMIT;