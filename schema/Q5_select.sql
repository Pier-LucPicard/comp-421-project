\qecho Description of the statements used in the following queries:
\d Users
\d PartOf
\d Wall
\d Follows
\d Post
\qecho

/*
1)select users who are male and are part of at least 1 conversation
*/

\qecho
\qecho Output of first statement
\qecho

SELECT Users.email from Users where Users.gender ='m' intersect
SELECT email from PartOf LIMIT 50;

/* 
2)find the email of the oldest person living in Bafoussam city(aggregation and subquery)
*/

\qecho
\qecho Output of second statement
\qecho

SELECT Users.email from Users 
where Users.birthday = (SELECT min(birthday) from Users 
where Users.city = 'Bafoussam') and Users.city='Bafoussam' LIMIT 50;

/* 
3)select users who have more than 2 walls and live in a city that has more than 2 users 
*/

\qecho
\qecho Output of third statement
\qecho

SELECT Users.email from Users where Users.email 
in (SELECT Wall.email from Wall group by email having count(email) >2) 
and Users.city in (SELECT city from Users group by city having count(email)>2) LIMIT 50;

/* 
4)number of different people in each city grouped(grouping)
*/

\qecho
\qecho Output of fourth statement
\qecho

SELECT city,count(email) from Users group by city LIMIT 50;

/* 
5) select user who both followed and post on the wall of another user.
*/

\qecho
\qecho Output of fifth statement
\qecho

SELECT followed_by, follower from Follows intersect 
SELECT Post.email, Wall.email 
from Post, wall where Post.wall_id = Wall.wall_id LIMIT 50;
