CREATE FUNCTION GetTotalQuantitySold (@product_id INT)
RETURNS INT
AS
BEGIN
    DECLARE @total_quantity_sold INT;

    SELECT @total_quantity_sold = SUM(quantity)
    FROM OrderDetails
    WHERE product_id = @product_id;

    RETURN ISNULL(@total_quantity_sold, 0);
END;

--this function helps track the sales amoutn of each product, which is good for inventory management, sales analysis, and identifying popular items. 