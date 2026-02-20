-- Data Loading (Assignment)
-- Dataset

-- Question 1- Data Understanding
-- Identify all data Quality issues present in the dataset that can cause
-- problems during data loading. 

-- Answer--  Data quality issues that can cause probles during loading are-
-- 1-> Columns values are not defined correctly (e.g  where it should be int its written may be as varchar which is incorrect
-- 2-> In Sales_Amount column there is an error it should be in int formate but at some places it is written as charachters
-- which is not a right practice
-- 3-> Order_Date column is also not defined as a single formate its changing frequently which also can
--  cause problem at the time of data loading

-- Question 2- Primary Key Validation
-- Assume Order_ID is the Primary key rule?
-- a) is the dataset violating the primary key rule?
-- b) Which records(s) cause the violation?

-- Answer
-- a) a) Yes, the dataset violates the Primary Key rule because Order_ID is not unique.
-- b) The violating records are the two rows with Order_ID = O101.

-- Q3.  Missing Value Analysis
-- a. Which column(s) contain missing values?
-- b. List the affected records.
-- c. Explain why loading these records without handling missing values is risky.

-- Answer-Missing Value Analysis
-- a) The affected record is O102 (Sales_Amount is Null).
-- b) Loading records with missing values can cause inaccurate aggregations, 
-- incomplete analysis, and potential errors in calculations or downstream processes.

-- Q4. Data Type Validation
-- a. Identify records where Sales_Amount violates expected data type rules.
-- b. Which record(s) will fail numeric validation?
-- c. What would happen if this dataset is loaded into a SQL table with Sales_Amount as DECIMAL?

-- Answer
--  Data Type Validation
-- a) The record that fails numeric validation is O104 (“Three Thousand”).
-- b) Loading this into a DECIMAL column would trigger a data‑type conversion 
-- error, causing the load to fail or the value to be rejected.

-- Q5. 5. Date Format Consistency
-- a. List all date formats present in the Order_Date column.
-- b. Why is this a problem during data loading?

-- Answer-Date Format Consistency
-- a) The date formats present are DD-MM-YYYY (12-01-2024, 15-01-2024,
--  20-01-2024, 25-01-2024) and YYYY/MM/DD (2024/01/18).
-- b) Inconsistent formats can lead to parsing errors or misinterpretation
--  of dates during loading, affecting sorting and date‑based analysis.


-- Q6. 6. Load Readiness Decision
-- a. Should this dataset be loaded directly into the database? (Yes/No)
-- b. Justify your answer with at least three reasons.

-- Answer-Load Readiness Decision
-- a) No, this dataset should not be loaded directly.
-- b) Reasons:
-- 1. Primary Key violation will cause integrity issues.
-- 2. Data‑type mismatches can break the load process.
-- 3. Missing/inconsistent values will distort analytics.


-- Q7. 7. Pre-Load Validation Checklist
    -- List the exact pre-load validation checks you would perform on this dataset before loading.

-- Answer- Pre‑Load Validation Checklist
-- 1. Check uniqueness of Order_ID.
-- 2. Verify Sales_Amount for numeric format & completeness.
-- 3. Standardize Order_Date to a single format.
-- 4. Detect and handle missing values.
-- 5. Confirm data type compliance for all columns.

-- Q8.8. Cleaning Strategy
    -- Describe the step-by-step cleaning actions required to make this dataset load-ready.
 
-- Answer- Cleaning Strategy
-- 1. Remove or merge duplicate Order_ID entries (e.g., aggregate Sales_Amount).
-- 2. Impute or flag the missing Sales_Amount (Null for O102).
-- 3. Convert non‑numeric “Three Thousand” to 3000.
-- 4. Standardize all Order_Date values to YYYY-MM-DD format.
-- 5. Validate data types again after transformations.

-- Q9. 9. Loading Strategy Selection
-- a. Should a Full Load or Incremental Load be used for this daily sales data?
-- b. Justify your choice.

-- Answer-Loading Strategy Selection
-- a) Incremental Load should be used for daily sales data.
-- b) Justification: Incremental loading updates only new/changed records, 
-- reduces processing time, and helps maintain data integrity for ongoing daily transactions.

-- Q10.10. BI Impact Scenario
-- a. What incorrect results might appear in Total Sales KPI if the dataset was loaded without cleaning?
-- b. Which records specifically would cause misleading insights?
-- c. Why would BI tools not detect these issues automatically?

-- Answer- BI Impact Scenario
-- a) Total Sales KPI would be incorrect due to missing values (Null treated as zero) 
-- and non‑numeric text being excluded or causing errors.

-- b) Misleading records are O102 (Null sales) and O104 (non‑numeric amount),
--  plus duplicate O101 inflating totals.

-- c) BI tools may not detect these automatically because they assume numeric 
-- aggregation and may silently skip invalid values, hiding data quality issues.











