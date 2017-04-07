--load the data from HDFS and define the schema
raw = LOAD '/data2/cl03.csv' USING PigStorage(',') AS  (date, type:chararray, parl:int, prov:chararray, riding:chararray, lastname:chararray, firstname:chararray, gender:chararray, occupation:chararray, party:chararray, votes:int, percent:double, elected:int);

--discard entries that have less than 60% of the votes
fltrd = FILTER raw by votes>=100;

won = FILTER fltrd by elected==1;

lost = FILTER fltrd by elected==0;

joined = JOIN won BY (date, type, parl, prov, riding), lost BY (date, type, parl, prov, riding);

gen = FOREACH joined GENERATE won::lastname AS winner_last_name:chararray, lost::lastname AS loser_last_name:chararray, (won::votes - lost::votes) AS vote_difference:int;

result = FILTER gen BY vote_difference<10;

STORE result INTO 'q2';
