COMMIT;
CREATE OR REPLACE FUNCTION filter_spam() RETURNS void AS $$
    DECLARE
      test RECORD;
      terms varchar []:=ARRAY['fuck', 'noob'];
      term varchar;
    BEGIN
      FOR i IN 1 .. array_length(terms, 1) LOOP
          DECLARE ref refcursor;
        BEGIN
           OPEN ref FOR SELECT * FROM Post WHERE text LIKE concat('%', terms[i], '%');
          RAISE NOTICE 'The current value of counter in the subblock is %', terms[i];
            LOOP
                FETCH ref INTO test;
                EXIT WHEN test IS NULL;
                UPDATE Post SET text=replace(text, terms[i], repeat('*', character_length(terms[i]))) WHERE pid=test.pid;
            END LOOP;
          END;
      END LOOP;
    END;
$$ LANGUAGE plpgsql;
BEGIN;
SELECT filter_spam();
COMMIT;