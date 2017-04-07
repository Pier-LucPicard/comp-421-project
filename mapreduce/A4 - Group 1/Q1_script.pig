--load the data from HDFS and define the schema
raw = LOAD '/data2/cl03.csv' USING PigStorage(',') AS  (date, type:chararray, parl:int, prov:chararray, riding:chararray, lastname:chararray, firstname:chararray, gender:chararray, occupation:chararray, party:chararray, votes:int, percent:double, elected:int);

--discard entries that have less than 60% of the votes
fltrd = FILTER raw by percent>=60.0;

--keep only the candidate names
gen = foreach fltrd generate CONCAT(firstname, CONCAT(' ', lastname));

--remove duplicate names
q1 = DISTINCT gen;

--store the results
STORE q1 INTO 'q1';
