-- View for showing products with category and seller information
CREATE VIEW ProductDetails AS
    SELECT 
        Products.product_id,
        Products.name AS product_name,
        Products.description,
        Products.price,
        Categories.category_name,
        Sellers.business_name AS seller_name,
        Products.availability_status,
        Products.quantity_in_stock
    FROM
        Products
            JOIN
        Categories ON Products.category_id = Categories.category_id
            JOIN
        Sellers ON Products.seller_id = Sellers.seller_id;