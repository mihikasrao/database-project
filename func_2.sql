CREATE FUNCTION GetAverageProductRating (@product_id INT)
RETURNS DECIMAL(4, 2)
AS
BEGIN
    DECLARE @avg_rating DECIMAL(4, 2);

    SELECT @avg_rating = AVG(CAST(rating AS DECIMAL(4, 2)))
    FROM Reviews
    WHERE product_id = @product_id;

    RETURN ISNULL(@avg_rating, 0); 
END;

--this function allows you to quickly retrieve the average rating of a product, which is useful for customer analysis and informing potential buyers. 