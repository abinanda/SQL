/* 1.	Create a table called "students" with the following columns: "id" (integer, primary key), "name" (text), "age" (integer), "gender" (text), and "major" (text). */
use myassignments;
create table students(id int primary key, name varchar(20),age int, gender varchar(10),major varchar(20));
/* 2.	Insert a new row into the "students" table with the following values: id=1, name='John Smith', age=22, gender='Male', major='Computer Science'. */
insert into students values(1,'john Smith',22,'Male','Computer Science');
/* 3.	Write a SQL query to retrieve the names of all students in the "students" table. */
select name from students;
/* 4.	Write a SQL query to retrieve the names and ages of all female students in the "students" table. */
select name,age from students where gender ='Female';
/*5.	Write a SQL query to update the age of the student with id=1 to 23.*/
update students set age=23 where id =1;
/* 6.	Create a new table called "courses" with the following columns: "id" (integer, primary key), "name" (text), and "description" (text).*/
create table courses(id int primary key,name varchar(20),description varchar(20));

-- 1.Create a database ‘classroom’
create database classroom;
use classroom;
/* 2.	Create a table named ‘science_class’ with the following properties
a.	columns(enrollment_no int, name varchar, science_marks int) */
create table science_class(enrollment_no int,name varchar(20),science_marks int);

/* 1.	Insert the following data into science_class using the insert into command
1	popeye	33
2	olive	54
3	brutus	98
*/
insert into science_class values(1,'popeye',33),(2,'olive',54),(3,'brutus',98);

/* 2.	import data from CSV file ‘student.csv’ attached in resources to science_class to insert data of the next 8 students*/

/* import pandas as pd
from sqlalchemy import create_engine
df=pd.read_csv(r"H:\studies\360digitMG\assignment problem statement\SQL\3. SQL commands\Assignments_SQL Commands_dataset\Student.csv")
engine=create_engine("mysql+pymysql://{user}:{pw}@localhost/{db}".format(user="root",pw="Maxima1!",db="classroom"))
df.to_sql("science_class",con=engine,if_exists='append',index=False) */

-- 1.	Retrieve all data from the table ‘Science_Class’
select * from science_class;
-- 2.	Retrieve the name of students who have scored more than 60 marks
select name from science_class where science_marks>60;
-- 3.	Retrieve all data of students who have scored more than 35 but less than 60 marks
select * from science_class where science_marks>35 and science_marks<60;
-- 4.	Retrieve all other students i.e., who have scored less than or equal to 35 or more than or equal to 60.
select name , science_marks from science_class where science_marks<=35 or science_marks>=60;




