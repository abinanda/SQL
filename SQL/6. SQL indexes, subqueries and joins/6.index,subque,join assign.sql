-- Sub-Queries
/* 1.	Get data with all columns of the sales table, and customer name, customer age, product name, and category are in the same result set. (Use join in the subquery, refer to the database and tables from Assignments-05) */
use supermart_db;
select s.*,c.customer_name,c.age,p.product_name,p.category from sales s inner join customer c on c.customer_id=s.customer_id inner join product p on p.product_id=s.product_id;
/* 2.	Get data from the sales table, product name, and category in the result set.*/
select s.*,p.product_name,p.category from sales s inner join product p on p.product_id=s.product_id;
/* 3.	Without using the join concept create a sub-query by using the customer, product, and sales data.*/
select s.*,(select customer_name from customer c where c.customer_id=s.customer_id)as name,(select product_name from product p where p.product_id = s.product_id)as p_name  from sales s ;

-- Functions: -
-- string functions: -
-- 1.	Find the maximum length of characters in the Product name string from the Product table.
select product_name,length(product_name) from product having length(product_name)= (select max(length(product_name)) from product);

WITH MaxProductLength AS (
    SELECT MAX(LENGTH(product_name)) AS max_length
    FROM product
)
SELECT product_name, LENGTH(product_name)
FROM product
CROSS JOIN MaxProductLength
WHERE LENGTH(product_name) = max_length;

/* 2.	Retrieve product name, sub-category, and category from the Product table and an additional column named “product_details” which contains a concatenated string of product name, sub-category, and category. */
SELECT 
    product_name,
    sub_category,
    category,
    CONCAT(product_name, ',', sub_category) AS product_details
FROM
    product;

/* 3.	Analyze the product_id column and take out the three parts composing the product_id in three different columns.*/
SELECT
    product_id,
    SUBSTRING_INDEX(product_id, '-', 1) AS first_part,
    SUBSTRING_INDEX(SUBSTRING_INDEX(product_id, '-', -2), '-', 1) AS second_part,
    SUBSTRING_INDEX(product_id, '-', -1) AS third_part
FROM
    product;
 /* 4.	List down comma-separated product names where the sub-category is either Chairs or tables. */
 select group_concat(product_name) from product where sub_category in ('Chairs','Tables');
 
 -- Mathematical functions: -
 /* 1.	You are running a lottery for your customers. So, pick a list of 5 lucky customers from the customer table using a random function. */
 select customer_name from customer order by rand() limit 5;
 
 /* 2.	Suppose you cannot charge the customer in fraction points. So, for a sales value of 1.63, you will get either 1 (or) 2. In such a scenario, find out.
a.	Total sales revenue if you are charging the lower integer value of sales always.
b.	Total sales revenue if you are charging the higher integer value of sales always.
c.	Total sales revenue if you are rounding off the sales always.
*/
select sum(floor(sales)) from sales;
select sum(ceil(sales)) from sales;
select sum(sales) from sales;
 
 -- Date & Time functions: -
 /* 1.	Find out the current age of “batman” who was born on “April 6, 1939” in Years, months, and days.*/
select timestampdiff(year,'1939-04-06',curdate()) as year,timestampdiff(month,'1939-04-06',curdate())% 12 as month,floor(To_days(curdate())-to_days('1939-04-06'))% 30.43 as days;

/* 2.	Analyze and find out the monthly sales of the sub-category ‘chair’. Do you Observe any seasonality in sales of this sub-category.*/
select p.sub_category,date_format(s.Order_date,'%Y-%m')as y_month,sum(sales) as monthly_sales from sales s join product p on s.product_id=p.product_id where p.sub_category = 'chairs' group by p.sub_category, y_month order by y_month asc;
-- yes i find seasionality in this data early months are of lower sales and end of year show highest sales...in between months show fluctuations

-- Joins: - 
/* 1.	Run the below query to create the datasets.
a.	Creating sales table for the year 2015
•	Create table sales_2015 as select * from sales where ship_date between '2015-01-01' and '2015-12-31';
•	select count(*) from sales_2015; 
•	select count(distinct customer_id) from sales_2015;*/
create table sales_2015 (select * from sales where ship_date between '2015-01-01' and '2015-12-31');
select count(*) from sales_2015;
select count(distinct customer_id) from sales_2015;

/*b.	Customers with ages between 20 and 60 
•	create table customer_20_60 as select * from customer where age between 20 and 60;
•	select count (*) from customer_20_60;*/
create table customer_20_60 (select * from customer where age between 20 and 60);
select count(*) from customer_20_60;
/*2.	Find the total sales that are done in every state for customer_20_60 and sales_2015 table
Hint: Use Joins and Group By command
*/
select c.state,sum(sales) as sum_sales from sales_2015 s inner join customer_20_60 c on c.customer_id=s.customer_id group by c.state order by sum_sales;

/* 3.	Get data containing Product_id, Product name, category, total sales value of that product, and total quantity sold. (Use sales and product tables)*/

select p.product_id,p.product_name,p.category,sum(sales) as sum_sales,sum(quantity) as sum_quan from sales s inner join product p on p.product_id=s.product_id group by p.category,p.product_name,p.product_id order by sum_sales,sum_quan;



