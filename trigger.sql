CREATE TRIGGER trg_UpdateProductStock
ON OrderDetails
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE P
    SET P.quantity_in_stock = P.quantity_in_stock - I.quantity
    FROM Products P
    INNER JOIN inserted I ON P.product_id = I.product_id

    IF EXISTS (
        SELECT 1
        FROM Products
        WHERE quantity_in_stock < 0
    )
    BEGIN
        RAISERROR ('Insufficient stock for one or more products.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
