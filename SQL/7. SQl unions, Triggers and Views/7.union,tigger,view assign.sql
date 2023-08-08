-- 1.	Write a SQL query that creates a trigger on a table.
use supermart_db;
select * from customer;
delimiter //
create trigger update_name_save_ before update on customer for each row 
begin IF NEW.customer_name = 'Alex Alvia' THEN
        SET NEW.customer_name = 'Alex';
    END IF;
end //
delimiter ;

-- 2.	Write a SQL query that uses a trigger to update data in a table.

delimiter //
create trigger update_name_save_ before update on customer for each row 
begin IF NEW.customer_name = 'Alex Alvia' THEN
        SET NEW.customer_name = 'Alex';
    END IF;
end //
delimiter ;

update customer set customer_name='Alex Alvia' where age=25;
select * from customer where customer_name='alex';

-- 3.	Give an example of a scenario where a trigger would be useful in SQL, and explain how it can be implemented in a query.

/* consider a scenario where you have two tables: orders and order_log. The orders table stores information about customer orders, and the order_log table is used to keep track of any updates or changes made to the orders. Whenever a record in the orders table is updated or inserted, you want to automatically log the changes in the order_log table to maintain a history of all modifications */

/* AFTER Trigger:
Executes after the completion of the original DML operation (INSERT, UPDATE, DELETE).
Used for tasks like logging, auditing, or enforcing constraints post data modification.

INSTEAD OF Trigger:
Executes instead of the original DML operation.
Not supported in all databases */

-- 5.	What is the purpose of the INSTEAD OF DELETE trigger operator in SQL?
/* INSTEAD OF DELETE triggers are commonly used when working with complex views that involve multiple tables or when the view is not directly updatable , with this we can implement custom delete logic ,update related tables or any other manipulation.*/










