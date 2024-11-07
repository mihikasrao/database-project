CREATE PROCEDURE AddNewProduct
    @product_name VARCHAR(100),
    @description TEXT,
    @price DECIMAL(10, 2),
    @category_id INT,
    @seller_id INT,
    @availability_status VARCHAR(10),
    @quantity_in_stock INT,
    @product_image_url VARCHAR(200)
AS
BEGIN
    INSERT INTO Products (
        name, description, price, category_id, seller_id, 
        availability_status, quantity_in_stock, product_image_url
    )
    VALUES (
        @product_name, @description, @price, @category_id, @seller_id, 
        @availability_status, @quantity_in_stock, @product_image_url
    );
END;

--this procedure simplifies the process of adding new products to the Products table by capturing all the necessary fields into a single procedure call. it helps ensure data consistency and reduces the potential for errors during entry. 
-- when a seller wants to list a new product on their platform, they can use this procedure instead of manually writing an INSERT statement everytime. this makes it easier to add products with all the required details and ensures consistency across the database. 