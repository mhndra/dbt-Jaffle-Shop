SELECT
    order_id,
    SUM(amount) AS total_amount
FROM {{ ref('stg_stripe_payments') }}
GROUP BY order_id
HAVING SUM(amount) < 0