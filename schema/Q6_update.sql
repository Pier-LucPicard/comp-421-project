\qecho Relations used in the update statements are the same as in Q5
\qecho

/* 
1) For all male user live in Victoria city update their gender to female
*/

\qecho
\qecho Output of first statement
\qecho

UPDATE users SET gender = 'f' where city = 'Victoria' and gender ='m';

/* 
2) Update all user who has at least 2 walls and participate in at least 2 conversations birthday to '1972-02-02'
*/

\qecho
\qecho Output of second statement
\qecho

UPDATE users SET birthday = '1972-02-02' where Users.email in 
(SELECT email from Wall group by email having count(email)>1 intersect
SELECT email from PartOf group by email having count(email)>1);

/* 
3) deleting all walls that have no post in them
*/

\qecho
\qecho Output of third statement
\qecho

DELETE from Wall where wall_id not in(SELECT wall_id from Post);


/* 
4) create a wall I LOVE DATABASE for all users who has a wall
*/

\qecho
\qecho Output of fourth statement
\qecho

INSERT INTO Wall (email, descr) SELECT derived.email AS email, 'I love database' as descr FROM (SELECT email from Users intersect SELECT email from Wall) AS derived;