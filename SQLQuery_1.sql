CREATE PROCEDURE UpdateProductStock
    @product_id INT,
    @quantity_sold INT
AS
BEGIN
    DECLARE @current_stock INT;

    SELECT @current_stock = quantity_in_stock
    FROM Products
    WHERE product_id = @product_id;

    IF @current_stock >= @quantity_sold
    BEGIN
        UPDATE Products
        SET quantity_in_stock = quantity_in_stock - @quantity_sold
        WHERE product_id = @product_id;
    END
    ELSE
    BEGIN
        RAISERROR ('Insufficient stock for the product.', 16, 1);
    END
END;



--this procedure updates the quantity_in_stock for a product whenever a sale is made, based on the quantity sold. It ensures taht your inventory data remains accurate and up-to-date, which is important for e-commerce platforms so you don't oversell. 
-- everytime an order is placed and the details are saved in the OrderDetails table, this procedure can be called to adjust the stock level of the products. this ensures there is accurate stock information. 