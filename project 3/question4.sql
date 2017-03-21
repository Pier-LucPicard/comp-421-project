\qecho Output of analyze:
ANALYZE Message;
\qecho
\qecho Output of explain:
EXPLAIN SELECT * FROM Message;
\qecho
\qecho Output of delete:
DELETE FROM Message WHERE msg_id<=10;
\qecho
\qecho Output of explain (before updating the table statistics):
EXPLAIN SELECT * FROM Message;
\qecho
\qecho Ouput of analyze:
ANALYZE Message;
\qecho
\qecho Output of explain (after updating the table statistics):
EXPLAIN SELECT * FROM Message;