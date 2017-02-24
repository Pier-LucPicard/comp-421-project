DROP VIEW IF EXISTS AgeCategoryStatistics;

/*
This view finds the age category of users (in leaps of 10 years), the number of people they follow and the number of messages they sent and their gender.
*/

CREATE VIEW AgeCategoryStatistics (age_category, gender, following, messages) AS SELECT floor(date_part('year', age(current_date, birthday))/10)*10 AS age_category,
gender, (SELECT COUNT(*) FROM Follows WHERE followed_by=email) AS following, (SELECT COUNT(*) FROM Message WHERE Message.email=Users.email) AS messages FROM Users;

/*
This query finds for each age-gender category the average number of messages sent, the average number of people followed by this category
and the size of the category.
*/

\qecho
\qecho Output of the first view query:
\qecho

SELECT age_category, gender, COUNT(*) as category_size, AVG(following) AS avg_following, AVG(messages) AS avg_messages FROM AgeCategoryStatistics GROUP BY age_category, gender ORDER BY age_category, gender;

DROP VIEW IF EXISTS Reactions;

/*
This view finds the number of reactions (comments and posts combined) of each type on each wall.
 */

CREATE VIEW Reactions(wall_id, type, count) AS SELECT Result.wall_id, Result.type, COUNT(*) FROM ((SELECT Wall.wall_id AS wall_id, PostReaction.type AS type, 0 AS flag FROM (Wall INNER JOIN Post ON Wall.wall_id=Post.Wall_id
INNER JOIN PostReaction ON PostReaction.pid=Post.pid))
UNION
(SELECT Wall.wall_id AS wall_id, CommentReaction.type AS type, 1 AS flag FROM (Wall INNER JOIN Post ON Wall.wall_id=Post.Wall_id
INNER JOIN Comment ON Comment.pid=Post.pid INNER JOIN CommentReaction ON CommentReaction.cid=Comment.cid))) AS Result GROUP BY wall_id, type;

/*
This query finds the average number of reaction types for each wall
 */

\qecho
\qecho Output of the second view query:
\qecho


SELECT type, AVG(count) AS wall_avg FROM Reactions GROUP BY type;



