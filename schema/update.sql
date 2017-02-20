
/* 
1) For all male user live in Victoria city update their gender to female
*/

UPDATE users SET gender = 'f' where city = 'Victoria' and gender ='m';

/* 
2) Update all user who has at least 2 walls and participate in at least 2 conversations birthday to '1972-02-02'
*/

UPDATE users SET birthday = '1972-02-02' where Users.email in 
(SELECT email from Wall group by email having count(email)>1 intersect
SELECT email from PartOf group by email having count(email)>1);

/* 
3) deleting all walls that have no post in them
*/

DELETE from Wall where wall_id not in(SELECT wall_id from Post);


/* 
4) create a wall I LOVE DATABASE for all users who has a wall
*/

INSERT INTO Wall (wall_id, descr,email)
SELECT (SELECT MAX(wall_id)+1 FROM Wall), 'I love database', email
FROM   Users
WHERE  Users.email in (SELECT Users.email from Users intersect SELECT email from Wall);


