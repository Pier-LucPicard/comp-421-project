--load the data from HDFS and define the schema
raw = LOAD '/data2/cl03.csv' USING PigStorage(',') AS  (date, type:chararray, parl:int, prov:chararray, riding:chararray, lastname:chararray, firstname:chararray, gender:chararray, occupation:chararray, party:chararray, votes:int, percent:double, elected:int);

-- select parl and party from raw
parln= foreach raw generate parl, party; 

--group by parliament then by party
grouped1 = group parln by  (parl, party);

-- get parliament number, party name  and the number of MPs in  each party with each parliament
counted1 = FOREACH grouped1 GENERATE group.parl AS parl, group.party AS party, COUNT(parln.party) AS count;

--group by parliament 
grouped2 = group parln by  (parl);

-- get parliament number and the total number of MPs in all the parliaments
counted2 = FOREACH grouped2 GENERATE group AS parl, COUNT(parln.parl) AS count;

-- join by parliament number 
counted3 = JOIN counted1 BY parl, counted2 BY parl;

-- get parliament number, party name, number of MPs in each party with each parliament and the total number of MPs in all the parliaments
result = FOREACH counted3 GENERATE counted1::parl As parl, counted1::party As party, counted1::count AS num_mp_party, counted2::count As num_mp_parl; 

-- save the result into a csv file named q4.csv
STORE result INTO 'q4.csv' USING PigStorage(',');