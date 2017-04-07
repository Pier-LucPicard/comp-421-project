--load the data from HDFS and define the schema
raw = LOAD '/data2/cl03.csv' USING PigStorage(',') AS  (date, type:chararray, parl:int, prov:chararray, riding:chararray, lastname:chararray, firstname:chararray, gender:chararray, occupation:chararray, party:chararray, votes:int, percent:double, elected:int);

-- Get the winners
elected = FILTER raw BY elected==1;

-- Group the winners by parlement
grouped = GROUP elected BY parl;

-- Count the number of entries in each group
counted = FOREACH grouped GENERATE group AS parl, COUNT(elected.parl) AS count;

-- Create a duplicate table that also contains a fielf with the previous parlement number
duplicate = FOREACH counted GENERATE *, (parl-1) AS prevparl;

-- Join this duplicate table on previous parlement number with the other table on parlement number.
-- After the tuple for each parlement will be joined with the tuple from the previous parlement
joined = JOIN duplicate BY prevparl, counted BY parl;

-- Calculate the difference in count between the parlement and the previous parlement
diff = FOREACH joined GENERATE duplicate::parl AS parl, (duplicate::count - counted::count) AS difference;

-- Order the tuples by parlement
ordered = ORDER diff BY parl;

-- Dump the results
DUMP ordered;