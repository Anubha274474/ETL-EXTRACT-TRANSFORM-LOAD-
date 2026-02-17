-- TRANSFORMATION IN ETL (Assignment)

-- Question 1- Define Data Transformation in ETL and explain why it is important
-- answer
-- Data transformation in ETL is the process of converting,cleaning and structuring data from
-- source systems into a format suitable for analysis or loading into a target database/warehouse
-- It is important because it ensures data quality,consistency,and usability for downstream analytics and reporting

-- Question 2- List any four common activities involved in Data Cleaning
-- Four common Data Cleaning activities are
-- 1- Removing Duplicates
-- 2- Handling missing values
-- 3- Correcting incinsistent formats
-- 4- Outlier detection and treatment

-- Question 3- what is the difference between Normalization and Standardization?
-- Answer
-- Normalization- it scales data from 0-1 rannge(mmmmin-max scaling)
-- Standardization - It transforms data to have mean= 0 and standarddeviation=1(z score)


-- Question 4- A dataset has missing values in the age column suggest two techniquesto handel 
-- this andexplain when they should be used?

-- Answer- Two techniques to handel missing "age" values are
-- Imputation- replacing missing values with the median/mean age
-- Deletion- remove rows with missing age (used when missingness is random and few)

-- Question 5- Convert the following inconsistent "Gender" entries into standard format("Male,"Female"):
-- ["M","male","f","Female","Male","f"]

-- Answer
-- "M"->"Male"
-- "male"-> "Male"
-- "F"->"Female"
-- "Female"->"Female"
-- "Female"->"Male"
-- "Male"->"Male"
-- "f"->"Female"

-- result ["Male","Male","Female","Female","Male","Female"]

-- Question 6- What is one -hot encoding?Give an example with the categories:"RED","BLUE","GREEN"
-- SOLUTION
-- One-Hot Encoding converts caregorical variables into binary vectors
-- For categories "RED",BLUE","GREEN"
-- Red->[1,0,0]
-- Blue->[0,1,0]
-- Green->[0,0,1]

-- Question 7- Explain the difference between Data integration and Data Mapping in ETL
-- Answer
-- Data Integration-> It is combining data from multiple sources into a unified view. 
-- Data Mapping->It defines how source data fields are transformed and linked to 
-- target schema fields in the ETL process


-- Question 8-Explain why Z-score Standardization is preferred over Min-Max Scaling when outliers exist

-- Answer->  Z-score standardization is preferred over Min-Max scaling with outliers because
-- it centers data around zero with unit variance,reducing the influence of extreme values,whereas
-- Min-Max can squeeze normal value into a narrow range when outliners exist





















