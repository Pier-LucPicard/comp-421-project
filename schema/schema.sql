
/* It is impossible for an email to contain more than 320 characters */
CREATE TABLE Users(
  email VARCHAR(320) PRIMARY KEY CHECK (email ~ '^[a-zA-Z0-9\-.]+@[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-.]+$'),
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  birthday DATE NOT NULL,
  password VARCHAR(20) NOT NULL,
  gender VARCHAR(1) NOT NULL CHECK (gender='m' OR gender='f')
);
CREATE TABLE Conversation(
  convo_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);
CREATE TABLE Message(
  msg_id SERIAL PRIMARY KEY,
  email VARCHAR(320) REFERENCES Users(email),
  convo_id SERIAL REFERENCES Conversation(convo_id),
  time TIMESTAMP DEFAULT current_timestamp NOT NULL,
  content VARCHAR(2000) NOT NULL
);
/* Wall description is not required, permissions are stored as numbered values */
CREATE TABLE Wall(
  wall_id SERIAL PRIMARY KEY,
  descr VARCHAR(500),
  permission SMALLINT DEFAULT 0 NOT NULL,
  email VARCHAR(320) REFERENCES Users(email)
);
CREATE TABLE Post(
  pid SERIAL PRIMARY KEY,
  wall_id SERIAL REFERENCES Wall(wall_id),
  email VARCHAR(320) REFERENCES Users(email),
  date TIMESTAMP DEFAULT current_timestamp NOT NULL,
  text VARCHAR(2000) NOT NULL,
  url VARCHAR(2000)
);
CREATE TABLE Comment(
  cid SERIAL PRIMARY KEY,
  pid SERIAL REFERENCES Post(pid),
  email VARCHAR(320) REFERENCES Users(email),
  text TEXT NOT NULL,
  time TIMESTAMP DEFAULT current_timestamp NOT NULL
);
CREATE TABLE Location(
  city VARCHAR(50) NOT NULL,
  country VARCHAR(50) NOT NULL,
  PRIMARY KEY (city, country)
);
/*
Description is not required. Phone numbers are stored as characters, we chose a length
of 20 because it seemed reasonable. There are no phone numbers with more than 20 characters.
 */
CREATE TABLE Organization(
  org_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description VARCHAR(500),
  phone_number VARCHAR(20) NOT NULL,
  address VARCHAR(100) NOT NULL,
  city VARCHAR(50),
  country VARCHAR(50),
  FOREIGN KEY (city, country) REFERENCES Location(city, country)
);
CREATE TABLE School(
  org_id SERIAL REFERENCES Organization(org_id) PRIMARY KEY
);
CREATE TABLE Workplace(
  org_id SERIAL REFERENCES Organization(org_id) PRIMARY KEY
);
CREATE TABLE CommentReaction(
  cid SERIAL REFERENCES Comment(cid),
  email VARCHAR(320) REFERENCES Users(email),
  type VARCHAR(7) CHECK (type IN ('angry', 'happy', 'sad', 'like', 'excited')),
  PRIMARY KEY (cid, email)
);
CREATE TABLE PostReaction(
  pid SERIAL REFERENCES Post(pid),
  email VARCHAR(320) REFERENCES Users(email),
  type VARCHAR(7) CHECK (type IN ('angry', 'happy', 'sad', 'like', 'excited')),
  PRIMARY KEY (pid, email)
);
CREATE TABLE Follows(
  follower VARCHAR(320) REFERENCES Users(email),
  followed_by VARCHAR(320) REFERENCES Users(email),
  since TIMESTAMP DEFAULT current_timestamp NOT NULL
);
CREATE TABLE PartOf(
  email VARCHAR(320) REFERENCES Users(email),
  convo_id SERIAL REFERENCES Conversation(convo_id),
  PRIMARY KEY (email, convo_id)
);
CREATE TABLE WorkPeriod(
  email VARCHAR(320) PRIMARY KEY REFERENCES Users(email),
  org_id SERIAL REFERENCES Workplace(org_id),
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  job_title VARCHAR(100) NOT NULL,
  CHECK (from_date <= to_date)
);
CREATE TABLE StudyPeriod(
  email VARCHAR(320) PRIMARY KEY REFERENCES Users(email),
  org_id SERIAL REFERENCES School(org_id),
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  edu_level VARCHAR(100) NOT NULL,
  CHECK (from_date <= to_date)
);
