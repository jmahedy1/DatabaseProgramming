/*
Partner 1: Jack Mahedy, Partner 2: Ethan Nie
CNIT 372 Lab 8, Group 17 
Estimated Time Spent: 1
Late Hours Used: 0
*/

--Question #QB1

CREATE OR REPLACE VIEW SUPERVISOR(SUPERVISORID, NUMBEROFEMPLOYEES) AS
    SELECT supervisor, COUNT(supervisor)
    FROM employee
    GROUP BY supervisor
    ORDER BY supervisor;
    
SELECT * 
FROM SUPERVISOR;

/* QB1 Query Results

View SUPERVISOR created.

SUPERVISOR NUMBEROFEMPLOYEES
---------- -----------------
100001                     2
100103                     2
100104                     3
100125                     3
100127                     2
100200                     2
100206                     1
100209                     4
100330                     2
100365                     3
100559                     5

SUPERVISOR NUMBEROFEMPLOYEES
---------- -----------------
100650                     2
100880                     3
100944                     5
                           0

15 rows selected.
*/



--Question #QB2

GRANT SELECT ON SUPERVISOR TO ENIE;

/* QB2 Query Results

Grant succeeded.
*/



--Question #QB4

INSERT INTO employee(employeeid, lastname, firstname, supervisor)
    VALUES('999999', 'Jack', 'Mahedy', '100206');

/* QB4 Query Results

1 row inserted.
*/



--Question #QB5

SELECT *
FROM SUPERVISOR;

/* QB5 Query Results

I do see the new employee in the supervisor view. Views are dynamic, so since I 
inserted a new row into the employee table, once the view is queried again the 
changes will be reflected.

SUPERVISOR NUMBEROFEMPLOYEES
---------- -----------------
100001                     2
100103                     2
100104                     3
100125                     3
100127                     2
100200                     2
100206                     2
100209                     4
100330                     2
100365                     3
100559                     5

SUPERVISOR NUMBEROFEMPLOYEES
---------- -----------------
100650                     2
100880                     3
100944                     5
                           0

15 rows selected.
*/



--Question #QB7

COMMIT;

/* QB7 Query Results

Commit complete.
*/



--Question #QB9

DELETE FROM employee
WHERE employeeid LIKE '999999';

/* QB9 Query Results

1 row deleted.
*/



--Question #QB10

SELECT *
FROM SUPERVISOR;

/* QB10 Query Results

The employee gets deleted and I only see one employee for that supervisor. 
Which is what it was originally. Again, views are dynamic so when changes get made to
the table and the view is queried again the changes will be seen.

SUPERVISOR NUMBEROFEMPLOYEES
---------- -----------------
100001                     2
100103                     2
100104                     3
100125                     3
100127                     2
100200                     2
100206                     1
100209                     4
100330                     2
100365                     3
100559                     5

SUPERVISOR NUMBEROFEMPLOYEES
---------- -----------------
100650                     2
100880                     3
100944                     5
                           0

15 rows selected.
*/



--Question #QB12

REVOKE SELECT ON SUPERVISOR FROM ENIE;

/* QB12 Query Results

Revoke succeeded.
*/



--Question #QB14

DROP VIEW SUPERVISOR;

/* QB14 Query Results

View SUPERVISOR dropped.
*/



/* Question QB15
The privilege we are lacking is the CREATE MATERIALIZE VIEW privilege. We are not
provided this privilege becasue the materialize view creates a database object. If 
you were to create many materialize views it would cost more on the database and be 
more taxing on the database.

https://docs.snowflake.com/en/user-guide/views-materialized.html#:~:text=Materialized%20views%20are%20designed%20to,intermediate%20results%20incurs%20additional%20costs.
*/



/*Question #QB16
The privilege we are lacking is the CREATE ROLE privilege. We do not have this 
privilege becasue we do not want to be able to give access to other people. If a 
rouge student gives access to his friend, the friend might mess with the database.
If students were given CREATE ROLL privileges, they can make external rolls which
makes the database open to everyone and vulnerable.
*/