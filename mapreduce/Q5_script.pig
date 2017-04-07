--load the data from HDFS and define the schema
raw = LOAD '/data2/emp.csv' USING PigStorage(',') AS (empid:int, fname:chararray, lname:chararray, deptname:chararray, isManager:chararray, mgrid:int, salary:int);

managers = FILTER raw BY isManager == 'Y' AND deptname == 'Finance';

employees = GROUP raw BY mgrid;

counted = FOREACH employees GENERATE group, COUNT(raw.empid) AS numEmployees;

joined = JOIN managers BY empid LEFT OUTER, counted BY group;

filtered = FOREACH joined GENERATE managers::empid AS empid, managers::lname AS lname, counted::numEmployees AS numEmployees;

STORE filtered INTO 'q5';




