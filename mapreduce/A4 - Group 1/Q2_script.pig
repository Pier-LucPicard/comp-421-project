--load the data from HDFS and define the schema
raw = LOAD '/data2/cl03.csv' USING PigStorage(',') AS  (date, type:chararray, parl:int, prov:chararray, riding:chararray, lastname:chararray, firstname:chararray, gender:chararray, occupation:chararray, party:chararray, votes:int, percent:double, elected:int);

--discard entries that have less than 100 votes
fltrd = FILTER raw by votes>=100;

-- Find the winners
won = FILTER fltrd by elected==1;

-- Find the losers
lost = FILTER fltrd by elected==0;

-- Join the winners and the losers
joined = JOIN won BY (date, type, parl, prov, riding), lost BY (date, type, parl, prov, riding) PARALLEL 4;

-- Keep winner's name, loser's name and the vote difference
gen = FOREACH joined GENERATE won::lastname AS winner_last_name:chararray, lost::lastname AS loser_last_name:chararray, (won::votes - lost::votes) AS vote_difference:int;

-- only keep rows that have a vote difference less than 10
result = FILTER gen BY vote_difference<10;

-- Store on HDFS
STORE result INTO 'q2';
