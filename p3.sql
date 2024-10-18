--creating tables 

CREATE TABLE Users (
    user_id INT PRIMARY KEY, 
    name VARCHAR(100) NOT NULL, 
    email VARCHAR(100) UNIQUE NOT NULL, 
    password VARCHAR(100) NOT NULL, 
    role VARCHAR(10) NOT NULL CHECK (role IN ('buyer', 'seller')),
    address VARCHAR(200)
); 

CREATE TABLE Buyers (
    buyer_id INT PRIMARY KEY, 
    user_id INT NOT NULL, 
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
); 

CREATE TABLE Sellers (
    seller_id INT PRIMARY KEY, 
    user_id INT NOT NULL, 
    business_name VARCHAR(100), 
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
); 

CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0), --check 1
    category_id INT NOT NULL,
    seller_id INT NOT NULL,
    availability_status VARCHAR(10) NOT NULL CHECK (availability_status IN ('active', 'inactive')), --check2
    quantity_in_stock INT NOT NULL CHECK (quantity_in_stock >= 0), -- check 3
    product_image_url VARCHAR(200),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id),
    FOREIGN KEY (seller_id) REFERENCES Sellers(seller_id)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    buyer_id INT NOT NULL,
    order_status VARCHAR(20) NOT NULL CHECK (order_status IN ('Processing', 'Shipped', 'Delivered')),
    order_date DATE DEFAULT CURRENT_TIMESTAMP,
    shipped_date DATE,
    delivered_date DATE,
    FOREIGN KEY (buyer_id) REFERENCES Buyers(buyer_id)
);

CREATE TABLE OrderDetails (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    price_at_time_of_order DECIMAL(10,2) NOT NULL CHECK (price_at_time_of_order >= 0),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Reviews (
    review_id INT PRIMARY KEY,
    buyer_id INT NOT NULL,
    product_id INT NOT NULL,
    order_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_date DATE DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (buyer_id) REFERENCES Buyers(buyer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

CREATE TABLE InventoryManagement (
    inventory_id INT PRIMARY KEY,
    product_id INT UNIQUE NOT NULL,
    current_stock INT NOT NULL CHECK (current_stock >= 0),
    restock_date DATE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    order_id INT UNIQUE NOT NULL,
    status VARCHAR(10) NOT NULL CHECK (status IN ('success', 'fail')),
    transaction_date DATE DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT UNIQUE NOT NULL,
    payment_method VARCHAR(20) NOT NULL,
    payment_date DATE DEFAULT CURRENT_TIMESTAMP,
    amount_paid DECIMAL(10,2) NOT NULL CHECK (amount_paid >= 0),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);


-- insert data 

-- insert data 
INSERT INTO Users (user_id, name, email, password, role, address) VALUES
(1, 'Alice Johnson', 'alice@example.com', 'password123', 'buyer', '123 Main St'),
(2, 'Bob Smith', 'bob@example.com', 'securepass', 'seller', '456 Elm St'),
(3, 'Charlie Brown', 'charlie@example.com', 'passw0rd', 'buyer', '789 Pine St'),
(4, 'Diana Prince', 'diana@example.com', 'wonder123', 'seller', '101 Maple St'),
(5, 'Eve Adams', 'eve@example.com', 'evepassword', 'buyer', '22 Oak St'),
(6, 'Frank Green', 'frank@example.com', 'franklyme', 'buyer', '34 Birch Rd'),
(7, 'Grace Lee', 'grace@example.com', 'graceful123', 'seller', '7 Aspen Way'),
(8, 'Harry Potter', 'harry@example.com', 'magicpass', 'buyer', 'Privet Dr'),
(9, 'Irene Wright', 'irene@example.com', 'write123', 'seller', '99 Sycamore Ln'),
(10, 'Jack Black', 'jack@example.com', 'blackjack', 'buyer', '52 Pinewood St'),
(11, 'Kate Winslet', 'kate@example.com', 'titanicpass', 'buyer', 'Waterfront Dr'),
(12, 'Leo King', 'leo@example.com', 'kingleo', 'seller', '3 Oak Valley'),
(13, 'Mike Tyson', 'mike@example.com', 'boxer123', 'buyer', 'Iron Rd'),
(14, 'Nina Lopez', 'nina@example.com', 'ninapass', 'seller', '33 Broad Ave'),
(15, 'Oscar Wilde', 'oscar@example.com', 'literary', 'buyer', '44 Story Blvd'),
(16, 'Paula Green', 'paula@example.com', 'green123', 'seller', '5 Clover Ct'),
(17, 'Quentin Tarantino', 'quentin@example.com', 'filmpass', 'buyer', 'Cinema Dr'),
(18, 'Rachel McAdams', 'rachel@example.com', 'rachel123', 'seller', '6 Rose Ln'),
(19, 'Steve Jobs', 'steve@example.com', 'apple123', 'buyer', '1 Infinite Loop'),
(20, 'Tim Cook', 'tim@example.com', 'timpass', 'seller', 'Apple Blvd'),
(21, 'Uma Thurman', 'uma@example.com', 'killpass', 'buyer', '10 Beech St'),
(22, 'Victor Hugo', 'victor@example.com', 'lesmis123', 'buyer', 'Novel Rd'),
(23, 'Walter White', 'walter@example.com', 'heisenberg', 'seller', '66 Chemistry Ave'),
(24, 'Xander Cage', 'xander@example.com', 'actionman', 'buyer', '44 Mission Rd'),
(25, 'Yvonne Strahovski', 'yvonne@example.com', 'actor123', 'buyer', 'Celebrity Ln'),
(26, 'Zack Snyder', 'zack@example.com', 'justice123', 'seller', 'Director Dr'),
(27, 'Andy Garcia', 'andy@example.com', 'godfather', 'buyer', 'Cinema Ct'),
(28, 'Beyonce Knowles', 'beyonce@example.com', 'queenb', 'seller', 'Music Ln'),
(29, 'Chris Evans', 'chris@example.com', 'cap123', 'buyer', 'Marvel Blvd'),
(30, 'Daniel Craig', 'daniel@example.com', 'bond007', 'seller', 'Spy Ln');

INSERT INTO Buyers (buyer_id, user_id) VALUES
(1, 1), (2, 3), (3, 5), (4, 6), (5, 8), 
(6, 10), (7, 11), (8, 13), (9, 15), (10, 17), 
(11, 19), (12, 21), (13, 22), (14, 24), (15, 25), 
(16, 27), (17, 29), (18, 1), (19, 3), (20, 5), 
(21, 10), (22, 13), (23, 17), (24, 19), (25, 21), 
(26, 27), (27, 11), (28, 8), (29, 15), (30, 22);

INSERT INTO Sellers (seller_id, user_id, business_name) VALUES
(1, 2, 'Bob’s Electronics'), (2, 4, 'Diana’s Fashion'), 
(3, 7, 'Grace Couture'), (4, 9, 'Irene’s Creations'), 
(5, 12, 'Leo’s Gadgets'), (6, 14, 'Nina’s Apparel'), 
(7, 16, 'Paula’s Store'), (8, 18, 'Rachel’s Boutique'), 
(9, 20, 'Tim’s Emporium'), (10, 23, 'Walter’s Lab'), 
(11, 26, 'Zack’s Comics'), (12, 30, 'Daniel’s Gear'),
(13, 4, 'Fashion Hub'), (14, 7, 'Exclusive Style'), 
(15, 9, 'Home Essentials'), (16, 12, 'Tech World'), 
(17, 14, 'Apparel Kingdom'), (18, 16, 'Lifestyle Plaza'),
(19, 18, 'Clothing World'), (20, 20, 'Gadget Corner'), 
(21, 23, 'Science Store'), (22, 26, 'Collector’s Items'),
(23, 30, 'Spy Gear'), (24, 28, 'Music Hub'),
(25, 7, 'Designer Apparel'), (26, 16, 'Tech Plaza'),
(27, 30, 'Luxury Gear'), (28, 14, 'Fashion Paradise'),
(29, 4, 'Designer Fashion'), (30, 23, 'Unique Finds');

INSERT INTO Categories (category_id, category_name) VALUES
(1, 'Electronics'), (2, 'Fashion'), (3, 'Books'), (4, 'Home Appliances'), 
(5, 'Furniture'), (6, 'Sports'), (7, 'Toys'), (8, 'Groceries'), 
(9, 'Beauty'), (10, 'Music'), (11, 'Movies'), (12, 'Computers'), 
(13, 'Gadgets'), (14, 'Accessories'), (15, 'Software'), (16, 'Art'), 
(17, 'Outdoor'), (18, 'Stationery'), (19, 'Pet Supplies'), (20, 'Health'), 
(21, 'Tools'), (22, 'Automotive'), (23, 'Garden'), (24, 'Cameras'), 
(25, 'Shoes'), (26, 'Jewelry'), (27, 'Gaming'), (28, 'Watches'), 
(29, 'Mobile Phones'), (30, 'Smart Devices');

INSERT INTO Products (product_id, name, description, price, category_id, seller_id, availability_status, quantity_in_stock, product_image_url) VALUES
(1, 'Smartphone', 'Latest smartphone with 5G capabilities.', 699.99, 1, 2, 'active', 50, 'https://example.com/smartphone.jpg'),
(2, 'Running Shoes', 'Comfortable sports shoes for long runs.', 59.99, 25, 4, 'active', 100, 'https://example.com/running-shoes.jpg'),
(3, 'Bluetooth Speaker', 'Portable speaker with excellent sound.', 29.99, 13, 7, 'active', 75, 'https://example.com/speaker.jpg'),
(4, 'Coffee Maker', 'Brew your morning coffee with ease.', 89.99, 4, 9, 'inactive', 20, 'https://example.com/coffee-maker.jpg'),
(5, 'Yoga Mat', 'Non-slip yoga mat for fitness enthusiasts.', 24.99, 6, 14, 'active', 30, 'https://example.com/yoga-mat.jpg'),
(6, 'Electric Kettle', 'Quickly boil water with this kettle.', 49.99, 4, 12, 'active', 60, 'https://example.com/kettle.jpg'),
(7, 'Wireless Mouse', 'Ergonomic mouse for daily use.', 19.99, 12, 2, 'active', 120, 'https://example.com/mouse.jpg'),
(8, 'Backpack', 'Spacious and comfortable for travel.', 39.99, 14, 16, 'active', 40, 'https://example.com/backpack.jpg'),
(9, 'Smartwatch', 'Track fitness and notifications on the go.', 199.99, 30, 7, 'active', 30, 'https://example.com/smartwatch.jpg'),
(10, 'Gaming Console', 'Next-gen console for immersive gameplay.', 499.99, 27, 26, 'inactive', 10, 'https://example.com/console.jpg'),
(11, 'Electric Scooter', 'Eco-friendly mode of transport.', 299.99, 22, 23, 'active', 15, 'https://example.com/scooter.jpg'),
(12, 'Sunglasses', 'Stylish shades for sunny days.', 79.99, 14, 30, 'active', 90, 'https://example.com/sunglasses.jpg'),
(13, 'Smart TV', '4K UHD smart television.', 899.99, 1, 9, 'inactive', 8, 'https://example.com/smart-tv.jpg'),
(14, 'Headphones', 'Noise-cancelling over-ear headphones.', 129.99, 13, 20, 'active', 50, 'https://example.com/headphones.jpg'),
(15, 'Washing Machine', 'Efficient and quiet washing machine.', 699.99, 4, 12, 'inactive', 5, 'https://example.com/washing-machine.jpg'),
(16, 'Perfume', 'Fragrance for every occasion.', 59.99, 9, 28, 'active', 70, 'https://example.com/perfume.jpg'),
(17, 'E-book Reader', 'Read books on the go.', 149.99, 3, 26, 'active', 25, 'https://example.com/ebook-reader.jpg'),
(18, 'Dumbbell Set', 'Adjustable dumbbells for workouts.', 99.99, 6, 14, 'active', 40, 'https://example.com/dumbbells.jpg'),
(19, 'Laptop', 'Lightweight and powerful laptop.', 1299.99, 12, 20, 'inactive', 12, 'https://example.com/laptop.jpg'),
(20, 'Guitar', 'Acoustic guitar for beginners.', 199.99, 10, 16, 'active', 35, 'https://example.com/guitar.jpg'),
(21, 'Wristwatch', 'Analog wristwatch with leather strap.', 159.99, 28, 23, 'active', 45, 'https://example.com/wristwatch.jpg'),
(22, 'Home Theater', 'Surround sound system for your home.', 499.99, 11, 2, 'inactive', 6, 'https://example.com/home-theater.jpg'),
(23, 'Office Chair', 'Ergonomic chair for office comfort.', 149.99, 5, 30, 'active', 20, 'https://example.com/office-chair.jpg'),
(24, 'Water Bottle', 'Stainless steel water bottle.', 19.99, 8, 7, 'active', 80, 'https://example.com/water-bottle.jpg'),
(25, 'Kitchen Blender', 'Blend smoothies and soups.', 89.99, 4, 9, 'active', 55, 'https://example.com/blender.jpg'),
(26, 'Electric Drill', 'Powerful drill for DIY projects.', 129.99, 21, 23, 'active', 25, 'https://example.com/drill.jpg'),
(27, 'Action Camera', 'Capture adventures in 4K.', 299.99, 24, 12, 'inactive', 10, 'https://example.com/action-camera.jpg'),
(28, 'Bicycle', 'Mountain bike with 21 gears.', 499.99, 17, 16, 'active', 22, 'https://example.com/bicycle.jpg'),
(29, 'Board Game', 'Fun for family and friends.', 39.99, 7, 14, 'active', 100, 'https://example.com/board-game.jpg'),
(30, 'Tablet', 'Portable tablet for work and play.', 399.99, 12, 26, 'active', 30, 'https://example.com/tablet.jpg');

INSERT INTO Orders (order_id, buyer_id, order_status, shipped_date, delivered_date) VALUES
(1, 1, 'Processing', NULL, NULL),
(2, 2, 'Shipped', '2024-10-10', NULL),
(3, 3, 'Delivered', '2024-10-05', '2024-10-09'),
(4, 4, 'Processing', NULL, NULL),
(5, 5, 'Shipped', '2024-10-12', NULL),
(6, 6, 'Delivered', '2024-10-01', '2024-10-05'),
(7, 7, 'Processing', NULL, NULL),
(8, 8, 'Shipped', '2024-09-30', NULL),
(9, 9, 'Delivered', '2024-09-25', '2024-09-28'),
(10, 10, 'Processing', NULL, NULL),
(11, 11, 'Delivered', '2024-09-15', '2024-09-18'),
(12, 12, 'Processing', NULL, NULL),
(13, 13, 'Shipped', '2024-09-20', NULL),
(14, 14, 'Delivered', '2024-08-15', '2024-08-20'),
(15, 15, 'Processing', NULL, NULL),
(16, 16, 'Shipped', '2024-10-11', NULL),
(17, 17, 'Delivered', '2024-10-01', '2024-10-04'),
(18, 18, 'Processing', NULL, NULL),
(19, 19, 'Shipped', '2024-09-28', NULL),
(20, 20, 'Delivered', '2024-09-10', '2024-09-13'),
(21, 21, 'Processing', NULL, NULL),
(22, 22, 'Delivered', '2024-08-29', '2024-09-02'),
(23, 23, 'Processing', NULL, NULL),
(24, 24, 'Shipped', '2024-10-08', NULL),
(25, 25, 'Delivered', '2024-07-20', '2024-07-23'),
(26, 26, 'Processing', NULL, NULL),
(27, 27, 'Shipped', '2024-10-03', NULL),
(28, 28, 'Delivered', '2024-06-30', '2024-07-03'),
(29, 29, 'Processing', NULL, NULL),
(30, 30, 'Delivered', '2024-10-05', '2024-10-08');

INSERT INTO OrderDetails (order_id, product_id, quantity, price_at_time_of_order) VALUES
(1, 1, 2, 19.99),
(2, 3, 1, 49.99),
(3, 2, 3, 14.99),
(4, 4, 1, 99.99),
(5, 5, 2, 24.50),
(6, 7, 4, 9.99),
(7, 8, 1, 299.99),
(8, 6, 2, 39.00),
(9, 9, 5, 5.99),
(10, 2, 2, 14.99),
(11, 10, 1, 59.99),
(12, 3, 2, 49.99),
(13, 11, 3, 89.99),
(14, 1, 1, 19.99),
(15, 12, 4, 12.50),
(16, 8, 2, 299.99),
(17, 13, 3, 19.99),
(18, 7, 1, 9.99),
(19, 14, 2, 39.99),
(20, 10, 1, 59.99),
(21, 15, 3, 45.00),
(22, 16, 1, 120.99),
(23, 2, 2, 14.99),
(24, 9, 1, 5.99),
(25, 17, 5, 8.99),
(26, 6, 2, 39.00),
(27, 18, 3, 22.99),
(28, 5, 1, 24.50),
(29, 19, 2, 89.99),
(30, 20, 1, 149.99);

INSERT INTO Reviews (review_id, buyer_id, product_id, order_id, rating, review_text) VALUES
(1, 1, 1, 1, 5, 'Excellent product, highly recommend!'),
(2, 2, 3, 2, 4, 'Good quality, but shipping was slow.'),
(3, 3, 2, 3, 3, 'Decent for the price, but expected better.'),
(4, 4, 4, 4, 5, 'Outstanding performance! Worth every penny.'),
(5, 5, 5, 5, 4, 'Nice product, but packaging was damaged.'),
(6, 6, 7, 6, 2, 'Not satisfied, the product feels cheap.'),
(7, 7, 8, 7, 5, 'Amazing! Works perfectly.'),
(8, 8, 6, 8, 3, 'Okay, but not great.'),
(9, 9, 9, 9, 4, 'Good, but arrived a day late.'),
(10, 10, 2, 10, 5, 'Great value for the money.'),
(11, 11, 10, 11, 5, 'Highly satisfied with the purchase.'),
(12, 12, 3, 12, 4, 'Solid product. Will buy again.'),
(13, 13, 11, 13, 5, 'Exceeded expectations!'),
(14, 14, 1, 14, 3, 'Works fine, but not as advertised.'),
(15, 15, 12, 15, 2, 'Poor quality, would not recommend.'),
(16, 16, 8, 16, 5, 'Outstanding product. Very impressed.'),
(17, 17, 13, 17, 4, 'Good, but slightly overpriced.'),
(18, 18, 7, 18, 3, 'Not bad, but could be improved.'),
(19, 19, 14, 19, 4, 'Decent product for everyday use.'),
(20, 20, 10, 20, 5, 'Love it! Would purchase again.'),
(21, 21, 15, 21, 5, 'Excellent product and quick delivery.'),
(22, 22, 16, 22, 4, 'Great product, minor flaws.'),
(23, 23, 2, 23, 3, 'Mediocre, not worth the hype.'),
(24, 24, 9, 24, 4, 'Pretty good, overall satisfied.'),
(25, 25, 17, 25, 2, 'Disappointed, broke after a week.'),
(26, 26, 6, 26, 5, 'Perfect, just what I needed.'),
(27, 27, 18, 27, 3, 'Average quality, could be better.'),
(28, 28, 5, 28, 4, 'Good, but packaging was poor.'),
(29, 29, 19, 29, 5, 'Top-notch product, highly recommend.'),
(30, 30, 20, 30, 4, 'Very good, but a bit expensive.');

INSERT INTO InventoryManagement (inventory_id, product_id, current_stock, restock_date) VALUES
(1, 1, 60, '2024-10-10'),  -- Latest for product_id 1
(2, 2, 100, '2024-07-15'),
(3, 3, 85, '2024-10-01'),  -- Latest for product_id 3
(4, 4, 30, '2024-07-25'),
(5, 5, 40, '2024-10-05'),  -- Latest for product_id 5
(6, 6, 200, '2024-07-05'),
(7, 7, 140, '2024-09-25'),  -- Latest for product_id 7
(8, 8, 10, '2024-08-10'),
(9, 9, 480, '2024-10-07'),  -- Latest for product_id 9
(10, 10, 60, '2024-09-12'),
(11, 11, 65, '2024-10-12'),  -- Latest for product_id 11
(12, 12, 90, '2024-09-05'),
(13, 13, 50, '2024-10-03'),  -- Latest for product_id 13
(14, 14, 35, '2024-07-22'),
(15, 15, 110, '2024-10-09'),  -- Latest for product_id 15
(16, 16, 70, '2024-07-18'),
(17, 17, 90, '2024-10-14'),  -- Latest for product_id 17
(18, 18, 55, '2024-09-15'),
(19, 19, 20, '2024-10-08'),  -- Latest for product_id 19
(20, 20, 15, '2024-08-30'),
(21, 21, 45, '2024-09-22'),
(22, 22, 80, '2024-10-02'),
(23, 23, 300, '2024-09-10'),
(24, 24, 50, '2024-09-11'),
(25, 25, 200, '2024-09-19'),
(26, 26, 100, '2024-08-29'),
(27, 27, 85, '2024-09-21'),
(28, 28, 75, '2024-10-06'),
(29, 29, 40, '2024-07-31'),
(30, 30, 65, '2024-08-28');


INSERT INTO Transactions (transaction_id, order_id, status) VALUES
(1, 1, 'success'),
(2, 2, 'success'),
(3, 3, 'fail'),
(4, 4, 'success'),
(5, 5, 'success'),
(6, 6, 'fail'),
(7, 7, 'success'),
(8, 8, 'success'),
(9, 9, 'fail'),
(10, 10, 'success'),
(11, 11, 'success'),
(12, 12, 'success'),
(13, 13, 'fail'),
(14, 14, 'success'),
(15, 15, 'fail'),
(16, 16, 'success'),
(17, 17, 'success'),
(18, 18, 'success'),
(19, 19, 'fail'),
(20, 20, 'success'),
(21, 21, 'success'),
(22, 22, 'success'),
(23, 23, 'fail'),
(24, 24, 'success'),
(25, 25, 'success'),
(26, 26, 'success'),
(27, 27, 'success'),
(28, 28, 'fail'),
(29, 29, 'success'),
(30, 30, 'success');

INSERT INTO Payments (payment_id, order_id, payment_method, amount_paid) VALUES
(1, 1, 'credit_card', 150.00),
(2, 2, 'paypal', 200.50),
(3, 3, 'debit_card', 99.99),
(4, 4, 'credit_card', 120.00),
(5, 5, 'paypal', 180.25),
(6, 6, 'cash', 50.00),
(7, 7, 'credit_card', 250.75),
(8, 8, 'paypal', 90.00),
(9, 9, 'debit_card', 300.00),
(10, 10, 'cash', 75.50),
(11, 11, 'credit_card', 220.00),
(12, 12, 'paypal', 180.00),
(13, 13, 'debit_card', 105.00),
(14, 14, 'cash', 45.75),
(15, 15, 'credit_card', 140.00),
(16, 16, 'paypal', 200.00),
(17, 17, 'debit_card', 60.99),
(18, 18, 'cash', 100.00),
(19, 19, 'credit_card', 275.00),
(20, 20, 'paypal', 155.50),
(21, 21, 'debit_card', 190.00),
(22, 22, 'cash', 85.00),
(23, 23, 'credit_card', 205.75),
(24, 24, 'paypal', 135.99),
(25, 25, 'debit_card', 95.00),
(26, 26, 'cash', 150.50),
(27, 27, 'credit_card', 170.00),
(28, 28, 'paypal', 240.00),
(29, 29, 'debit_card', 110.25),
(30, 30, 'cash', 130.50);




-- write queries

-- total sales amount across all orders 
SELECT SUM(amount_paid) AS total_sales FROM Payments; 

-- find total number of buyers 
SELECT COUNT(*) AS total_buyers from BUYERS; 

-- find the average rating for each product 
SELECT product_id, AVG(rating) AS average_rating
FROM Reviews
GROUP BY product_id; 

-- list all orders with buyer names and order statuses: join query
SELECT
    Orders.order_id,
    Users.name AS buyer_name,
    Orders.order_status
    --Orders.order_date
FROM Orders
JOIN Buyers ON Orders.buyer_id = Buyers.buyer_id
JOIN Users ON Buyers.user_id = Users.user_id;

-- list all products and their category names and seller business names: join query
SELECT
    Products.product_id,
    Products.name AS product_name,
    Categories.category_name,
    Sellers.business_name
FROM Products
JOIN Categories ON Products.category_id = Categories.category_id
JOIN Sellers ON Products.seller_id = Sellers.seller_id;


--find products that have sold more than 50 units: subquery
SELECT 
    Products.name, 
    total_sold.total_quantity AS total_sold
FROM 
    Products
JOIN (
    SELECT 
        product_id, 
        SUM(quantity) AS total_quantity
    FROM 
        OrderDetails
    GROUP BY 
        product_id
) AS total_sold ON Products.product_id = total_sold.product_id
WHERE 
    total_sold.total_quantity > 2;


-- list buyers who have spent more than the average amount spent by all buyers
SELECT Users.name, TotalSpent.total_amount
FROM Buyers
JOIN Users ON Buyers.user_id = Users.user_id
JOIN (
    SELECT buyer_id, SUM(amount_paid) AS total_amount
    FROM Orders
    JOIN Payments ON Orders.order_id = Payments.order_id
    GROUP BY buyer_id
) AS TotalSpent ON Buyers.buyer_id = TotalSpent.buyer_id
WHERE TotalSpent.total_amount > (
    SELECT AVG(total_amount) FROM (
        SELECT buyer_id, SUM(amount_paid) AS total_amount
        FROM Orders
        JOIN Payments ON Orders.order_id = Payments.order_id
        GROUP BY buyer_id
    ) AS BuyerTotals
);


-- find the product with the highest price
SELECT name, price
FROM Products
WHERE price = (SELECT MAX(price) FROM Products);


-- find the least expensive product in 'electronics' category (sample section) **make sure to add this section in table
SELECT Products.name, Products.price
FROM Products
JOIN Categories ON Products.category_id = Categories.category_id
WHERE Categories.category_name = 'Electronics' AND Products.price = (
    SELECT MIN(Products.price)
    FROM Products
    JOIN Categories ON Products.category_id = Categories.category_id
    WHERE Categories.category_name = 'Electronics'
);

--list the sellers who have more than 5 products listed, 
SELECT Sellers.business_name, COUNT(Products.product_id) AS product_count
FROM Sellers
JOIN Products ON Sellers.seller_id = Products.seller_id
GROUP BY Sellers.seller_id, Sellers.business_name
HAVING COUNT(Products.product_id) > 2; 