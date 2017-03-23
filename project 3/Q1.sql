/*
This procedure scans every post, comment and message in the database and replaces offensive
words with placeholder dials (*). It then returns the list of the email of all users that
have written offensive texts.
*/
CREATE OR REPLACE FUNCTION filter_spam() RETURNS VARCHAR [] AS $$
DECLARE
	rec  RECORD; -- The current record
	-- The list of offensive term to filter
	terms VARCHAR [] :=ARRAY ['maths', 'database', 'comp421', 'sql', 'gpa', 'assignment', 'indexing', 'query'];
	flagged VARCHAR []=ARRAY[]::VARCHAR[]; -- The list of flagged users
	current VARCHAR; -- The current user being flagged
BEGIN
	-- Loop through each term
	FOR i IN 1 .. array_length(terms, 1) LOOP
		DECLARE ref REFCURSOR;
		BEGIN
			-- Open a cursor for posts that contain the offensive term
			OPEN ref FOR SELECT * FROM Post WHERE text LIKE concat('%', terms [i], '%');
			LOOP
				FETCH ref INTO rec;
				EXIT WHEN rec IS NULL;
				-- Replace the offensive term by dials
				WITH Temp AS(UPDATE Post SET text = replace(text, terms [i], repeat('*', character_length(terms[i]))) WHERE pid = rec.pid
				RETURNING email) SELECT email FROM Temp INTO current;
				-- Update the list of offensive users
				flagged:=array_append(flagged, current);
			END LOOP;
		END;
		DECLARE ref REFCURSOR;
		BEGIN
			-- Same approach as with Posts, but we have a cursor on comments instead
			OPEN ref FOR SELECT * FROM Comment WHERE text LIKE concat('%', terms [i], '%');
			LOOP
				FETCH ref INTO rec;
				EXIT WHEN rec IS NULL;
				-- Replace offensive term in comment
				WITH Temp AS(UPDATE Comment SET text = replace(text, terms [i], repeat('*', character_length(terms[i]))) WHERE cid = rec.cid
				RETURNING email) SELECT email FROM Temp INTO current;
				flagged:=array_append(flagged, current);
			END LOOP;
		END;
		DECLARE ref REFCURSOR;
		BEGIN
			-- Now we open a cursor for offensive messages, and do the same as before
			OPEN ref FOR SELECT * FROM Message WHERE content LIKE concat('%', terms [i], '%');
			LOOP
				FETCH ref INTO rec;
				EXIT WHEN rec IS NULL;
				WITH Temp AS(UPDATE Message SET content = replace(content, terms [i], repeat('*', character_length(terms[i]))) WHERE msg_id = rec.msg_id
				RETURNING email) SELECT email FROM Temp INTO current;
				flagged:=array_append(flagged, current); -- Update users
			END LOOP;
		END;
	END LOOP;
	-- The list of flagged users might contain duplicates, so we remove them
	flagged:=ARRAY(SELECT DISTINCT UNNEST(flagged) ORDER BY 1);
	RETURN flagged; -- return users
END;
$$ LANGUAGE plpgsql;

/*
This is an example usage of the procedure. It assumes that the data from project 2
is already loaded in the database (by running Q9_datagenerated.sql, which we have included in project 3 submission)
 */
DO language plpgsql $$
BEGIN
	-- First we run the filtering procedure (To ensure the database contains no offensive terms initially)
	PERFORM filter_spam();
	-- Then we insert some offensive words in the database
	INSERT INTO Comment (pid, email, text) VALUES (124, 'haloed-reason@yahoo.us', 'I Love comp421 and sql!');
	INSERT INTO Post (wall_id, email, text) VALUES (10, 'gray-pig@videotron.fr', 'I have a very good gpa');
	INSERT INTO Message (email, convo_id, content) VALUES ('possessive-noise@mac.us', 18, 'I finished my comp421 assignment.');
	RAISE NOTICE 'Before filtering %', ARRAY(SELECT text FROM ((SELECT text FROM Comment) UNION (SELECT text FROM Post) UNION (SELECT content AS text FROM Message)) Temp
	WHERE text ~ 'maths|database|comp421|sql|gpa|assignment|indexing|query');
  -- Filter the spam
  RAISE NOTICE 'The data has been filtered. The flagged users are : %', filter_spam();
	-- Display content of filtered  text
	RAISE NOTICE 'Value of inserted posts after filtering spam: %, %, %', (SELECT text FROM Comment WHERE cid=(SELECT currval('comment_cid_seq'))),
	(SELECT text FROM Post WHERE pid=(SELECT currval('post_pid_seq'))),(SELECT content FROM Message WHERE msg_id=(SELECT currval('message_msg_id_seq')));
END
$$;