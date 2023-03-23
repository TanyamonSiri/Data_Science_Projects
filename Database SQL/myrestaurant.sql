--As restaurant owner
--Create at least 5 tables
--Write SQL 3-5 queries for analysis
--1 WITH clause, 1 subquery, 1 AGG function

.open restaurant.db

DROP TABLE dimMenus;
DROP TABLE dimCustomers;
DROP TABLE dimMemberships;
DROP TABLE invoices;
DROP TABLE dimOrder_detail;
DROP TABLE dimStaff_info;

.mode box
.header on
  
--Table 1: dimMenus
CREATE TABLE IF NOT EXISTS dimMenus (
menu_id int NOT NULL ,
name text NOT NULL,
unit_price real NOT NULL,
category text NOT NULL,  
PRIMARY KEY (menu_id)
);

INSERT INTO dimMenus 
  VALUES ( 1, 'Garlic Bread with Bacon', 100,'Snack'),
         ( 2, 'Tomato Soup', 80, 'Food'),
         ( 3, 'Salad', 100,'Food'),
         ( 4, 'Hamburg Steak', 200,'Food'),
         ( 5, 'Pork Chop Steak',300,'Food'),
         (6, 'Chicken Wings', 100,'Snack'),
         (7, 'American Fried Rice', 120,'Food'),
         (8, 'Spaghetti Cabonara with Bacon', 155,'Food'),
         (9, 'Lime Soda', 90,'Beverage'),
         (10, 'Honey Lime Soda', 95,'Beverage'),
         (11, 'Strawberry Smoothie', 95,'Beverage'),
         (12, 'Mango Smoothie', 95,'Beverage'),
         (13, 'Mineral Water', 15,'Beverage'),
         (14, 'Coke', 25,'Beverage'),
         (15, 'Coke Zero', 25,'Beverage')  ;

--SELECT * FROM dimMenus;

--Table2: dimCustomers
CREATE TABLE IF NOT EXISTS dimCustomers (
customer_id int NOT NULL ,
name text NOT NULL,
phone_num int ,
birthday date,
member_id int,
PRIMARY KEY (customer_id)
);

INSERT INTO dimCustomers 
  VALUES ( 1, 'John', 0830778664,'1989-04-13',4),
         ( 2, 'Chris',0894524824,'2003-03-27',1),
         ( 3, 'Lime', 0908644258,'1998-12-04',2),
         ( 4, 'Bella',0819568752,'1998-10-09',1),
         ( 5, 'Jenny',0827281161,'1994-07-19',2),
         ( 6, 'Luis', 0871326760,'2003-03-16',4),
         ( 7, 'Johnie', 0861390093,'1985-10-23',3),
         ( 8, 'Beckie', 0822211775,'1989-05-28',1),
         ( 9, 'Nicki', 0822496454,'1992-01-28',3),
         ( 10, 'Kristine', 0825173997,'2001-02-20',3)
  ;
 --SELECT * FROM dimCustomers;


--Table3: dimMemberships
CREATE TABLE IF NOT EXISTS dimMemberships (
  member_id int NOT NULL,
  membership_level text,
  special_discount real,
  PRIMARY KEY (member_id)
);

INSERT INTO dimMemberships
  VALUES (1, 'Platinum', 0.10),
         (2, 'Gold', 0.08 ),
         (3, 'Silver', 0.05),
         (4, 'Member',0);
         
--SELECT * FROM dimMemberships;


--Table 4: invoices 
CREATE TABLE IF NOT EXISTS invoices (
  invoice_id int UNIQUE,
  order_id int,
  customer_id int,
  cashier_id int,
  PRIMARY KEY (invoice_id)
);



INSERT into invoices 
  VALUES (230001,1,4,2),
         (230002,2,1,2),
         (230003,3,5,6),
         (230004,4,2,6),
         (230005,5,3,6),
         (230006,7,6,3),
         (230007,6,10,2),
         (230008,8,9,6),
         (230009,9,7,3),
         (230010,10,8,2);

--SELECT * FROM invoices; 


--Table 5: dimOrder_detail 
CREATE TABLE IF NOT EXISTS dimOrder_detail (
  order_id int,
  order_date date,
  menu_id int NOT NULL,
  quantity int NOT NULL
);
INSERT INTO dimOrder_detail 
  VALUES (1,'2023-01-05',7,2),
         (1,'2023-01-05',10,1),
         (2,'2023-01-05',2,1),
         (3,'2023-01-06',8,1),
         (3,'2023-01-06',6,1),
         (3,'2023-01-06',15,1),
         (4,'2023-01-12',5,1),
         (4,'2023-01-12',13,1),
         (5,'2023-01-20',11,1),
         (5,'2023-01-20',5,1),
         (6,'2023-02-01',7,1),
         (7,'2023-02-01',8,1),
         (7,'2023-02-02',12,1),
         (8,'2023-02-03',3,1),
         (9,'2023-01-03',1,2),
         (10,'2023-01-04',6,1),
         (10,'2023-01-04',8,1);

--SELECT * FROM dimOrder_detail;   


--Table 6: dimStaff_info 
CREATE TABLE IF NOT EXISTS dimStaff_info (
  staff_id int,
  staff_name text,
  staff_gender text,
  staff_position text,
  staff_active boolean
);

INSERT INTO dimStaff_info 
  VALUES (1, 'Jenny', 'Female', 'Cashier', 0),
  (2, 'Lisa', 'Female', 'Cashier', 1),
  (3, 'Mark', 'Male', 'Manager', 1),
  (4, 'Selena', 'Female', 'Chef', 1),
  (5, 'James', 'Male', 'Waiter', 1),
  (6, 'Ronald', 'Male', 'Cashier', 1),
  (7, 'Patricia', 'Female', 'Waitress', 1);
--SELECT * FROM dimStaff_info;

-- Query1: Total revenue by food category
-- Using WITH Clause and Sub-query
WITH invoice_detail AS (
  SELECT 
  inv.invoice_id AS invoice_number,
  cust.customer_id AS customer_id,
  cust.name AS customer_name,
  memb.membership_level AS customer_tier,
  men.name AS food_name,
  men.category AS category,
  ord.quantity AS quantity,
  men.unit_price AS price,
  memb.special_discount AS tier_benefit,
  men.unit_price * ord.quantity AS Gross_sales,
  men.unit_price * ord.quantity * (1-memb.special_discount) AS Net_sales
  FROM dimOrder_detail AS ord
  JOIN dimMenus AS men ON ord.menu_id = men.menu_id
  JOIN invoices AS inv ON ord.order_id = inv.order_id 
  JOIN dimCustomers AS cust ON inv.customer_id = cust.customer_id
  JOIN dimMemberships AS memb ON cust.member_id = memb.member_id
)

/*SELECT customer_id,customer_name,customer_tier, tier_benefit, Gross_sales, Net_sales FROM invoice_detail;
*/

SELECT category, food_name, quantity, revenue_by_items FROM (
  SELECT 
    category,
    food_name,
    SUM(quantity) AS quantity,
    SUM(Net_sales) AS revenue_by_items,
    ROW_NUMBER() OVER(PARTITION BY category ORDER BY SUM(Net_sales) DESC) AS segment
FROM invoice_detail

GROUP BY category,food_name
) 
;

-- Query2: Total revenue by membership
 SELECT 
   customer_tier,
   COUNT(segment2) AS tier_count,
   SUM(sales) AS revenue_by_segment
   FROM (
    SELECT 
          customer_tier,
          customer_name,
          SUM(Gross_sales),
          SUM(Net_sales) AS sales,
          ROW_NUMBER() OVER(PARTITION BY customer_tier ORDER BY Net_sales DESC) AS segment2
       FROM (
        SELECT 
        inv.invoice_id AS invoice_number,
        cust.customer_id AS customer_id,
        cust.name AS customer_name,
        memb.membership_level AS customer_tier,
        men.name AS food_name,
        men.category AS category,
        ord.quantity AS quantity,
        men.unit_price AS price,
        memb.special_discount AS tier_benefit,
        men.unit_price * ord.quantity AS Gross_sales,
        men.unit_price * ord.quantity * (1-memb.special_discount) AS Net_sales
        FROM dimOrder_detail AS ord
        JOIN dimMenus AS men ON ord.menu_id = men.menu_id
        JOIN invoices AS inv ON ord.order_id = inv.order_id 
        JOIN dimCustomers AS cust ON inv.customer_id = cust.customer_id
        JOIN dimMemberships AS memb ON cust.member_id = memb.member_id
        
      )GROUP BY customer_tier,customer_name
)
   
GROUP BY customer_tier
ORDER BY revenue_by_segment DESC
;
--Query 3: Who is the top spender in our restaurant?. I want to see list of customers ranking based on theirs spending along with his/her name and membership tier

-- using WITH clause 'invoice_detail'
-- using Window Function for ranking number


WITH invoice_detail AS (
  SELECT 
  inv.invoice_id AS invoice_number,
  cust.customer_id AS customer_id,
  cust.name AS customer_name,
  memb.membership_level AS customer_tier,
  men.name AS food_name,
  men.category AS category,
  ord.quantity AS quantity,
  men.unit_price AS price,
  memb.special_discount AS tier_benefit,
  men.unit_price * ord.quantity AS Gross_sales,
  men.unit_price * ord.quantity * (1-memb.special_discount) AS Net_sales
  FROM dimOrder_detail AS ord
  JOIN dimMenus AS men ON ord.menu_id = men.menu_id
  JOIN invoices AS inv ON ord.order_id = inv.order_id 
  JOIN dimCustomers AS cust ON inv.customer_id = cust.customer_id
  JOIN dimMemberships AS memb ON cust.member_id = memb.member_id)

SELECT 
  ROW_NUMBER() OVER(ORDER BY SUM(Net_sales) DESC) AS Rank, 
  customer_name,
  customer_id AS id,
  customer_tier AS membership_tier,
  SUM(Net_sales) AS revenue_by_customer
          
FROM invoice_detail
GROUP BY customer_name
ORDER BY revenue_by_customer DESC ,customer_id ;







