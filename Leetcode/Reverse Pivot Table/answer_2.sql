SELECT 
    p.product_id, 
    s.store, 
    s.price
FROM 
    Products p
CROSS JOIN LATERAL (
    VALUES
        ('store1', p.store1),
        ('store2', p.store2),
        ('store3', p.store3)
) AS s (store, price)
WHERE s.price IS NOT NULL;