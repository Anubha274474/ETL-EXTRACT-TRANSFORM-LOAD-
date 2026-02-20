-- DATA QUALITY AND VALIDATION IN ETL (ASSIGNMENT)

-- Question 1- Define data Quality in the context of ETL pipelines.
-- Why is it more than just data cleaning?
-- Answer
-- Data Quality in ETL refers to the overall fitness of data for its intended 
-- use- accuracy,completeness,consistency,timeliness,relevence. Its more then cleaning because it onvolves profiling.
-- Validation, Enrichment,and governance to ensure the data supports reliable analytical and decisions
-- throughout the pipeline. 


-- Question 2- Explain why poor data quality leads to misleading dashboards and incorrect decisions
-- Answer
-- Poor data quality )e.g, missing,inaccurate,or inconsistent values) distorts 
-- analysis,causing dashboards to display wrong metrics. 

-- Decision-makers then act on false insights,leading to business errors,wasted resources,or missed opportunities. 

-- Question 3- What is duplicate data? Explain three causes in ETL pipelines
-- Answer

-- Duplicate data are multiple records representing the same real-world entity. Three common causes in ETL are:
-- 1-> Multiple source systems feeding the same entity
-- 2-> Merge/join errors that create redundant rows. 
-- 3-> Manual entry of the same transection multiple times. 

-- Question 4- Differentiate between exact,partial and fuzzy duplicates
-- Answer
-- Exact Duplicates-> Identical records in every field. 
-- Partial Duplicates-> Records share a subset of key fields (e.g same id but different timestamp). 
-- Fuzzy Duplicates-> Similar but not identical records,requiring matching algorithms 
-- (e.g , name variations like "Rahul Mehta" vs "R.Mehta). 

-- Question 5- Why should data validation be performed during transformation rather than after loading?
-- Validation during transformation catches errors early,preventing bad data from enetring the target system. 
-- It reduces costly post-load fixes, ensures data integrity and improves overall ETL efficiency. 

-- Question 6- Explain how business rules help in validating data acccuracy. Give an example. 
-- Answer
-- Business rules define constraints specific to the domain(e.g "txn Amount must be positive")
-- Applying them during ETL checks data against these rules,Flagging violation(e.g a negative Txn Amount) to 
-- ensure accuracy. 

create table Sales_Transections(
Txn_ID int primary key,
Customer_ID varchar(50),
Customer_Name varchar(50),
Product_ID varchar(50),
Quantity int,
Txn_Amount int,
Txn_Date date,
City varchar(50)
); 
insert into Sales_Transections (Txn_ID,Customer_ID,Customer_Name,Product_ID,Quantity,Txn_Amount,Txn_Date,City)
values
(201,'C101','Rahul Mehta','P11',2,4000,'2025-12-01','Mumbai'),
(202,'C102','Anjali Rao','P12',1,1500,'2025-12-01','Bengluru'),
(203,'C101','Rahul Mehta','P11',2,4000,'2025-12-01','Mumbai'),
(204,'C103','Suresh Iyer','P11',3,6000,'2025-12-02','Chennai'),
(205,'C104','Neha Singh','P14',NULL,2500,'2025-12-02','Delhi'),
(206,'C105',null,'P15',1,null,'2025-12-03','Pune'),
(207,'C106','Amit Verma','P16',1,1800,null,'Pune'),
(208,'C101','Rahul Mehta','P11',2,4000,'2025-12-01','Mumbai');

select * from Sales_Transections;

-- Question 7-Write an sql query on Sales_Transections to list all duplicates keys and their counts using the
-- business key (Customer_ID+Txn_Date+Txn_Amount)
-- Answer
select Customer_ID,Product_ID,Txn_Date,Txn_Amount,count(*) as Dup_Count
from Sales_Transections
group by Customer_ID,Product_ID,Txn_Date,Txn_Amount
having count(*)>1;


-- Question 8- Enforcing Refrential Integrity
-- Assume the following Customer_Master table
-- Answer
create table Customer_Master(
CustomerID varchar (50) primary key,
CustomerName varchar(50),
City varchar(50)
);
insert into Customer_Master(CustomerID,CustomerName,City)
values
('C101','Rahul Mehta','Mumbai'),
('C102','Anjali Rao','Bengluru'),
('C103','Suresh Iyer','Chennai'),
('C104','Neha Singh','Delhi');

select * from Customer_Master;

-- Identify Sales_Transection.Customer_ID values that violate refrential integrity
-- when joined with Customer_Master and write a query to detect such violations. 

select distinct  st.Customer_ID
from sales_transections st
left join Customer_Master cm
on st.Customer_ID= cm.CustomerID
where cm.CustomerID is null;





