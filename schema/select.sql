/* 
1)select users who are male and are part of at least 1 conversation
*/

SELECT Users.email from Users where Users.gender ='m' intersect SELECT email from PartOf;

/* 
2)find the email of the oldest person living in Bafoussam city(aggregation and subquery)
*/

SELECT Users.email from Users where Users.birthday = (SELECT min(birthday) from Users where Users.city = 'Bafoussam') and Users.city='Bafoussam';

/* 
3)select users who have more than 2 walls and live in a city that has more than 2 users 
*/

SELECT Users.email from Users where Users.email in (SELECT Wall.email from Wall group by email having count(email) >2) and Users.city in (SELECT city from Users group by city having count(email)>2);

/* 
4)number of different people in each city grouped(grouping)
*/

SELECT city,count(email) from Users group by city;

/* 
5) select user who both followed and post on the wall of another user.
*/

SELECT followed_by, follower from Follows intersect SELECT Post.email, Wall.email from Post, wall where Post.wall_id = Wall.wall_id; 
