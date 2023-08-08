/* 1.	Create a Supermart_DB with the tables created from the datasets shared (Customer.csv, Sales.csv and Product.csv files) */
create database Supermart_DB;
use supermart_DB;
create table customer( Customer_ID varchar(20) primary key,
	Customer_Name varchar(30),	
    Segment varchar(20),
    Age int , Country varchar(20) default 'United States',
    City varchar(20) ,State varchar(20),
	Postal_Code char(6),Region varchar(10));
    
CREATE TABLE product (
    Product_ID VARCHAR(20) PRIMARY KEY,
    Category VARCHAR(20),
    Sub_Category VARCHAR(20),
    Product_Name text
);
/* 2.	Define the relationship between the tables using constraints/keys. */
CREATE TABLE sales (
    Order_Line INT,
    Order_ID VARCHAR(20) PRIMARY KEY,
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(20),
    Customer_ID VARCHAR(20),
    Product_ID VARCHAR(20),
    Sales FLOAT,
    Quantity INT,
    Discount FLOAT,
    Profit FLOAT,
    FOREIGN KEY (Customer_ID)
        REFERENCES customer (Customer_ID),
    FOREIGN KEY (Product_ID)
        REFERENCES product (Product_ID)
);

/* import pandas as pd
from sqlalchemy import create_engine
df=pd.read_csv(r"H:\studies\360digitMG\assignment problem statement\SQL\4. Sql data types and relational integrity\Assignments_04_SQL_datasets\Customer.csv")
engine=create_engine("mysql+pymysql://{user}:{pw}@localhost/{db}".format(user="root",pw="Maxima1!",db="Supermart_DB"))
column_mapping = {
    'Customer ID': 'Customer_ID',
    'Customer Name': 'Customer_Name',
    'Segment': 'Segment',
    'Age': 'Age',
    'Country': 'Country',
    'City': 'City',
    'State': 'State',
    'Postal Code': 'Postal_Code',
    'Region': 'Region',
}
df = df.rename(columns=column_mapping)
df.to_sql("customer",con=engine,if_exists='append',index=False)
*/
/*import pandas as pd
from sqlalchemy import create_engine
df=pd.read_csv(r"H:\studies\360digitMG\assignment problem statement\SQL\4. Sql data types and relational integrity\Assignments_04_SQL_datasets\Sales.csv")
engine=create_engine("mysql+pymysql://{user}:{pw}@localhost/{db}".format(user="root",pw="Maxima1!",db="Supermart_DB"))
column_mapping = {
    'Order Line': 'Order_Line',
    'Order ID': 'Order_ID',
    'Order Date': 'Order_Date',
    'Ship Date': 'Ship_Date',
    'Ship Mode': 'Ship_Mode',
    'Customer ID': 'Customer_ID',
    'Product ID': 'Product_ID',
    'Sales': 'Sales',
    'Quantity': 'Quantity',
    'Discount': 'Discount',
    'Profit': 'Profit'
}
df = df.rename(columns=column_mapping)
# Convert date columns to the correct format
df['Order_Date'] = pd.to_datetime(df['Order_Date']).dt.strftime('%Y-%m-%d')
df['Ship_Date'] = pd.to_datetime(df['Ship_Date']).dt.strftime('%Y-%m-%d')
df_1=df['Order_ID'].duplicated(keep=False)
df_new=df[~df_1]
df_new.to_sql("sales",con=engine,if_exists='append',index=False)
*/


/* 3.	In the database Supermart _DB, find the following:
a.	Get the list of all the cities where the region is north or east without any duplicates using IN statement.
b.	Get the list of all orders where the ‘sales’ value is between 100 and 500 using the BETWEEN operator.
c.	Get the list of customers whose last name contains only 4 characters using LIKE.
*/
select *from customer;
select * from  product;
select * from sales limit 10;
select distinct City from customer where region in ('North','East');
select Order_ID from sales where Sales between 100 and 500;
select Customer_ID , Customer_Name from customer where Customer_Name like '% ____';

/* 1.	Retrieve all orders where the ‘discount’ value is greater than zero ordered in descending order basis ‘discount’ value */
select Order_ID from sales where Discount>0 order by Discount desc;
-- 2.	Limit the number of results in the above query to the top 10.
select Order_ID from sales where Discount>0 order by Discount desc limit 10;

/* 1.	Find the sum of all ‘sales’ values.
2.	Find count of the number of customers in the north region with ages between 20 and 30
3.	Find the average age of east region customers
4.	Find the minimum and maximum aged customers from Philadelphia
*/
select sum(Sales) from sales;
select count(Customer_ID) from customer where region in ('North') and age between 20 and 30;
select avg(age) from customer where region = 'East';
select  min(age),max(age) from customer where region = 'Philadelphia';

/* 1.	Make a dashboard showing the following figures for each product ID
a.	Total sales (in $) order by this column in descending 
b.	Total sales quantity
c.	The number of orders
d.	Max Sales value
e.	Min Sales value
f.	Average sales value
*/
select concat(sum(sales),'$') as a,Product_ID from sales group by product_ID order by a desc;
select sum(quantity) from sales;
select count(Order_Id) as no_of_orders from sales;
select max(sales) from sales;
select min(sales) from sales;
select avg(sales) from sales;

/* 2.	Get the list of product ID’s where the quantity of product sold is greater than 10*/
select product_id from sales where sales>10;




