-- Index 2: Non-clustered index on the 'category_id' and 'price' columns in the Products table
-- This index will help optimize queries that filter products by category and price range.
CREATE NONCLUSTERED INDEX idx_products_category_price
ON Products (category_id, price);