/*
We did not insert city and location for these users, as they are optional (they can be null), and since they are
external keys we would need to make sure they match the entries in the location table, but this question asked to
insert in only one relation.
 */

INSERT INTO Users(email, first_name, last_name, birthday, password, gender)
VALUES ('john@gmail.com', 'John', 'James', '1990-01-16', 'secretpass', 'm');
INSERT INTO Users(email, first_name, last_name, birthday, password, gender)
VALUES ('bob@hotmail.com', 'Bob', 'Loblaw', '1985-04-04', '5145145144', 'm');
INSERT INTO Users(email, first_name, last_name, birthday, password, gender)
VALUES ('maryjane@hotmail.com', 'Mary', 'Jane', '1969-10-10', 'programmer123', 'f');
INSERT INTO Users(email, first_name, last_name, birthday, password, gender)
VALUES ('eva@mail.mcgill.ca', 'Eva', 'Underwood', '1980-05-08', 'qwerty123', 'f');
INSERT INTO Users(email, first_name, last_name, birthday, password, gender)
VALUES ('mememaster@gmail.com', 'Gabe', 'Newell', '1962-11-03', 'gaben', 'm');