SELECT * FROM brands;
SELECT * FROM categories;
SELECT * FROM customers;
SELECT * FROM order_details;
SELECT * FROM payments;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM suppliers;

SELECT products.name, categories.name as category_name, SUM(order_details.total_price)
     FROM order_details
	 JOIN products ON products.id = order_details.product_id
	 JOIN categories ON categories.id = products.id
	 GROUP BY products.name, category_name
	 ORDER BY SUM(order_details.total_price) DESC
	 LIMIT 3

SELECT brands.name as brand_name, categories.name as category_name, suppliers.name as supplier_name, SUM(order_details.total_price)
	 FROM order_details
	 JOIN products ON products.id = order_details.product_id
	 JOIN categories ON categories.id = products.category_id
	 JOIN brands ON brands.id = products.brand_id
	 JOIN suppliers ON suppliers.id = products.supplier_id
	 GROUP BY brand_name, category_name,supplier_name
	 ORDER BY SUM(order_details.total_price) DESC
	 LIMIT 5;

	 CASE 
	    when condition is true then 'result'
		  else 'give a name'
		   end 'new column name'


SELECT 
    COUNT(*),
	COUNT(
		CASE 
	   WHEN status IN ('Delivered') then 'DONE'
	   END) fulfilled_orders,
	  ROUND(COUNT(CASE 
	  WHEN status IN ('Delivered') then 'DONE'
	   END)*100.0/ count(*),2)
	   FROM orders

----------------QUESTION 1

-----FULFILLED ORDERS BY MONTH AND CATEGORIES
SELECT 
     EXTRACT(month from orders.order_date) as month, categories.name as categories,
	 COUNT(
		CASE 
	   WHEN status IN ('Delivered') then 1
	   END) fulfilled_orders
	   FROM orders
	   JOIN order_details ON orders.id = order_details.order_id
	   JOIN products ON products.id = order_details.product_id
       JOIN categories ON categories.id = products.category_id
	   GROUP BY month, categories.name
       ORDER BY month;

----THE FULFILMENT RATE BY MONTH AND CATEGORIES
	  SELECT 
     EXTRACT(month from orders.order_date) as month, categories.name as categories,
	 COUNT(
		CASE 
	   WHEN status IN ('Delivered') then 1
	   END) fulfilled_orders,
	   ROUND(COUNT(
		CASE 
	   WHEN status IN ('Delivered') then 1
	   END)*100.0/ COUNT(*)) AS fulfilment_rate
	   FROM orders
	   JOIN order_details ON orders.id = order_details.order_id
	   JOIN products ON products.id = order_details.product_id
       JOIN categories ON categories.id = products.category_id
	   GROUP BY month, categories.name
       ORDER BY month;

-----------------------QUESTION 2
-----YEARLY AND MONTHLY ORDERS FULFILMENT BY CATEGORY AND SUPPLIER'S
SELECT 
    EXTRACT(year from orders.order_date) AS YEAR,
    EXTRACT(month from orders.order_date) AS MONTH, categories.name AS category_name, suppliers.name AS supplier_name,contact_email,
	COUNT(
       CASE
	     WHEN status in ('Delivered') then 1
	   end) fulfilled_orders
	FROM orders
	  JOIN order_details ON orders.id = order_details.order_id
	  JOIN products ON products.id = order_details.product_id
	  JOIN categories ON categories.id = products.category_id
	  JOIN suppliers ON suppliers.id = products.supplier_id
	  GROUP BY Year,month,category_name,supplier_name,contact_email

-----TREND ANALYSIS OF YEARLY AND MONTHLY ORDER FULFILMENT BY CATEGORIES AND SUPPLIERS
SELECT 
    EXTRACT(year from orders.order_date) AS YEAR,
    EXTRACT(month from orders.order_date) AS MONTH, categories.name AS category_name, suppliers.name AS supplier_name,contact_email,
	ROUND (COUNT(
       CASE
	     WHEN status in ('Delivered') then 1
	   end)*100.0/ COUNT(*))trend_analysis
	FROM orders
	  JOIN order_details ON orders.id = order_details.order_id
	  JOIN products ON products.id = order_details.product_id
	  JOIN categories ON categories.id = products.category_id
	  JOIN suppliers ON suppliers.id = products.supplier_id
	  GROUP BY Year,month,category_name,supplier_name,contact_email	
	  ORDER BY month

---QUESTION 3
-----REPEATED CUSTOMERS
SELECT customers.id, CONCAT(first_name,' ',last_name) AS full_name, amount, COUNT (customers.id) AS Repeated_customers
   FROM payments
   JOIN orders ON orders.id = payments.order_id
   JOIN customers ON customers.id = orders.customer_id
   GROUP BY customers.id,full_name,amount
   HAVING COUNT (customers.id)  > 1
   
----TOP SPENDERS
SELECT customers.id, CONCAT(first_name,' ',last_name) AS full_name, amount, COUNT (customers.id) AS Repeated_customers
   FROM payments
   JOIN orders ON orders.id = payments.order_id
   JOIN customers ON customers.id = orders.customer_id
   GROUP BY customers.id,full_name,amount
   ORDER BY amount DESC
   LIMIT 10

   
	   
