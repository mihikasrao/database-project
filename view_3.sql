-- View for displaying product reviews with buyer and product information
CREATE VIEW ProductReviews AS
    SELECT 
        Reviews.review_id,
        Products.name AS product_name,
        Users.name AS buyer_name,
        Reviews.rating,
        Reviews.review_text,
        Reviews.review_date
    FROM
        Reviews
            JOIN
        Buyers ON Reviews.buyer_id = Buyers.buyer_id
            JOIN
        Users ON Buyers.user_id = Users.user_id
            JOIN
        Products ON Reviews.product_id = Products.product_id;