WITH orders AS (
    SELECT *
    FROM {{ ref('fact_orders') }}
), customers AS (
    SELECT *
    FROM {{ ref('stg_customers') }}
), customer_orders AS (
    SELECT
        customer_id,
        MIN(order_date) AS first_order_date,
        MAX(order_date) AS most_recent_order_date,
        COUNT(order_id) AS order_count,
        SUM(amount) AS lifetime_value
    FROM orders
    GROUP BY customer_id
), final AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        co.first_order_date,
        co.most_recent_order_date,
        COALESCE(co.order_count, 0) AS order_count,
        co.lifetime_value
    FROM customers c
    LEFT JOIN customer_orders co 
        USING (customer_id)
)
SELECT * FROM final