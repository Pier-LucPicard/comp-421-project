/*
Try to update the first
 */

UPDATE AgeCategoryStatistics SET age_category=20;

/*
It produces the following error:
[2017-02-23 21:12:50] [0A000] Batch entry 0 UPDATE AgeCategoryStatistics SET age_category=20 was aborted.  Call getNextException to see the cause.
[2017-02-23 21:12:50] [0A000] ERROR: cannot update column "age_category" of view "agecategorystatistics"
[2017-02-23 21:12:50] Detail: View columns that are not columns of their base relation are not updatable.
This views that contains fields not part of their base relations (in this case age_category is not part of User, Following or Message)
may not be updated
 */

/*
Try to update the second view
 */

UPDATE Reactions SET count=0;

/*
It produces the following error:
[2017-02-23 21:13:33] [55000] ERROR: cannot update view "reactions"
[2017-02-23 21:13:33] Detail: Views containing GROUP BY are not automatically updatable.
[2017-02-23 21:13:33] Hint: To enable updating the view, provide an INSTEAD OF UPDATE trigger or an unconditional ON UPDATE DO INSTEAD rule.

This is because we can only update views that do not contain grouped elements (group by clause).
 */

/*
So to summarize, we cannot update views if the changes cannot reflect on the base relations, and we would need to use
a CREATE RULE and DO INSTEAD statement so that any update statement made to the view would be reflected on
the base relations that view uses.
 */
