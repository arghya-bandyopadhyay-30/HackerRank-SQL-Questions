WITH filtered_products AS (
    SELECT
        product_id,
        MAX(change_date) AS max_change_date
    FROM
        Products p
    WHERE
        change_date <= '2019-08-16'
    GROUP BY
        product_id
)
(
    SELECT
        p.product_id,
        p.new_price AS price
    FROM
        Products p
    INNER JOIN
        filtered_products fp
    ON
        fp.product_id = p.product_id 
        AND fp.max_change_date = p.change_date
)
UNION
(
    SELECT
        p.product_id,
        10 AS price
    FROM
        Products p
    WHERE
        p.product_id NOT IN (
            SELECT
                product_id
            FROM
                filtered_products
        )
);