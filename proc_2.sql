CREATE PROCEDURE GetOrdersByBuyer
    @buyer_id INT
AS
BEGIN
    SELECT
        Orders.order_id,
        Orders.order_status,
        Orders.order_date,
        Payments.payment_method,
        Payments.amount_paid
    FROM Orders
    JOIN Payments ON Orders.order_id = Payments.order_id
    WHERE Orders.buyer_id = @buyer_id;
END;

--this procedure gets all the orders associated witht eh buyer, such as order status, order date, and payment details. it is useful for providing buyers with an order history. 
-- when a buyer logs into their account and wants to view their past oders, this procedure is good to get the data quickly. it can also be used by customer agents to access order details when assisting buyers. 