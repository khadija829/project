-- Log of Errors and How They Were Solved


-- ERROR 1: Incorrect syntax near 'LIMIT'.
-- The problem: I used `LIMIT 1` in the `Admin Perspective, Challenge 6` query, which is valid for MySQL but not for my SQL Server environment.
-- The error message received was: `Msg 102, Level 15, State 1, Line 191 Incorrect syntax near 'LIMIT'.`
-- The solution: I replaced `LIMIT 1` with `SELECT TOP 1`, which is the correct syntax for SQL Server, to select the top row after ordering the results.

-- ERROR 2: FOREIGN KEY constraint violation.
-- The problem: When inserting a new schedule (Admin Perspective, Challenge 2), I initially tried to use trainer_id = 99.
-- The error message was similar to: `The INSERT statement conflicted with the FOREIGN KEY constraint...`
-- The reason: The `trainer_id` I tried to insert (99) did not exist as a `PRIMARY KEY` in the Trainer table.
-- The solution: I checked the `Trainer` table and used a valid ID, `trainer_id = 3`, to ensure the foreign key constraint was not violated.

-- ERROR 3: No results found due to incorrect filter value.
-- The problem: In `Admin Perspective, Challenge 5`, I wanted to find trainees in "Data Basics". My query was `WHERE c.title = 'Data Basics'.
-- The result: The query returned an empty set because a course with that exact title did not exist in the `Course` table.
-- The solution: I reviewed the inserted data and found the correct course title was 'Database Fundamentals'. I also added a new course 'Networking' and used that for the query.

-- ERROR 4: Invalid column name or spelling error.
-- The problem: While creating the (Schedule) table or writing a query, I made a typo, for example, using STRAT_DATE instead of start_date or c.courseid instead of c.course_id.
-- The error message was: `Invalid column name 'STRAT_DATE'.`
-- The solution: I carefully reviewed my table schema and corrected the column name to match the correct spelling (start_date, course_id) to ensure the database could find the columns.
