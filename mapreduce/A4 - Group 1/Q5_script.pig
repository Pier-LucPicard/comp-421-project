--load the data from HDFS and define the schema
raw = LOAD '/data2/emp.csv' USING PigStorage(',') AS (empid:int, fname:chararray, lname:chararray, deptname:chararray, isManager:chararray, mgrid:int, salary:int);

-- Find the finance managers
managers = FILTER raw BY isManager == 'Y' AND deptname == 'Finance';

-- Group the employees according to their manager
employees = GROUP raw BY mgrid;

-- Find the number of employees for each manager
counted = FOREACH employees GENERATE group, COUNT(raw.empid) AS numEmployees;

-- Join the managers to the group of employees they manage
joined = JOIN managers BY empid, counted BY group;

-- Keep the manager's empid, last name and number of employees
filtered = FOREACH joined GENERATE managers::empid AS empid, managers::lname AS lname, counted::numEmployees AS numEmployees;

-- Store on HDFS
STORE filtered INTO 'q5';




