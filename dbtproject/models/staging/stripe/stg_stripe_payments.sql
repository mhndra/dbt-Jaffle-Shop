SELECT
    id AS payment_id,
    order_id,
    payment_method,
    (amount / 100) AS amount,
    TO_DATE(created_at) AS created_date
FROM jaffle_shop.raw.stripe_payments