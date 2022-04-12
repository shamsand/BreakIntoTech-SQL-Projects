#In this SQL, I'm querying a database with multiple tables in it to quantify statistics about customer and order data. 

#1. How many orders were placed in January? 
SELECT COUNT(orderid)
FROM BIT_DB.JanSales

#2. How many of those orders were for an iPhone? 
SELECT COUNT(orderid)
FROM BIT_DB.JanSales
WHERE Product='iPhone'

#3. Select the customer account numbers for all the orders that were placed in February. 
SELECT acctnum
FROM BIT_DB.customers cust

INNER JOIN BIT_DB.FebSales Feb
ON cust.order_id=FEB.orderid

#4. Which product was the cheapest one sold in January, and what was the price? 
SELECT distinct Product, price
FROM BIT_DB.JanSales
WHERE  price in (SELECT min(price) FROM BIT_DB.JanSales)
#OR 
SELECT distinct product, price FROM BIT_DB.JanSales 
ORDER BY price ASC LIMIT 1

#5. What is the total revenue for each product sold in January?
SELECT sum(quantity)*price as revenue
,product
FROM BIT_DB.JanSales
GROUP BY product

#6. Which products were sold in February at 548 Lincoln St, Seattle, WA 98101, how many of each were sold, and what was the total revenue?
select 
sum(Quantity), 
product, 
sum(quantity)*price as revenue
FROM BIT_DB.FebSales 
WHERE location = '548 Lincoln St, Seattle, WA 98101'
GROUP BY product

#7. How many customers ordered more than 2 products at a time, and what was the average amount spent for those customers? 
select 
count(cust.acctnum), 
avg(quantity)*price
FROM BIT_DB.FebSales Feb
LEFT JOIN BIT_DB.customers cust
ON FEB.orderid=cust.order_id
WHERE Feb.Quantity>2

##1. 
SELECT orderdate
FROM BIT_DB.FebSales
WHERE orderdate between '02/13/19 00:00' AND '02/18/19 00:00'

##2. 
SELECT location
FROM BIT_DB.FebSales 
WHERE orderdate = '02/18/19 01:35'

##3. 
SELECT sum(quantity)
FROM BIT_DB.FebSales 
WHERE orderdate like '02/18/19%'

##1. 
SELECT distinct Product
FROM BIT_DB.FebSales
WHERE Product like '%Batteries%'

##2. 
SELECT distinct Product, Price
FROM BIT_DB.FebSales 
WHERE Price like '%.99'

##3.
SELECT Product, SUM(quantity)
FROM BIT_DB.FebSales 
WHERE location like '%Los Angeles%'
GROUP BY Product

#1. How many locations are there in NY that sold more than 1 product in January? 
SELECT count(distinct location)
FROM BIT_DB.JanSales 
WHERE location like '%NY%'
AND quantity>1

#2. How many of each type of headphone was sold in February?
SELECT sum(Quantity) as quantity,
Product
FROM BIT_DB.FebSales 
WHERE Product like '%Headphones%'
GROUP BY Product

#3. What was the average amount spent per account in February?
SELECT avg(quantity*price)
FROM BIT_DB.FebSales Feb

LEFT JOIN BIT_DB.customers cust
ON FEB.orderid=cust.order_id

#4. What was the average quantity of products purchased per account in February? 
select sum(quantity)/count(cust.acctnum)
FROM BIT_DB.FebSales Feb

LEFT JOIN BIT_DB.customers cust
ON FEB.orderid=cust.order_id

#5. Which product brought in the most revenue in January and how much revenue did it bring in total? 
SELECT product, 
sum(quantity*price)
FROM BIT_DB.JanSales 
GROUP BY product
ORDER BY sum(quantity*price) desc 
LIMIT 1







