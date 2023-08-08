use dataanalytics_db;
select * from employees limit 10;
select e.* ,max(salary) over() as max_sal from employees e;
select e.*,max(salary) over(partition by department_id) as max_sal from employees e;

-- ROW NUMBER
select e.* ,row_number() over() as rn from employees e;
select e.* ,row_number() over(partition by department_id) as rn from employees e ;
-- find the first 2 employees from each dept to join the company
select e.*,row_number() over(partition by department_id order by department_id, employee_id) as rn from employees e;
select * from(select e.*,row_number() over(partition by department_id order by department_id, employee_id) as rn from employees e)x where x.rn<3;

-- RANK    - will skip a rank if finds duplicate record
select e.* from employees;
-- find top 3 employees who earn the most in each dept  
select * from(select e.*, rank() over(partition by department_id order by salary desc) as rnk from employees e)x where x.rnk<4;

-- DENSE RANk   - it wont skip a rank if it find suplicate record
select e.*, rank() over(partition by department_id order by salary desc) as rnk, dense_rank() over(partition by department_id order by salary desc) as dense_rnk from employees e;
select * from(select e.*, dense_rank() over(partition by department_id order by salary desc) as dense_rnk from employees e)x where x.dense_rnk<4;

-- diff rownum,rank,denserank
select e.*,row_number() over(partition by department_id) as rn, rank() over(partition by department_id order by salary desc) as rnk, dense_rank() over(partition by department_id order by salary desc) as dense_rnk from employees e;

-- LAG     - eg. correlation between datapoint and previous datapoint
-- eg: we want to check if salary of current employee is higher or lower than or equal to previous employee
-- lag(col_name)
select e.* ,lag(salary) over(partition by department_id order by employee_id) as prev_emp_sal from employees e;
-- lag(col_name,no.of records to look prior,replacement value with null)
select e.* ,lag(salary,2,0) over(partition by department_id order by employee_id) as prev_emp_sal from employees e;

-- LEAD
 -- same as lag but it deals with next record rather than previous record
 select e.* ,lag(salary) over(partition by department_id order by employee_id) as prev_emp_sal,lead(salary) over(partition by department_id order by employee_id) as next_emp_sal from employees e;
select e.* ,lag(salary,2,0) over(partition by department_id order by employee_id) as prev_emp_sal,lead(salary,2,0) over(partition by department_id order by employee_id) as next_emp_sal from employees e;

-- fetch a query to display if salary of current employee is higher or lower than or equal to previous employee
select e.* ,lag(salary) over(partition by department_id order by employee_id) as prev_emp_sal,case when e.salary>lag(salary) over(partition by department_id order by employee_id) then 'Higher' when e.salary<lag(salary) over(partition by department_id order by employee_id) then 'Lower' when e.salary=lag(salary) over(partition by department_id order by employee_id) then 'equal' end sal_range from employees e;



-- create product table
use dataanalytics_db;
CREATE TABLE product
( 
    product_category varchar(255),
    brand varchar(255),
    product_name varchar(255),
    price int
);

INSERT INTO product VALUES
('Phone', 'Apple', 'iPhone 12 Pro Max', 1300),
('Phone', 'Apple', 'iPhone 12 Pro', 1100),
('Phone', 'Apple', 'iPhone 12', 1000),
('Phone', 'Samsung', 'Galaxy Z Fold 3', 1800),
('Phone', 'Samsung', 'Galaxy Z Flip 3', 1000),
('Phone', 'Samsung', 'Galaxy Note 20', 1200),
('Phone', 'Samsung', 'Galaxy S21', 1000),
('Phone', 'OnePlus', 'OnePlus Nord', 300),
('Phone', 'OnePlus', 'OnePlus 9', 800),
('Phone', 'Google', 'Pixel 5', 600),
('Laptop', 'Apple', 'MacBook Pro 13', 2000),
('Laptop', 'Apple', 'MacBook Air', 1200),
('Laptop', 'Microsoft', 'Surface Laptop 4', 2100),
('Laptop', 'Dell', 'XPS 13', 2000),
('Laptop', 'Dell', 'XPS 15', 2300),
('Laptop', 'Dell', 'XPS 17', 2500),
('Earphone', 'Apple', 'AirPods Pro', 280),
('Earphone', 'Samsung', 'Galaxy Buds Pro', 220),
('Earphone', 'Samsung', 'Galaxy Buds Live', 170),
('Earphone', 'Sony', 'WF-1000XM4', 250),
('Headphone', 'Sony', 'WH-1000XM4', 400),
('Headphone', 'Apple', 'AirPods Max', 550),
('Headphone', 'Microsoft', 'Surface Headphones 2', 250),
('Smartwatch', 'Apple', 'Apple Watch Series 6', 1000),
('Smartwatch', 'Apple', 'Apple Watch SE', 400),
('Smartwatch', 'Samsung', 'Galaxy Watch 4', 600),
('Smartwatch', 'OnePlus', 'OnePlus Watch', 220);
COMMIT;




-- All the SQL Queries written during the video

select * from product;

-- FIRST VALUE
-- write a query to display the  most expensive product in each category (corresponding to each record)
select * , first_value(product_name) over(partition by product_category order by price desc) as most_exp_prodcut from product;

-- LAST values
-- write a query to display the  least expensive product in each category (corresponding to each record)
select *, last_value(product_name) over(partition by product_category order by price desc) as least_exp_product from product;
-- its not correct becoz of the default frame clause sql is using
-- frame is a subset of partition, the functions wont process all the records in partition at once,,but use all the records in the frame
-- give frame caluse after order by in over()
/* the default FRAME CLAUSE that is used in sql is -- (range between unbounded preceding and current row) */
-- preceding --is rows preceding to current row
-- unbounded is from the very first row to current row -- so,this makes the first row to consider first row itself as there is no rows preceding
-- so modify the frame to give access to all the records of the partition to the window functions
-- range between unbounded preceding and unbounded following
select *,last_value(product_name)over(partition by product_category order by price desc range between unbounded preceding and unbounded following) as least_exp_product from product;

-- row and range diff
select *,last_value(product_name)over(partition by product_category order by price desc range between unbounded preceding and current row) as least_exp_product from product where product_category = 'phone';
select *,last_value(product_name)over(partition by product_category order by price desc rows between unbounded preceding and current row) as least_exp_product from product where product_category = 'phone';
-- when we have duplicate values range will consider last row with that dup value, but rows will consider the exact current row
-- we can mention values also instead of unbounded
select *,last_value(product_name)over(partition by product_category order by price desc range between 2 preceding and 2 following) as least_exp_product from product where product_category = 'phone';

-- ALTERnaTE way TO WRITE Sql QUERY using WINDOW FUNCTIONS
-- we can use window clause in last before order by to avoid mentioning in every over clause
select *,first_value(product_name) over w as most_exp_prod,last_value(product_name)over w as least_exp_product from product window w as (partition by product_category order by price desc range between unbounded preceding and unbounded following);

-- NTH VALUE
-- can fetch value from any particular position that we specify
select *,first_value(product_name) over w as most_exp_prod,last_value(product_name)over w as least_exp_product,nth_value(product_name,2) over w as sec_most_exp_prod from product window w as (partition by product_category order by price desc range between unbounded preceding and unbounded following);

-- NTILE
-- when we want to segregate data equally in few different groups or buckets NTILE can be used
-- write a query to segregate all the expensive phones,mid range phones and cheaper phones

select product_name,
case when x.buckets=1 then 'expensive' when x.buckets=2 then 'mid range' when x.buckets=3 then 'cheaper' end phn_cat
from (select * ,ntile(3) over(order by price desc)as buckets from product where product_category ='phone') x ;

-- CUME_DIST
-- cumulative distribution
-- formula = current row(or row no with value same sa  cureent row)/ total no of rows
--  identifies distribution percentage of each record - values within range 0 and 1

-- write aa query to fetch all the products which are constituting the first 30% of data in products table based on profit
-- ||'' concats the one mentioned before | and one in ' '
-- :: converts the datatype  eg  :: numeric

select *,cume_dist() over(order by price desc) as cum_distribution,round(cast(cume_dist() over(order by price desc) as float) * 100,2) as cume_dist_percentage from product;
select product_name , concat(cume_dist_percentage,'%') as cum_dist_percent from (select *,cume_dist() over(order by price desc) as cum_distribution,round(cast(cume_dist() over(order by price desc) as float) * 100,2) as cume_dist_percentage from product)x where x.cume_dist_percentage<=30;

-- PERCENT RANK  (relative rank of the cureent row/ percentage ranking0
-- value -->  1<= PERCENT RANK >= 0
-- Formula = current row n0 - 1 / total no of rows -1
/* provides a relative rank to each row in the form of percentage */

-- query to identify how much percentage more expensive is "Galaxy z fold 3" when compared to all products.
select product_name,percentage_ranking from(select *,percent_rank() over(order by price) as percentage_rank,round(cast(percent_rank() over(order by price) as float)*100,2) as percentage_ranking from product)x where x.product_name='Galaxy z fold 3';
-- so galaxy z fold 3 is 80.77 percent more expensive than all other 


-- WITH CLAUSE -- CTE ( Common table expression) or (sub-query factoring)

create table emp
( emp_ID int
, emp_NAME varchar(50)
, SALARY int);

insert into emp values(101, 'Mohan', 40000),(102, 'James', 50000),(103, 'Robin', 60000),(104, 'Carol', 70000),(105, 'Alice', 80000),(106, 'Jimmy', 90000);

select * from emp;

-- fetch employeesn who earn more than the average salary of all employees
-- this question is just for syntax example
-- here with average_salary(avg_sal) works as a temporary table memory until this full query ends
with average_salary(avg_sal) as (select cast(avg(salary)as unsigned) from emp)      
select * from emp e,average_salary av where e.salary>av.avg_sal;     -- unsigned is (integer type) we can mention signed or unsigned for int in cast in mysql


-- PROBLEMS FOR WITH

create table sales
(
	store_id  		int,
	store_name  	varchar(50),
	product			varchar(50),
	quantity		int,
	cost			int
);
insert into sales values
(1, 'Apple Originals 1','iPhone 12 Pro', 1, 1000),
(1, 'Apple Originals 1','MacBook pro 13', 3, 2000),
(1, 'Apple Originals 1','AirPods Pro', 2, 280),
(2, 'Apple Originals 2','iPhone 12 Pro', 2, 1000),
(3, 'Apple Originals 3','iPhone 12 Pro', 1, 1000),
(3, 'Apple Originals 3','MacBook pro 13', 1, 2000),
(3, 'Apple Originals 3','MacBook Air', 4, 1100),
(3, 'Apple Originals 3','iPhone 12', 2, 1000),
(3, 'Apple Originals 3','AirPods Pro', 3, 280),
(4, 'Apple Originals 4','iPhone 12 Pro', 2, 1000),
(4, 'Apple Originals 4','MacBook pro 13', 1, 2500);

select * from sales;

-- find who's sales is better than the average sales across all stores 
-- withiout with clause...using only subqueries
/* here we have to find first 
	1. total sales per each store - Total_sales
    2. find the average sales with respect to all the stores - avg_sales
    3. find the store where Total_sales is higher than the avg_sales of all stores*/
-- 1
select s.store_id,sum(cost) as Total_sales from sales s group by s.store_id;
-- 2 
select cast(avg(Total_sales)as unsigned)as avg_sales_forall from(select s.store_id,sum(cost) as Total_sales from sales s group by s.store_id)x;   -- we have to mention the alias nam compulsory as we are not using where...and we are using from
-- 3
SELECT 
    *
FROM
    (SELECT 
        s.store_id, SUM(cost) AS Total_sales
    FROM
        sales s
    GROUP BY s.store_id) total_sales
        JOIN
    (SELECT 
        CAST(AVG(Total_sales) AS UNSIGNED) AS avg_sales_forall
    FROM
        (SELECT 
        s.store_id, SUM(cost) AS Total_sales
    FROM
        sales s
    GROUP BY s.store_id)x) average_sales ON total_sales.total_sales > average_sales.avg_sales_forall;

-- here we are running the same subquery multiple times which is not good , complicated and affects performance

-- WITH clause
with total_sales(store_id,total_sales_per_store) as (select s.store_id,sum(cost) as total_sales_per_store from sales s group by store_id),
average_sales(avg_sales) as (select cast(avg(total_sales_per_store)as unsigned) as avg_sales from total_sales)
select *  from total_sales ts join average_sales av on ts.total_sales_per_store>av.avg_sales;


-- RECURSIVE QUERIES
-- syntax --
/* WITH [RECURSIVE] CTE_name AS
		( SELECT query ( NON RECURSIVE query or BASE query)
        UNION [ALL]
        (SELECT query (RECURSIVE query using CTE_name [with a TERMINATION CONDITION]))
        SELECT * FROM CTE_name: */

/* Difference in Recursive Query syntax for PostgreSQL, Oracle, MySQL, MSSQL.
- Syntax for PostgreSQL and MySQL is the same.
- In MSSQL, RECURSIVE keyword is not required and we should use UNION ALL instead of UNION.
- In Oracle, RECURSIVE keyword is not required and we should use UNION ALL instead of UNION. Additionally, we need to provide column alias in WITH clause itself
*/

--  Dispaly numbers from 1 to 10 without using any inbuilt functions
with recursive numbers as 
(select 1 as n
union
select n+1 from numbers where n<10)
select* from numbers;

-- Find the hierarchy of employees under the given manager

CREATE TABLE emp_details
    (
        id           int PRIMARY KEY,
        name         varchar(100),
        manager_id   int,
        salary       int,
        designation  varchar(100)

    );

INSERT INTO emp_details VALUES (1,  'Shripadh', NULL, 10000, 'CEO');
INSERT INTO emp_details VALUES (2,  'Satya', 5, 1400, 'Software Engineer');
INSERT INTO emp_details VALUES (3,  'Jia', 5, 500, 'Data Analyst');
INSERT INTO emp_details VALUES (4,  'David', 5, 1800, 'Data Scientist');
INSERT INTO emp_details VALUES (5,  'Michael', 7, 3000, 'Manager');
INSERT INTO emp_details VALUES (6,  'Arvind', 7, 2400, 'Architect');
INSERT INTO emp_details VALUES (7,  'Asha', 1, 4200, 'CTO');
INSERT INTO emp_details VALUES (8,  'Maryam', 1, 3500, 'Manager');
INSERT INTO emp_details VALUES (9,  'Reshma', 8, 2000, 'Business Analyst');
INSERT INTO emp_details VALUES (10, 'Akshay', 8, 2500, 'Java Developer');
commit;

select * from emp_details;

-- Find the hierarchy of employees under the given manager "asha"
use dataanalytics_db;
with recursive emp_hierarchy as
(select id,name,manager_id,designation from dataanalytics_db.emp_details where name = 'asha'
union
select e.id,e.name,e.manager_id,e.designation from emp_hierarchy H join dataanalytics_db.emp_details e on H.id=e.manager_id)
select * from emp_hierarchy;

-- since its not in ordered levels properly
with recursive emp_hierarchy as
(select id,name,manager_id,designation,1 as lvl from dataanalytics_db.emp_details where name='asha'
union
select e.id,e.name,e.manager_id,e.designation,1+H.lvl as lvl from emp_hierarchy H join dataanalytics_db.emp_details e on H.id=e.manager_id)
select * from emp_hierarchy;

-- if we are asked to dispaly also manager names
with recursive emp_hierarchy as
(select id,name,manager_id,designation,1 as lvl from dataanalytics_db.emp_details where name='asha'
union
select e.id,e.name,e.manager_id,e.designation,1+H.lvl as lvl from emp_hierarchy H join dataanalytics_db.emp_details e on H.id=e.manager_id)
select H2.id,H2.name as emp_name, E2.name as manager_name,H2.lvl as lvl  from emp_hierarchy H2 join emp_details E2 on E2.id=H2.manager_id;

-- find the hierarchy of managers for a given employee "david"
with recursive mngr_hierarchy as
(select id,name,manager_id,designation , 0 as lvl from dataanalytics_db.emp_details where name ='david'
union
select E.id,E.name,E.manager_id,E.designation,H.lvl+1 as lvl from mngr_hierarchy H join dataanalytics_db.emp_details E on E.id=H.manager_id)
select * from mngr_hierarchy;
-- IF WE ARE AKED ALSO MANAGER NAMES
with recursive mngr_hierarchy as
(select id,name,manager_id,designation , 0 as lvl from dataanalytics_db.emp_details where name ='david'
union
select E.id,E.name,E.manager_id,E.designation,H.lvl+1 as lvl from mngr_hierarchy H join dataanalytics_db.emp_details E on E.id=H.manager_id)
select H2.id as emp_id,H2.name as emp_name,E2.name as manager_name,H2.lvl as lvl from mngr_hierarchy H2 join emp_details E2 on E2.id=H2.manager_id;




 