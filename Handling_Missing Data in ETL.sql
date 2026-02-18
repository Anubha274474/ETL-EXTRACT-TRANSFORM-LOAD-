-- Handling Missing Values in ETL(ASII)

-- Objective
-- this dpp helps understand:
-- Why missing data occurs in ETL pipelines
-- How different handling techniques impact analytics
-- How to choose the right method insteadof blindly deleting data

-- SECTION "A" - THEORETICAL QUESTIONS

-- Question 1- What are the most common reasons for missing data in ETL pipelines?
-- Solution
-- Common reasons for missing data in ETL pipelines are
-- 1. Data extraction errors (e.g., API failures).
-- 2. Incomplete source records (manual entry omissions).
-- 3. Data integration mismatches (schema changes).
-- 4. Deliberate omissions (optional fields).

-- Question 2- Why is blindly deleting rows with missing values considered a bad practice in ETL?
-- Answer
-- Blindly deleting rows with missing values is bad practice because it can
-- 1->cause loss of valuable information,
-- 2 introduce bias if missingness isn’t random,
-- 3 reduce sample size and affect statistical power.

-- Question 3-Explain the difference between:

-- (1) Listwise deletion

-- (2)Column deletion

-- (3)Also mention one scenario where each is appropriate.
-- Answer
-- - Listwise deletion removes entire rows where any variable is missing.
-- Appropriate scenario: when missing data is completely random (MCAR) and few rows are affected.
-- Column deletion drops the entire column if it has too many missing values.
-- Appropriate scenario: when a column is largely incomplete and its information is redundant or non‑essential.

-- Question 4-Why is median imputation preferred over mean imputation for skewed data such as income?
-- Answer
--  Median imputation is preferred over mean for skewed data (e.g., income) because the median is 
-- unaffected by extreme values, preventing distortion of the distribution that the mean would introduce.

-- Question 5-  What is forward fill and in what type of dataset is it most useful?
-- Answer
--  Forward fill replaces a missing value with the previous non‑missing value in the sequence.
-- It is most useful in time‑series datasets where observations are ordered and the previous 
-- value is a reasonable estimate (e.g., sensor readings).

-- Question 6- Why should flagging missing values be done before imputation in an ETL workflow?

-- answer-> Flagging missing values before imputation is done to
-- (1) preserve information about the missingness pattern,
-- (2)enable analysis of why data is missing,
-- (3) prevent imputed values from being treated as original data in later analytics.

-- Question 7- Consider a scenario where income is missing for many customers.
 -- How can this missingness itself provide business insights?
 
-- Answer-> Missing income data can provide business insights such as
-- (1) identifying customer segments that refuse to share financial info (privacy‑aware or low‑income groups),
-- (2) signaling data quality issues in specific regions or products,
-- (3) guiding targeted marketing or risk assessment strategies based on missingness patterns.

-- SECTION B-> PRACTICAL QUESTIONS

CREATE TABLE sales_dataa(
Customer_ID int primary key,
Name varchar(50),
City varchar(50),
Monthly_Sales decimal(10,2),
Income decimal(10,2),
Region varchar(50)
);
insert into sales_dataa (Customer_Id,Name,City,Monthly_Sales,Income,Region)
values
(101,'Rahul Mehta','Mumbai',12000,65000,'West'),
(102,'Anjali Rao','Bengluru',Null,Null,'South'),
(103,'Suresh Iyer','Chennai',15000,72000,'South'),
(104,'Neha Singh','Delhi',Null,Null,'North'),
(105,'Amit Verma','Pune',18000,58000,null),
(106,'Karan Shah','Ahemdabad',Null,61000,'West'),
(107,'Pooja Das','Kolkata',14000,Null,'East'),
(108,'Riya Kapoor','Jaipur',16000,69000,'North');


select * from sales_dataa;

-- Question 8- LISTWISE DELETION
-- Remove all rows where region are missing
-- TASKS
-- 1-> Idetify affected rows
-- 2-> Show the dataset after deletion
-- 3-> Mention how many records were lost

-- solution
 
  delete from sales_dataa
  where REgion is null;
  SET SQL_SAFE_UPDATES=0;

-- 1-> ONE ROW IS AFFECTED
-- 2->
 Select * from sales_dataa;
-- 3-> records lost-1 row (customer_id 105)

-- Question 9- IMPUTATION
-- Handel missing values in Monthly_sales using
-- FORWARD FILL
-- TASKS
-- apply forward fill
-- Show before vs after values
-- Explain why forward fill is suitable here

-- Solution
-- 1->
update sales_dataa
set Monthly_Sales=(
select prev_value
from(select Customer_ID,
    last_value(Monthly_Sales)over(order by Customer_ID
    rows  between unbounded preceding and 1 preceding
    )as prev_value
    from sales_dataa)as sub
    where sub.Customer_id=sales_dataa.Customer_ID
    )
    where Monthly_Sales is null;
 SET SQL_SAFE_UPDATES=0;
 
 -- 2->
 select * from sales_dataa;
 
 -- 3-> Forward fill assumes that the missing sales value is likely
 -- similar to the missing sales value is likely similar to the previous observation in the ordered sequence
 -- (e.g, time-ordered or id-ordered data). It is simple preserves the data pattern and is appropriate when missing
 -- values are due to data-entry gaps rather than random loss.
 
 -- Question 10 - Flagging Missing Data
 -- Create a flag column for missing Income
 -- TASKS
 -- 1-> Create Income_Missing_Flag(0=present,1=missing)
 -- 2-> Show updated dataset
 -- 3-> Count how many customers have missing income
 
 -- solutions
 -- 1->
 alter table sales_dataa add Income_missing_flag INT;
 update sales_dataa
 set Income_Missing_flag=case when Income is null then 1 else 0 end;

-- 2->
select * from sales_dataa;

-- 3->
select count(*) from sales_dataa where Income_missing_flag=1;











