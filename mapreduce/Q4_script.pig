raw = LOAD '/data2/cl03.csv' USING PigStorage(',') AS  (date, type:chararray, parl:int, prov:chararray, riding:chararray, lastname:chararray, firstname:chararray, gender:chararray, occupation:chararray, party:chararray, votes:int, percent:double, elected:int);

parln= foreach raw generate parl, party; 

grouped1 = group parln by  (parl, party);

counted1 = FOREACH grouped1 GENERATE group.parl AS parl, group.party AS party, COUNT(parln.party) AS count;

grouped2 = group parln by  (parl);

counted2 = FOREACH grouped2 GENERATE group AS parl, COUNT(parln.parl) AS count;

counted3 = JOIN counted1 BY parl, counted2 BY parl;

result = FOREACH counted3 GENERATE counted1::parl As parl, counted1::party As party, counted1::count AS num_mp_party, counted2::count As num_mp_parl; 


STORE result INTO 'q4.csv' USING PigStorage(',');