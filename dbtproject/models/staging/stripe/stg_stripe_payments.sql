SELECT
    id AS payment_id,
    order_id,
    payment_method,
    status,
    (amount / 100) AS amount,
    TO_DATE(created_at) AS created_date
FROM {{ source('raw', 'stripe_payments') }}