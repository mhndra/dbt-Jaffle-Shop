SELECT
    id AS order_id,
    user_id AS customer_id,
    TO_DATE(order_date) AS order_date,
    status
FROM {{ source('raw', 'orders') }}