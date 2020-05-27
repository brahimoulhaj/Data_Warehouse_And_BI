COL table_name FORMAT A40
SELECT table_name FROM user_tables;
/*
SQL> COL table_name FORMAT A40
SQL> SELECT table_name FROM user_tables;

TABLE_NAME
----------------------------------------
GEOLOCATION
CUSTOMERS
ORDER_ITEMS
ORDER_PAYMENTS
ORDER_REVIEWS
ORDERS
PRODUCT_CATEGORY_NAME_TRANSLATION
PRODUCTS
SELLERS

9 rows selected.
*/

/*----------------------------------------*/
DESC GEOLOCATION;
DESC CUSTOMERS;
DESC ORDER_ITEMS;
DESC ORDER_PAYMENTS;
DESC ORDER_REVIEWS;
DESC ORDERS;
DESC PRODUCT_CATEGORY_NAME_TRANSLATION;
DESC PRODUCTS;
DESC SELLERS;

/*
SQL> DESC GEOLOCATION;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 GEOLOCATION_ZIP_CODE_PREFIX                        VARCHAR2(10)
 GEOLOCATION_LAT                                    VARCHAR2(20)
 GEOLOCATION_LNG                                    VARCHAR2(20)
 GEOLOCATION_CITY                                   VARCHAR2(50)
 GEOLOCATION_STATE                                  VARCHAR2(3)

SQL> DESC CUSTOMERS;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 CUSTOMER_ID                                        VARCHAR2(100)
 CUSTOMER_UNIQUE_ID                                 VARCHAR2(100)
 CUSTOMER_ZIP_CODE_PREFIX                           VARCHAR2(10)
 CUSTOMER_CITY                                      VARCHAR2(50)
 CUSTOMER_STATE                                     VARCHAR2(3)

SQL> DESC ORDER_ITEMS;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 ORDER_ID                                           VARCHAR2(100)
 ORDER_ITEM_ID                                      VARCHAR2(3)
 PRODUCT_ID                                         VARCHAR2(100)
 SELLER_ID                                          VARCHAR2(100)
 SHIPPING_LIMIT_DATE                                VARCHAR2(50)
 PRICE                                              VARCHAR2(10)
 FREIGHT_VALUE                                      VARCHAR2(10)

SQL> DESC ORDER_PAYMENTS;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 ORDER_ID                                           VARCHAR2(100)
 PAYMENT_SEQUENTIAL                                 VARCHAR2(4)
 PAYMENT_TYPE                                       VARCHAR2(20)
 PAYMENT_INSTALLMENTS                               VARCHAR2(4)
 PAYMENT_VALUE                                      VARCHAR2(10)

SQL> DESC ORDER_REVIEWS;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 REVIEW_ID                                          VARCHAR2(100)
 ORDER_ID                                           VARCHAR2(100)
 REVIEW_SCORE                                       VARCHAR2(1)
 REVIEW_COMMENT_TITLE                               VARCHAR2(50)
 REVIEW_COMMENT_MESSAGE                             VARCHAR2(255)
 REVIEW_CREATION_DATE                               VARCHAR2(25)
 REVIEW_ANSWER_TIMESTAMP                            VARCHAR2(25)

SQL> DESC ORDERS;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 ORDER_ID                                           VARCHAR2(100)
 CUSTOMER_ID                                        VARCHAR2(100)
 ORDER_STATUS                                       VARCHAR2(50)
 ORDER_PURCHASE_TIMESTAMP                           VARCHAR2(25)
 ORDER_APPROVED_AT                                  VARCHAR2(25)
 ORDER_DELIVERED_CARRIER_DATE                       VARCHAR2(25)
 ORDER_DELIVERED_CUSTOMER_DATE                      VARCHAR2(25)
 ORDER_ESTIMATED_DELIVERY_DATE                      VARCHAR2(25)

SQL> DESC PRODUCT_CATEGORY_NAME_TRANSLATION;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 PRODUCT_CATEGORY_NAME                              VARCHAR2(100)
 PRODUCT_CATEGORY_NAME_ENGLISH                      VARCHAR2(100)

SQL> DESC PRODUCTS;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 PRODUCT_ID                                         VARCHAR2(100)
 PRODUCT_CATEGORY_NAME                              VARCHAR2(50)
 PRODUCT_NAME_LENGHT                                VARCHAR2(10)
 PRODUCT_DESCRIPTION_LENGHT                         VARCHAR2(10)
 PRODUCT_PHOTOS_QTY                                 VARCHAR2(5)
 PRODUCT_WEIGHT_G                                   VARCHAR2(10)
 PRODUCT_LENGTH_CM                                  VARCHAR2(3)
 PRODUCT_HEIGHT_CM                                  VARCHAR2(3)
 PRODUCT_WIDTH_CM                                   VARCHAR2(3)

SQL> DESC SELLERS;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 SELLER_ID                                          VARCHAR2(100)
 SELLER_ZIP_CODE_PREFIX                             VARCHAR2(10)
 SELLER_CITY                                        VARCHAR2(50)
 SELLER_STATE                                       VARCHAR2(3)
*/

/*----------------------------------------*/
SELECT COUNT(*) AS TABLE_GEOLOCATION FROM GEOLOCATION;
SELECT COUNT(*) AS TABLE_CUSTOMERS FROM CUSTOMERS;
SELECT COUNT(*) AS TABLE_ORDER_ITEMS FROM ORDER_ITEMS;
SELECT COUNT(*) AS TABLE_ORDER_PAYMENTS FROM ORDER_PAYMENTS;
SELECT COUNT(*) AS TABLE_ORDER_REVIEWS FROM ORDER_REVIEWS;
SELECT COUNT(*) AS TABLE_ORDERS FROM ORDERS;
SELECT COUNT(*) AS TABLE_TRANSLATION FROM PRODUCT_CATEGORY_NAME_TRANSLATION;
SELECT COUNT(*) AS TABLE_PRODUCTS FROM PRODUCTS;
SELECT COUNT(*) AS TABLE_SELLERS FROM SELLERS;
/*
SQL> SELECT COUNT(*) FROM GEOLOCATION;

  COUNT(*)
----------
   1000075

SQL> SELECT COUNT(*) FROM CUSTOMERS;

  COUNT(*)
----------
     99441

SQL> SELECT COUNT(*) FROM ORDER_ITEMS;

  COUNT(*)
----------
    112650

SQL> SELECT COUNT(*) FROM ORDER_PAYMENTS;

  COUNT(*)
----------
    103886

SQL> SELECT COUNT(*) FROM ORDER_REVIEWS;

  COUNT(*)
----------
     95994

SQL> SELECT COUNT(*) FROM ORDERS;

  COUNT(*)
----------
     99441

SQL> SELECT COUNT(*) FROM PRODUCT_CATEGORY_NAME_TRANSLATION;

  COUNT(*)
----------
        71

SQL> SELECT COUNT(*) FROM PRODUCTS;

  COUNT(*)
----------
     32949

SQL> SELECT COUNT(*) FROM SELLERS;

  COUNT(*)
----------
      3095
*/