/*
We also included some select statements to show the before/after of the update queries
 */

\qecho Relations used in the update statements are the same as in Q5
\qecho

/* 
1) For all male user live in Victoria city update their gender to female
*/

\qecho
\qecho Output of first statement
\qecho

\qecho Before (males living in Jamestown):
SELECT * FROM Users WHERE city = 'Jamestown' and gender ='m' LIMIT 5;

UPDATE users SET gender = 'f' where city = 'Jamestown' and gender ='m';

\qecho After (females living in Jamestown):
SELECT * FROM Users WHERE city = 'Jamestown' and gender ='f' LIMIT 5;

/* 
2) Update all user who has at least 2 walls and participate in at least 2 conversations birthday to '1972-02-02'
*/

\qecho
\qecho Output of second statement
\qecho

\qecho Before:
SELECT * FROM Users WHERE Users.email in
(SELECT email from Wall group by email having count(email)>1 intersect
SELECT email from PartOf group by email having count(email)>1) LIMIT 5;

UPDATE users SET birthday = '1972-02-02' where Users.email in 
(SELECT email from Wall group by email having count(email)>1 intersect
SELECT email from PartOf group by email having count(email)>1);

\qecho After:
SELECT * FROM Users WHERE Users.email in
(SELECT email from Wall group by email having count(email)>1 intersect
SELECT email from PartOf group by email having count(email)>1) LIMIT 5;

/* 
3) deleting all walls that have no post in them
*/

\qecho
\qecho Output of third statement
\qecho

\qecho Before:
SELECT * FROM Wall WHERE wall_id not in(SELECT wall_id from Post) LIMIT 5;

DELETE from Wall where wall_id not in(SELECT wall_id from Post);

\qecho After:
SELECT * FROM Wall WHERE wall_id not in(SELECT wall_id from Post) LIMIT 5;
/* 
4) create a wall I LOVE DATABASE for all users who has a wall
*/

\qecho
\qecho Output of fourth statement
\qecho

\qecho Before (walls with description I love database):
SELECT * FROM Wall WHERE descr='I love database' LIMIT 5;

INSERT INTO Wall (email, descr) SELECT derived.email AS email, 'I love database' as descr FROM (SELECT email from Users intersect SELECT email from Wall) AS derived;

\qecho After:
SELECT * FROM Wall WHERE descr='I love database' LIMIT 5;