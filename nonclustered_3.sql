-- Index 3: Non-clustered index on the 'order_status' column in the Orders table
-- This index will improve the efficiency of queries that filter orders by status, 
-- such as retrieving all "Processing" or "Shipped" orders.
CREATE NONCLUSTERED INDEX idx_orders_order_status
ON Orders (order_status);