-- View for displaying order details along with buyer information
CREATE VIEW OrderSummary AS
    SELECT 
        Orders.order_id,
        Users.name AS buyer_name,
        Orders.order_status,
        Orders.order_date,
        Orders.shipped_date,
        Orders.delivered_date
    FROM
        Orders
            JOIN
        Buyers ON Orders.buyer_id = Buyers.buyer_id
            JOIN
        Users ON Buyers.user_id = Users.user_id;