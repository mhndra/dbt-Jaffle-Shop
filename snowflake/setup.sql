/* Set worksheet context */

USE ROLE sysadmin;

USE WAREHOUSE compute_wh;


/* Create a database */

CREATE DATABASE IF NOT EXISTS jaffle_shop;


/* Create schema */

CREATE SCHEMA IF NOT EXISTS jaffle_shop.raw;

CREATE SCHEMA IF NOT EXISTS jaffle_shop.dbt_mhndra;


/* Create tables */

-- Transient table: customers
CREATE OR REPLACE TRANSIENT TABLE jaffle_shop.raw.customers (
    id REAL,
    first_name STRING,
    last_name STRING
);

-- Transient table: orders
CREATE OR REPLACE TRANSIENT TABLE jaffle_shop.raw.orders (
    id REAL,
    user_id REAL,
    order_date STRING,
    status STRING,
    etl_loaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

-- Transient table: stripe_payments
CREATE OR REPLACE TRANSIENT TABLE jaffle_shop.raw.stripe_payments (
    id REAL,
    order_id REAL,
    payment_method STRING,
    status STRING,
    amount REAL,
    created_at STRING,
    batched_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);


/* Load Jaffle Shop files using COPY INTO <table> */

COPY INTO jaffle_shop.raw.customers
FROM 's3://dbt-tutorial-public/jaffle_shop_customers.csv'
FILE_FORMAT = (
    TYPE = 'CSV'
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
);

SELECT * FROM jaffle_shop.raw.customers;

COPY INTO jaffle_shop.raw.orders (
    id,
    user_id,
    order_date,
    status
)
FROM 's3://dbt-tutorial-public/jaffle_shop_orders.csv'
FILE_FORMAT = (
    TYPE = 'CSV'
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
);

SELECT * FROM jaffle_shop.raw.orders;

COPY INTO jaffle_shop.raw.stripe_payments (
    id,
    order_id,
    payment_method,
    status,
    amount,
    created_at
)
FROM 's3://dbt-tutorial-public/stripe_payments.csv'
FILE_FORMAT = (
    TYPE = 'CSV'
    FIELD_DELIMITER = ','
    SKIP_HEADER = 1
);

SELECT * FROM jaffle_shop.raw.stripe_payments;