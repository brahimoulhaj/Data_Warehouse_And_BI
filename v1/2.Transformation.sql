/*______________ LOCATIONS TABLE ________________*/
CREATE OR REPLACE TYPE type_location AS OBJECT (
    code_postal VARCHAR2(10),
    ville VARCHAR2(50),
    region VARCHAR2(50),
    MEMBER FUNCTION getCodePostal RETURN VARCHAR2,
    MEMBER FUNCTION getVille RETURN VARCHAR2,
    MEMBER FUNCTION getRegion RETURN VARCHAR2
);
/

CREATE OR REPLACE TYPE BODY type_location AS
    MEMBER FUNCTION getCodePostal RETURN VARCHAR2 IS
    BEGIN
        RETURN code_postal;
    END;
    MEMBER FUNCTION getVille RETURN VARCHAR2 IS
    BEGIN
        RETURN ville;
    END;
    MEMBER FUNCTION getRegion RETURN VARCHAR2 IS
    BEGIN
        RETURN region;
    END;
END;
/

DROP TABLE locations;
CREATE TABLE locations OF type_location;

INSERT INTO locations 
SELECT GEOLOCATION_ZIP_CODE_PREFIX, GEOLOCATION_CITY, GEOLOCATION_STATE
FROM GEOLOCATION;

/*______________ PRODUITS TABLE ________________*/
CREATE OR REPLACE TYPE type_produit AS OBJECT (
    id VARCHAR2(100),
    categorie VARCHAR2(50),
    name_length VARCHAR2(4),
    desc_length VARCHAR2(11),
    num_pics VARCHAR2(4),
    poid_gramme VARCHAR2(10),
    MEMBER FUNCTION getId RETURN VARCHAR2,
    MEMBER FUNCTION getCategorie RETURN VARCHAR2,
    MEMBER FUNCTION getNameLength RETURN NUMBER,
    MEMBER FUNCTION getDescLength RETURN NUMBER,
    MEMBER FUNCTION getNumPics RETURN NUMBER,
    MEMBER FUNCTION getPoid RETURN NUMBER
);
/

CREATE OR REPLACE TYPE BODY type_produit AS
    MEMBER FUNCTION getId RETURN VARCHAR2 IS
    BEGIN
        RETURN id;
    END;
    MEMBER FUNCTION getCategorie RETURN VARCHAR2 IS
    BEGIN
        RETURN categorie;
    END;
    MEMBER FUNCTION getNameLength RETURN NUMBER IS
    BEGIN
        RETURN TO_NUMBER(name_length);
    END;
    MEMBER FUNCTION getDescLength RETURN NUMBER IS
    BEGIN
        RETURN TO_NUMBER(desc_length);
    END;
    MEMBER FUNCTION getNumPics RETURN NUMBER IS
    BEGIN
        RETURN TO_NUMBER(num_pics);
    END;
    MEMBER FUNCTION getPoid RETURN NUMBER IS
    BEGIN
        RETURN TO_NUMBER(poid_gramme);
    END;
END;
/

DROP TABLE produits;
CREATE TABLE produits OF type_produit;

INSERT INTO produits 
SELECT PRODUCT_ID, PRODUCT_CATEGORY_NAME, PRODUCT_NAME_LENGHT,
PRODUCT_DESCRIPTION_LENGHT, PRODUCT_PHOTOS_QTY,
PRODUCT_WEIGHT_G
FROM PRODUCTS;

/*______________ CLIENTS TABLE ________________*/
CREATE OR REPLACE TYPE type_client AS OBJECT (
    id VARCHAR2(100),
    code_postal VARCHAR2(10),
    ville VARCHAR2(50),
    region VARCHAR2(50),
    MEMBER FUNCTION getId RETURN VARCHAR2
);
/

CREATE OR REPLACE TYPE BODY type_client AS
    MEMBER FUNCTION getId RETURN VARCHAR2 IS
    BEGIN
        RETURN id;
    END;
END;
/

DROP TABLE clients;
CREATE TABLE clients OF type_client;

INSERT INTO clients
SELECT CUSTOMER_ID, CUSTOMER_ZIP_CODE_PREFIX, CUSTOMER_CITY, CUSTOMER_STATE
FROM CUSTOMERS;

/*______________ COMMANDES TABLE ________________*/
DROP TABLE commandes;
CREATE OR REPLACE TYPE type_commande AS OBJECT (
    cid VARCHAR2(100),
    quantite VARCHAR2(4),
    prix VARCHAR2(10),
    produit_id VARCHAR2(100),
    client_id VARCHAR2(100),
    date_achat VARCHAR2(25),
    date_livraison VARCHAR2(25),
    MEMBER FUNCTION getId RETURN VARCHAR2,
    MEMBER FUNCTION getQuantite RETURN NUMBER,
    MEMBER FUNCTION getPrix RETURN NUMBER,
    MEMBER FUNCTION getProduit RETURN VARCHAR2,
    MEMBER FUNCTION getClient RETURN VARCHAR2,
    MEMBER FUNCTION getDate RETURN DATE,
    MEMBER FUNCTION getYear RETURN NUMBER,
    MEMBER FUNCTION getMonth RETURN VARCHAR2,
    MEMBER FUNCTION getDayOfWeek RETURN VARCHAR2,
    MEMBER FUNCTION getDayOfMonth RETURN NUMBER,
    MEMBER FUNCTION getLivraisonJours RETURN NUMBER,
    MEMBER FUNCTION getLieu RETURN VARCHAR2,
    MEMBER FUNCTION getAvis RETURN VARCHAR2
);
/

CREATE OR REPLACE TYPE BODY type_commande AS
    MEMBER FUNCTION getId RETURN VARCHAR2 IS
    BEGIN
        RETURN cid;
    END;
    MEMBER FUNCTION getQuantite RETURN NUMBER IS
    BEGIN
        RETURN TO_NUMBER(quantite);
    END;
    MEMBER FUNCTION getPrix RETURN NUMBER IS
    BEGIN
        RETURN TO_NUMBER(prix);
    END;
    MEMBER FUNCTION getProduit RETURN VARCHAR2 IS
    BEGIN
        RETURN produit_id;
    END;
    MEMBER FUNCTION getClient RETURN VARCHAR2 IS
    BEGIN
        RETURN client_id;
    END;
    MEMBER FUNCTION getDate RETURN DATE IS
    BEGIN
        RETURN TO_DATE(SUBSTR(date_achat, 1, 10), 'yyyy-mm-dd');
    END;
    MEMBER FUNCTION getYear RETURN NUMBER IS
    BEGIN
        RETURN TO_NUMBER(SUBSTR(date_achat, 1, 4));
    END;
    MEMBER FUNCTION getMonth RETURN VARCHAR2 IS
    ladate DATE;
    BEGIN
        ladate := TO_DATE(SUBSTR(date_achat, 1, 10), 'yyyy-mm-dd');
        RETURN TO_CHAR(ladate, 'Month');
    END;
    MEMBER FUNCTION getDayOfWeek RETURN VARCHAR2 IS
    ladate DATE;
    BEGIN
        ladate := TO_DATE(SUBSTR(date_achat, 1, 10), 'yyyy-mm-dd');
        RETURN TO_CHAR(ladate, 'Day');
    END;
    MEMBER FUNCTION getDayOfMonth RETURN NUMBER IS
    ladate DATE;
    BEGIN
        ladate := TO_DATE(SUBSTR(date_achat, 1, 10), 'yyyy-mm-dd');
        RETURN EXTRACT(DAY FROM ladate);
    END;
    MEMBER FUNCTION getLivraisonJours RETURN NUMBER IS
    dateachat DATE := TO_DATE(SUBSTR(date_achat, 1, 10), 'yyyy-mm-dd');
    datelivraison DATE := TO_DATE(SUBSTR(date_livraison, 1, 10), 'yyyy-mm-dd');
    BEGIN
        RETURN datelivraison-dateachat;
    END;
    MEMBER FUNCTION getLieu RETURN VARCHAR2 IS
    postal VARCHAR2(10);
    BEGIN
        SELECT c.code_postal INTO postal FROM clients c WHERE c.id = client_id;
        RETURN postal;
    END;
    MEMBER FUNCTION getAvis RETURN VARCHAR2 IS
    avis_id VARCHAR2(100);
    BEGIN
        SELECT avis.id INTO avis_id FROM avis 
        WHERE avis.COMMANDE_ID = cid AND ROWNUM = 1;
        RETURN avis_id;
    END;
END;
/

DROP TABLE commandes;
CREATE TABLE commandes OF type_commande;

DROP VIEW view_orders;
CREATE VIEW view_orders AS
SELECT oi.ORDER_ID, oi.ORDER_ITEM_ID, oi.PRICE, oi.PRODUCT_ID, 
o.CUSTOMER_ID, o.ORDER_PURCHASE_TIMESTAMP, o.ORDER_DELIVERED_CUSTOMER_DATE
FROM orders o JOIN order_items oi 
ON (o.order_id=oi.order_id)
WHERE o.order_status = 'delivered';

INSERT INTO commandes SELECT * FROM view_orders;

/*______________ AVIS TABLE ________________*/
CREATE OR REPLACE TYPE type_avis AS OBJECT (
    id VARCHAR2(100),
    commande_id VARCHAR2(100),
    score VARCHAR2(1),
    title VARCHAR2(100),
    message VARCHAR2(300),
    date_creation VARCHAR2(25),
    MEMBER FUNCTION getId RETURN VARCHAR2,
    MEMBER FUNCTION getCommandeId RETURN VARCHAR2,
    MEMBER FUNCTION getScore RETURN NUMBER,
    MEMBER FUNCTION getTitle RETURN VARCHAR2,
    MEMBER FUNCTION getMessage RETURN VARCHAR2,
    MEMBER FUNCTION getDate RETURN DATE
);
/

CREATE OR REPLACE TYPE BODY type_avis AS
    MEMBER FUNCTION getId RETURN VARCHAR2 IS
    BEGIN
        RETURN id;
    END;
    MEMBER FUNCTION getCommandeId RETURN VARCHAR2 IS
    BEGIN
        RETURN commande_id;
    END;
    MEMBER FUNCTION getScore RETURN NUMBER IS
    BEGIN
        RETURN TO_NUMBER(score);
    END;
    MEMBER FUNCTION getTitle RETURN VARCHAR2 IS
    BEGIN
        RETURN title;
    END;
    MEMBER FUNCTION getMessage RETURN VARCHAR2 IS
    BEGIN
        RETURN message;
    END;
    MEMBER FUNCTION getDate RETURN DATE IS
    BEGIN
        RETURN TO_DATE(SUBSTR(date_creation, 1, 10), 'yyyy-mm-dd');
    END;
END;
/

DROP TABLE avis;
CREATE TABLE avis OF type_avis;

INSERT INTO avis 
SELECT REVIEW_ID, ORDER_ID, REVIEW_SCORE, REVIEW_COMMENT_TITLE,
REVIEW_COMMENT_MESSAGE, REVIEW_CREATION_DATE FROM ORDER_REVIEWS;

COMMIT;