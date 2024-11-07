CREATE FUNCTION CalculateTotalSalesForSeller (@seller_id INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @total_sales DECIMAL(10, 2);

    SELECT @total_sales = SUM(OD.price_at_time_of_order * OD.quantity)
    FROM OrderDetails OD
    JOIN Products P ON OD.product_id = P.product_id
    WHERE P.seller_id = @seller_id;

    RETURN ISNULL(@total_sales, 0); 
END;

--this function provides sellers with an overview of their sales performance. it can be used to 
-- generate reports or display sales data on the seller's dashboards. 