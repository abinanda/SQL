/* Clauses:
Distinct, Order By, Limit, Aggregate functions, Group By, Having */
use myassignments;
create table employee(id SERIAL primary key , f_nm varchar(20) not null ,l_nm varchar(20) not null, age int not null, location varchar(20) default 'hyderabad', dept varchar(20) not null);
alter table employee add salary real not null;
select * from employee;
insert into employee(f_nm,l_nm,age,dept,salary) values('Ravi','kiran',25,'HR',30000.00);
insert into employee(f_nm,l_nm,age,dept,salary)values('Priya','Darshini',28,'HR',32000.00),('Mohan','Bhargav',35,'IT',40000.00),('Moanoj','Bajpai',40,'IT',45000.00);
insert into employee (f_nm, l_nm, age, location, dept, salary) values ('Akhil', 'K', 26, 'Bangalore', 'IT', 42000.00),('Raja', 'Roy', 35, 'Bangalore', 'IT', 60000.00),('Shilpa', 'Sharma', 40, 'Chennai', 'IT', 44000.00);
select * from employee;

/* DISTINCT - unique values , no repetition */
select location from employee;
select distinct location from employee ;
select distinct dept from employee;
select count(distinct dept) from employee;

/* ORDER BY - sort the data, and arrange the data in a sequence, either in ascending order (default) or in descending order (desc) */
select f_nm from employee;
select f_nm from employee order by f_nm;
select f_nm from employee order by f_nm desc;
select f_nm from employee order by age;
select f_nm from employee order by age desc;
select * from employee order by age, salary; 
-- second level sort will happen in case of a clash

/* LIMIT - to put a limit on the number of records to be fetched (filter -eliminate what is not required) */
select * from employee limit 3;
-- bottom 3 employees by salary
select * from employee order by salary limit 3;
-- top 3 emloyee by salary
select * from employee order by salary desc limit 3;
select * from employee order by age,salary limit 5;
-- gives the first record
select id,f_nm,l_nm from employee order by id limit 1 offset 0 ;
-- begining in th 4th place it will give 3 records
select id,f_nm,l_nm from employee order by id limit 3 offset 3;

/* AGGREGaTION fuNCTIONs - SUM, AVG, MIN,  Max, Count, Count Distinct */

-- get total number of records
select count(*) from employee;
-- From how many locations are people joining:
select count(location) from employee;
-- From how many distinct locations are people joining:
select count( distinct location) from employee;

-- To give an alias name to the column:  as
select count(distinct location) as Num_0f_locations from employee;
-- To get the number of people above 30 years: 
select count(f_nm) from employee where age>30;
select count(f_nm) from employee where age>25 and age<35;

-- Total salaries being paid to employees
select sum(salary) from employee;
-- Average of the salaries being paid to the employees
select avg(salary) from employee;
-- similarly, minimum and maximum also can be done.

-- Identify the youngest employee
select min(age) from employee;
select f_nm from employee  where age=25;
-- gives the minimum age, but to know who is the employee:
select f_nm,l_nm from employee order by age limit 1;

-- GROUP BY  AND HAVING

select count(location) from employee;
select * from employee;
select count(distinct location ) from employee;
-- number of employees in each location
select location ,count(*) from employee group by location;
-- number of employees in each location in each department
select location,dept,count(*) from employee group by location,dept;
-- number of employees in each location in each department and above 30 years of age
select location,dept,count(*) from employee where age>30 group by location,dept;

/* WHERE must be used before GROUP BY. 
Here, we can use HAVING as "HAVING" works after the aggregation to work with the aggregated data.*/

select  location,count(*) as total from employee group by location;

--  We need the list of locations with more than 1 employee -
select location, count(*) as total from employee group by location having count(*) >1;
-- Number of people from each location-
 select location, count(*) from employee group by location ;
 -- Number of people from hyderabad
 select location,count(*) from employee group by location having location ='Hyderabad';
 
 -- this would put a computational load on the server, instead, we can do this - 
select location, count(*) from employee where location = 'Hyderabad' group by location;
/* check the run time Where is used to filter the records 
before group by, and having is after group by to work with
 aggregated data.*/
 
 








