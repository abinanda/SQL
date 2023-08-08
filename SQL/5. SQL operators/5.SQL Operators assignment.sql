-- 1. Create a Student_DB with the tables created from the datasets shared (students.csv files)
create database Student_Db;
use Student_DB;
/* import pandas as pd
from sqlalchemy import create_engine
df=pd.read_csv(r"H:\studies\360digitMG\assignment problem statement\SQL\5. SQL operators\Dataset_Operators\Student.csv")
engine=create_engine("mysql+pymysql://{user}:{pw}@localhost/{db}".format(user='root',pw='Maxima1!',db='Student_DB'))df.to_sql("students",con=engine,if_exists='replace',index=False) */
select * from students;
-- 2.	Write a SQL query to display all the unique values in the "section" column of the "students" table.
select distinct section from students;
-- 3.	Write a SQL query to display the top 5 highest marks from the "students" table.
select Science_Marks from students order by Science_Marks desc limit 5;
-- 4.	Write a SQL query to display the number of students in each class from the "students" table.
SELECT class, COUNT(*) AS num_students FROM students GROUP BY class;
-- 5.	Write a SQL query to display the average marks of all in each section from the "students" table.
select Section,avg(Science_Marks) as avaerage_marks from students group by Section; 
-- 6.	Write a SQL query to display the names and marks of all students in the "students" table in descending order of enrollment_no.
select Name,Science_Marks from students order by Enrollment_No desc;
-- 7.	Write a SQL query to display the names of all students who scored in the "science_marks" and get a marks greater than 60.
select Name from students where Science_Marks>60;


create table new1 (select * from students where  science_Marks>60);
select * from new1;
select * from students;
