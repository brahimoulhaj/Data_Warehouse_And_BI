HOST CLS
CREATE OR REPLACE DIRECTORY dataSrc AS 'E:/dwh/projet_dwh/dataset/brazilian-ecommerce/';
CREATE OR REPLACE DIRECTORY dataLog AS 'E:/dwh/projet_dwh/log/';

DROP TABLE customers;

CREATE TABLE customers (
    customer_id VARCHAR2(100),
    customer_unique_id VARCHAR2(100),
    customer_zip_code_prefix VARCHAR2(10),
    customer_city VARCHAR2(50),
    customer_state VARCHAR2(3)
)
ORGANIZATION EXTERNAL(
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY dataSrc
    ACCESS PARAMETERS(
        RECORDS DELIMITED BY '\n'
        SKIP 1
        CHARACTERSET UTF8
        BADFILE dataLog:'customers.bad'
        LOGFILE dataLog:'customers.log'
        FIELDS TERMINATED BY ','
        OPTIONALLY ENCLOSED BY '"'
    )
    LOCATION('olist_customers_dataset.csv')
)
REJECT LIMIT UNLIMITED;

SELECT COUNT(*) FROM customers;

/*-------------------------------*/
DROP TABLE geolocation;

CREATE TABLE geolocation (
    geolocation_zip_code_prefix VARCHAR2(10),
    geolocation_lat VARCHAR2(20),
    geolocation_lng VARCHAR2(20),
    geolocation_city VARCHAR2(50),
    geolocation_state VARCHAR2(3)
)
ORGANIZATION EXTERNAL(
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY dataSrc
    ACCESS PARAMETERS(
        RECORDS DELIMITED BY '\n'
        SKIP 1
        CHARACTERSET UTF8
        BADFILE dataLog:'geolocation.bad'
        LOGFILE dataLog:'geolocation.log'
        FIELDS TERMINATED BY ','
        OPTIONALLY ENCLOSED BY '"'
    )
    LOCATION('olist_geolocation_dataset.csv')
)
REJECT LIMIT UNLIMITED;

SELECT COUNT(*) FROM geolocation;

/*-------------------------------*/
DROP TABLE order_items;

CREATE TABLE order_items (
    order_id VARCHAR2(100),
    order_item_id VARCHAR2(3),
    product_id VARCHAR2(100),
    seller_id VARCHAR2(100),
    shipping_limit_date VARCHAR2(50),
    price VARCHAR2(10),
    freight_value VARCHAR2(10)
)
ORGANIZATION EXTERNAL(
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY dataSrc
    ACCESS PARAMETERS(
        RECORDS DELIMITED BY '\n'
        SKIP 1
        CHARACTERSET UTF8
        BADFILE dataLog:'order_items.bad'
        LOGFILE dataLog:'order_items.log'
        FIELDS TERMINATED BY ','
        OPTIONALLY ENCLOSED BY '"'
    )
    LOCATION('olist_order_items_dataset.csv')
)
REJECT LIMIT UNLIMITED;

SELECT COUNT(*) FROM order_items;

/*-------------------------------*/
DROP TABLE order_reviews;

CREATE TABLE order_reviews (
    review_id VARCHAR2(100),
    order_id VARCHAR2(100),
    review_score VARCHAR2(1),
    review_comment_title VARCHAR2(50),
    review_comment_message VARCHAR2(255),
    review_creation_date VARCHAR2(25),
    review_answer_timestamp VARCHAR2(25)
)
ORGANIZATION EXTERNAL(
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY dataSrc
    ACCESS PARAMETERS(
        RECORDS DELIMITED BY '\n'
        SKIP 1
        CHARACTERSET UTF8
        BADFILE dataLog:'order_reviews.bad'
        LOGFILE dataLog:'order_reviews.log'
        FIELDS TERMINATED BY ','
        OPTIONALLY ENCLOSED BY '"'
    )
    LOCATION('olist_order_reviews_dataset.csv')
)
REJECT LIMIT UNLIMITED;

SELECT COUNT(*) FROM order_reviews;

/*-------------------------------*/
DROP TABLE orders;

CREATE TABLE orders (
    order_id VARCHAR2(100),
    customer_id VARCHAR2(100),
    order_status VARCHAR2(50),
    order_purchase_timestamp VARCHAR2(25),
    order_approved_at VARCHAR2(25),
    order_delivered_carrier_date VARCHAR2(25),
    order_delivered_customer_date VARCHAR2(25),
    order_estimated_delivery_date VARCHAR2(25)
)
ORGANIZATION EXTERNAL(
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY dataSrc
    ACCESS PARAMETERS(
        RECORDS DELIMITED BY '\n'
        SKIP 1
        CHARACTERSET UTF8
        BADFILE dataLog:'orders.bad'
        LOGFILE dataLog:'orders.log'
        FIELDS TERMINATED BY ','
        OPTIONALLY ENCLOSED BY '"'
    )
    LOCATION('olist_orders_dataset.csv')
)
REJECT LIMIT UNLIMITED;

SELECT COUNT(*) FROM orders;

/*-------------------------------*/
DROP TABLE products;

CREATE TABLE products (
    product_id VARCHAR2(100),
    product_category_name VARCHAR2(50),
    product_name_lenght VARCHAR2(10),
    product_description_lenght VARCHAR2(10),
    product_photos_qty VARCHAR2(5),
    product_weight_g VARCHAR2(10),
    product_length_cm VARCHAR2(3),
    product_height_cm VARCHAR2(3),
    product_width_cm VARCHAR2(3)
)
ORGANIZATION EXTERNAL(
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY dataSrc
    ACCESS PARAMETERS(
        RECORDS DELIMITED BY '\n'
        SKIP 1
        CHARACTERSET UTF8
        BADFILE dataLog:'products.bad'
        LOGFILE dataLog:'products.log'
        FIELDS TERMINATED BY ','
        OPTIONALLY ENCLOSED BY '"'
    )
    LOCATION('olist_products_dataset.csv')
)
REJECT LIMIT UNLIMITED;

SELECT COUNT(*) FROM products;

/*-------------------------------*/
DROP TABLE sellers;

CREATE TABLE sellers (
    seller_id VARCHAR2(100),
    seller_zip_code_prefix VARCHAR2(10),
    seller_city VARCHAR2(50),
    seller_state VARCHAR2(3)
)
ORGANIZATION EXTERNAL(
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY dataSrc
    ACCESS PARAMETERS(
        RECORDS DELIMITED BY '\n'
        SKIP 1
        CHARACTERSET UTF8
        BADFILE dataLog:'sellers.bad'
        LOGFILE dataLog:'sellers.log'
        FIELDS TERMINATED BY ','
        OPTIONALLY ENCLOSED BY '"'
    )
    LOCATION('olist_sellers_dataset.csv')
)
REJECT LIMIT UNLIMITED;

SELECT COUNT(*) FROM sellers;

/*-------------------------------*/
DROP TABLE product_category_name_translation;

CREATE TABLE product_category_name_translation (
    product_category_name VARCHAR2(100),
    product_category_name_english VARCHAR2(100)
)
ORGANIZATION EXTERNAL(
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY dataSrc
    ACCESS PARAMETERS(
        RECORDS DELIMITED BY '\n'
        SKIP 1
        CHARACTERSET UTF8
        BADFILE dataLog:'product_category_name_translation.bad'
        LOGFILE dataLog:'product_category_name_translation.log'
        FIELDS TERMINATED BY ','
        OPTIONALLY ENCLOSED BY '"'
    )
    LOCATION('product_category_name_translation.csv')
)
REJECT LIMIT UNLIMITED;

SELECT COUNT(*) FROM product_category_name_translation;

COMMIT;