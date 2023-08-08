/* Constraints:
5 types of keys supported in MySQL
Primary Key,  Foreign Key, Composite Primary Key, Unique Key, Candidate Key
Auto Increment
DDL and DML commands
 */
 /* DDL - Create, Alter, Drop, Truncate
DML - Insert, Update, Delete
DQL - Select
*/
create database 360digitmg;
use 360digitmg;
create table student(first_name varchar(20) not null,last_name varchar(20) not null, age int not null, course_enrolled varchar(20) not null default 'Data Analytics',course_fee int not null);
-- it will throw an error that course_enrolled cannot be null
insert into student values('Madhavi','kumari',24,null,20000);
insert into student(first_name,last_name,age,course_fee) values('Madhavi','Kumari',24,20000);
select * from student;
drop table student;

-- CREATE table with an ID column
create table student( id int, first_name varchar(20) not null, last_name varchar(20) not null,age int not null,course_enrolled varchar(20) not null default 'Data Analytics',course_fee int not null);
desc student;
insert into student(id,first_name,last_name,age,course_fee) values(1,'Madhavi','Kumari',24,40000);
insert into student(id,first_name,last_name,age,course_fee) values(1,'Madhavi','Kumari',24,40000);
select * from student;
insert into student(id,first_name,last_name,age,course_fee) values(1,'Madhavi','Kumari',24,40000);
select * from student;
drop table student;

create table student( id int primary key, first_name varchar(20) not null, last_name varchar(20) not null,age int not null,course_enrolled varchar(20) not null default 'Data Analytics',course_fee int not null);
-- this will show an error because Primary Key cannot be null.
insert into student(id,first_name,last_name,age,course_fee) values(null,'Madhavi','Kumari',24,40000);
insert into student(id,first_name,last_name,age,course_fee) values(1,'Madhavi','Kumari',24,40000);
-- this will show an error that the primary key cannot be duplicated
insert into student(id,first_name,last_name,age,course_fee) values(1,'Madhavi','Kumari',24,40000);
insert into student(id,first_name,last_name,age,course_fee) values(2,'Madhavi','Kumari',24,40000);
select * from student;
drop table student;

create table student(id int, first_name varchar(20) not null,last_name varchar(20) not null, age int not null,course_enrolled varchar(20) not null default 'Data Analytics',course_fee int not null, primary key(id));
insert into student(id,first_name,last_name,age,course_fee) values(1,'Madhavi','Kumari',24,40000);
insert into student(id,first_name,last_name,age,course_fee) values(2,'Madhavi','Kumari',24,40000);

-- COMPOSITE PRIMARY KEY
create table sales_rep(rep_fname varchar(20) not null, rep_lname varchar(20) not null, salary int not null);
insert into sales_rep values('Anil','Sharma',25000),('Anil','Verma',30000),('Anil','Sharma',25000);
select * from sales_rep;
drop table sales_rep;

create table sales_rep(rep_fname varchar(20) not null, rep_lname varchar(20) not null, salary int not null,primary key(rep_fname,rep_lname));
-- will throw an error
insert into sales_rep values('Anil', 'Sharma', 25000), ('Ankit', 'Verma', 30000), ('Anil', 'Sharma', 25000);
insert into sales_rep values('Anil', 'Sharma', 25000), ('Ankit', 'Verma', 30000), ('Sunil', 'Sharma', 25000);
select * from sales_rep;

-- AUTO-INCREMENT
-- Throw error duplicate entry 
insert into student(id,first_name,last_name,age,course_enrolled,course_fee) values(2, 'Sandhya', 'Devi', 28, 'Data Science', 50000);
drop table student;
create table student(id int auto_increment,first_name varchar(20) not null,last_name varchar(20) not null,age int not null,course_enrolled varchar(20) not null default 'Data Analytics',course_fee int not null,primary key(id));
desc student;
insert into student(first_name,last_name,age,course_enrolled,course_fee) values('Sandhya','Devi',28,'Data Science',50000),('Priya','Dharshini',25,'Data Science',50000);
select * from student;
insert into student(first_name, last_name, age, course_fee) values ('Ravi', 'Mittal', 28, 30000), ('Akhil', 'K', 25, 30000);
select * from student;

-- Beginning AUTO INCREMENT from a different value ( by default it will be 1 )
create table identification(id int auto_increment,name varchar(20), primary key(id));
alter table identification auto_increment = 1001;
insert into identification(name) values('Ravi'),('Mohan'),('Priya');
select * from identification;

/* Primary Key is used to recognize each record in a distinct manner, it will not accept nulls and there can be only one Primary Key in a table.
Primary Key could be on multiple columns - Composite Primary Key. */

/*  UNIQUE KEY - ALLOW ONLY DISTINCT VALUES TO BE ENTERED IN A FIELD.
A Table can have multiple Unique Keys. Null entries are allowed. */

create table email_registration(f_name varchar(20) not null, l_name varchar(20) not null, email varchar(50) not null);
 insert into email_registration values ('Mohan', 'Bhargav', 'mohan_b@gmail.com');
 insert into email_registration values ('Mohan', 'Bhajpai', 'mohan_b@gmail.com');
select * from email_registration;
-- people with the same email id, which should not be allowed
drop table email_registration;
create table email_registration(f_name varchar(20),l_name varchar(20),email varchar(50) unique key,primary key(f_name,l_name));
insert into email_registration values('Mohan','Bhargav','mohan_b@gmail,com');
insert into email_registration values ('Mohan', 'Bhajpai', null);
-- will be allowed
drop table email_registration;
create table email_registration(f_name varchar(20) not null,l_name varchar(20) not null, email varchar(50) not null unique key,primary key(f_name, l_name));
desc email_registration;
insert into email_registration values ('Mohan', 'Bhargav', 'mohan_b@gmail.com');
insert into email_registration values ('Mohan', 'Bhajpai', 'mohan_b@gmail.com');
-- second insert statement will throw an error "duplicate entry)
-- won't work as 'null' is given for email, which violates the not null constraint
insert into email_registration values ('Mohan', 'Bhajpai', null);
insert into email_registration values ('Mohan', 'Bhajpai', 'mohan_bhajpai@gmail.com');
insert into email_registration values ('Sakshi', null, 'sakshi@gmail.com');
insert into email_registration values ('Sakshi', 'Rajpoot', 'sakshi_r@gmail.com');
select * from email_registration;
/* UNIQUE KEY is used to make sure unique values (no duplicates) are entered into a field.
UNIQUE KEY can take NULL also, and we can have multiple unique keys in a table. */

/* 
Difference between Primary Key and Unique Key - 
1) There can be only 1 Primary key, whereas there can be multiple Unique Keys
2) Primary Key cannot be NULL, whereas Unique Key could be NULL */

/* DDL - Create, Alter, Drop, Truncate 
DML - Insert, Update, and Delete
DQL - Select */
select * from student;  
-- it gives all the columns and all the rows/tuples
select first_name, last_name from student where course_fee>40000;
-- it gives the selected columns and rows meeting the where condition
select first_name, last_name from student where first_name = 'sandhya';
-- by default it is not case sensitive
select first_name, last_name from student where binary first_name = 'sandhya';
-- use the binary option to make it case sensitive
select * from student where first_name like '____';
-- give the names with exactly 4 characters in it
select * from student where first_name like 'a%';
-- give the names which have the character 'a' in the first place
insert into student(first_name, last_name, age, course_enrolled, course_fee) values ('Sand%ya', 'Devi', 28, 'Data Science', 50000);
select * from student where first_name like '%\%y%';

--  Update Statements: 
use 360digitmg;
update student set course_fee=35000 where course_enrolled = 'Data Analytics';
update student set course_fee = course_fee-5000;
update student set course_fee=course_fee+(course_fee*0.5) where course_enrolled = 'Data Analytics';
-- Delete Statements: 
--  delete certian rows which meet the conditions
delete from student where first_name='Ravi';
-- deletes all the rows
delete from student;

-- DDL - Drop, Alter, Truncate
-- ALTER statement
alter table student add column location varchar(20) not null default 'Hyderabad';

desc student;
alter table student modify column first_name varchar(50);
desc email_registration;
alter table email_registration drop primary key;
alter table email_registration add primary key(f_name,l_name);
-- drop the unique key constraint
alter table email_registration drop constraint email;
alter table email_registration add constraint unique key(email);

/* Drop - deletes the entire table along with the structure
Truncate - Drops the table and recreates the structure. We can't give a "Where" clause.
Delete - Deletes the Rows/Tuples in the table, we can give the "Where" clause and delete exactly what needs to be deleted. */

-- INDEX and CASE
use 360digitmg;
select * from sales_rep;
create index idx_rep_fname on sales_rep(rep_fname);
drop index idx_rep_fname on sales_rep ; 
-- CASE
create table product(product_name varchar(20),quantity int);
insert into product values('Chairs',20),('Tables',5),('Bookcases',10),('Storage',25);
select product_name, quantity,
case 
when quantity>10 then 'More than 10'
 when quantity<10 then 'less than 10' 
 else 'equal to 10' 
 end as qualityText 
 from product;
 -- Sub Queries or Nested Queries:
create table department (id int primary key, name varchar(10));
insert into department values(1,'IT'),(2,'HR');
select * from department;

create table emp1 (id serial primary key, name varchar(20), salary real,departmentId int,foreign key(departmentId) references department(id));
insert into emp1 (name,salary,departmentId) values('Ravi',70000,1),('Ram',90000,1),('Priya',80000,2),('Mohan',75000,2),('Shilpa',90000,1);
select * from emp1;
-- violates the foreign key constraint becaud this id is not in department table
insert into emp1 (name, salary, departmentId) values ('Manoj', 80000, 3); 
--  Find out the names of Employees whose salary is less than the overall average
select avg(salary) from emp1;
select * from emp1 where salary<81000;
select *  from emp1 where salary<(select avg(salary) from emp1);
-- Get the highest salary by the department.
select departmentid,max(salary) from emp1 group by departmentid;
-- Show the department id also in the above query.

-- Show the name of the department.
select departmentId,department.name,max(salary) from emp1 inner join department on emp1.departmentId=department.id group by departmentId,department.name;

-- show the name of the employee also.
select emp1.name,departmentId,department.name,max(salary) from emp1 inner join department on emp1.departmentId=department.id group by departmentId,department.name,emp1.name;
-- This doesn't work as we are now creating groups on the combination of Department and Employee.
select department.name, emp1.name, salary 
from emp1 inner join department 
on emp1.departmentId = department.id 
where (departmentId, salary) in 
(select departmentId, max(salary) as salary from emp1 group by departmentId);

-- Selecting the second-highest salary of an employee
select max(salary) from emp1; -- this will give the maximum salary
-- suppose we need the salaries which are less than this
select salary from emp1 where salary<(select max(salary) from emp1);
-- The second maximum means - the maximum of this new list:
select max(salary) from emp1 where salary < (select max(salary) from emp1);

-- How to get top nth, this would not be an optimum solution, instead, we can use this:
select salary as second_high_sal from emp1 order by salary desc limit 1 offset 1;

-- JOINS
create table courses(name varchar(20),course varchar(20));
insert into courses values('BBB','Tableau'),('CCC','Python'),('DDD','Data Analytics'),('EEE','SQL');
select * from courses;
create table students (name varchar(20),age int);
insert into students values('AAA','22'),('BBB',24),('CCC',25),('DDD',30);
select * from students;

-- INNER JOIN

select name,course,age from students inner join courses on name = name;
 -- column reference "name" is ambiguous
select students.name,age,course from students inner join courses on students.name=courses.name;

-- LEFT JOIN
select students.name,age,course from students left join courses on students.name = courses.name;

-- RIGHT JOIN
select students.name,age,courses.name,course from students right join courses on students.name=courses.name; 

-- FULL JOIN-- full join is not supported in mysql
select students.name,age,courses.name,course from students full join courses on students.name=courses.name;

-- CROSS JOIN
select students.name,age,courses.name,course from students cross join courses;

-- Left Outer Join: (Left Only scenario) 
select students.name, age, course from students left join courses on students.name = courses.name where courses.name is null;
-- Right Outer Join: (Right Only Scenario) 
select students.name,age,courses.name,course from students left join courses on students.name=courses.name where students.name is null;

-- Full Outer Join: (Not Inner) scenario 
select students.name,age,courses.name,course from students full join courses on students.name = courses.name where students.name is null or courses.name is null;

-- Check Constraint:
create table school(name varchar(20),schoolname varchar(20) default '360digitmg',age int, check (age>=10));
insert into school(name,age) values ('Ram',10),('Ravi',20);
select * from school;
 insert into school (name, age)  values ('Priya', 8);  
 -- new row for relation "school" violates check constraint "school_age_check"

create table products(product_no int,name text,price numeric check(price>10));
insert into products values(1,'apples',100.00),(2,'oranges',200.00);
select * from products;
insert into products values(3,'grapes',-100.00),(4,'plums',200.00);
-- new row for relation "products" violates check constraint "products_price_check"
insert into products values(3,'grapes',150.00),(4,'plums',200.00); 
select * from products;

-- TIMESTAMP and DATE data types:

create table emp(id serial primary key, name varchar(20) not null,dept varchar(20) not null,date_of_joining timestamp not null default current_timestamp,status varchar(20) default 'Active',salary real not null,last_updated timestamp default now());

select*from emp;
insert into emp(name,dept,salary) values('Ravi Kiran','HR',40000.00),('Priya Dardhini','IT',25000.00),('Mohan Bharghav','Finance',30000.00);
-- Note: MySQL displays DATE values in the 'YYYY-MM-DD' format.
select * from emp;


-- UNIONS   -- without duplicates
use supermart_db;
create table may_2016 (select * from sales where ship_date between '2016-04-30' and '2016-06-01');
create table June_2016 (select * from sales where ship_date between '2016-05-31' and '2016-07-01');
create table July_2016 (select * from sales where ship_date between '2016-06-30' and '2016-08-01');
select * from may_2016 union select * from June_2016 union select * from July_2016;
-- union all including duplicates
select * from may_2016 union all select * from June_2016 union all select * from July_2016;

-- Triggers
-- Create a Table with Sales data
 create table sales_data(
cust_name varchar(20) not null,
product_name varchar(10) not null,
sales real not null,
quantity int not null,
total_price real);
insert into sales_data values('Ravi', 'Chair', 500.0, 5, null), ('Ram', 'Bookcase', 3000.0, 2, null);
select * from sales_data;

delimiter //
create trigger calc_tot_insert before insert on sales_data for each row begin  DECLARE total DECIMAL(10, 2);
    SET total = NEW.sales * NEW.quantity;
    SET NEW.total_price = total;
    end //
delimiter ;
insert into sales_data values('Ravi', 'Chair', 500.0, 5, null), ('Ram', 'Bookcase', 3000.0, 2, null);
-- You will notice that the total_price is calculated:
select * from sales_data;
drop trigger calc_tot_insert;

/* Automatically updating the latest timestamp whenever a record is updated*/
select * from sales_data;
CREATE TABLE employee (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    dept VARCHAR(20) NOT NULL,
    date_of_joining timestamp NOT NULL default current_timestamp,
    status VARCHAR(255) DEFAULT 'active',
    salary DECIMAL(10, 2) NOT NULL,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
insert into employee (name, dept, salary) values ('Ravi Kiran', 'HR', 40000.00), ('Priya Darshini', 'IT', 25000.00), ('Mohan Bhargav', 'Finance', 30000.00);

select * from employee;
delimiter // 
create trigger update_on_status_change before update on employee for each row 
begin set new.last_updated=now();
end //
delimiter ;
update employee set status = 'InActive' where name = 'Priya Darshini';
select * from employee;

create table user_task
(created_on timestamp default CURRENT_TIMESTAMP not null,
    updated_on timestamp default CURRENT_TIMESTAMP not null,
    status varchar(20) not null
);
insert into user_task (status) values('trying'), ('successful'), ('failed');
delimiter // 
create trigger update_user_task_updated_on before update on user_task for each row 
begin
 set new.updated_on=now();
end//
delimiter ;
update user_task set status='Inactive'where status='failed';
select * from user_task;

/* INSTEAD OF TRIGGER */
-- mysql doesnt support it, supperted in postgresql*/

/* -- Create the view
CREATE OR REPLACE VIEW employees_with_audit AS
SELECT emp_id, emp_name, emp_salary, action, timestamp
FROM employees
LEFT JOIN audit_log USING (emp_id);

-- Create the "INSTEAD OF" trigger
CREATE OR REPLACE FUNCTION instead_of_trigger_func()
RETURNS TRIGGER AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        INSERT INTO employees (emp_name, emp_salary) VALUES (NEW.emp_name, NEW.emp_salary);
        RETURN NEW;
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO audit_log (emp_id, action) VALUES (NEW.emp_id, 'Update');
        UPDATE employees SET emp_name = NEW.emp_name, emp_salary = NEW.emp_salary WHERE emp_id = NEW.emp_id;
        RETURN NEW;
    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO audit_log (emp_id, action) VALUES (OLD.emp_id, 'Delete');
        DELETE FROM employees WHERE emp_id = OLD.emp_id;
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER employees_with_audit_trigger
INSTEAD OF INSERT OR UPDATE OR DELETE ON employees_with_audit
FOR EACH ROW
EXECUTE FUNCTION instead_of_trigger_func();
*/