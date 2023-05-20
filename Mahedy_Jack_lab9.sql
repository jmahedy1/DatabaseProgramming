/*
Jack Mahedy
CNIT 372 Lab section 007
Estimated Time Spent: 2
Late Hours Used: 0
*/

--Question #1a

SET SERVEROUTPUT ON;

DROP TABLE LAB9_EMPLOYEE;

CREATE TABLE LAB9_EMPLOYEE AS SELECT * FROM EMPLOYEE;

/* Q1a Query Results

Table LAB9_EMPLOYEE created.
*/



--Question #1b

CREATE OR REPLACE TRIGGER TBDS_LAB9_EMPLOYEE
    BEFORE DELETE ON LAB9_EMPLOYEE
BEGIN
    dbms_output.put_line('Trigger fired before deleting anything from LAB9_EMPLOYEE');
END;

/* Q1b Query Results

Trigger TBDS_LAB9_EMPLOYEE compiled

The database object the trigger is defined on is TBDS_LAB9_EMPLOYEE. 
The trigger will fire once before data is deleted on the table.
*/



--Question #1c

CREATE OR REPLACE TRIGGER TBDR_LAB9_EMPLOYEE
    BEFORE DELETE ON LAB9_EMPLOYEE
    FOR EACH ROW
BEGIN
    dbms_output.put_line('Trigger fired before deleting a row from LAB9_EMPLOYEE');
END;

/* Q1c Query Results

Trigger TBDR_LAB9_EMPLOYEE compiled

The database object the trigger is defined on is TBDR_LAB9_EMPLOYEE. 
The trigger will fire before each row of data is deleted from the table.
*/



--Question #1d

CREATE OR REPLACE TRIGGER TADS_LAB9_EMPLOYEE
    AFTER DELETE ON LAB9_EMPLOYEE
BEGIN
    dbms_output.put_line('Trigger fired after deleting anything from LAB9_EMPLOYEE');
END;

/* Q1d Query Results

Trigger TADS_LAB9_EMPLOYEE compiled

The database object the trigger is defined on is TADS_LAB9_EMPLOYEE. 
The trigger will fire once after data is deleted from the table.
*/



--Question #1e

CREATE OR REPLACE TRIGGER TADR_LAB9_EMPLOYEE
    AFTER DELETE ON LAB9_EMPLOYEE
    FOR EACH ROW
BEGIN
    dbms_output.put_line('Trigger fired after deleting a row from LAB9_EMPLOYEE');
END;

/* Q1e Query Results

Trigger TADR_LAB9_EMPLOYEE compiled

The database object the trigger is defined on is TADR_LAB9_EMPLOYEE. 
The trigger will fire after each row of data is deleted from the table.
*/



--Question #1f

DELETE FROM LAB9_EMPLOYEE
WHERE employeeid LIKE '101135';

/* Q1f Query Results

Trigger fired before deleting anything from LAB9_EMPLOYEE
Trigger fired before deleting a row from LAB9_EMPLOYEE
Trigger fired after deleting a row from LAB9_EMPLOYEE
Trigger fired after deleting anything from LAB9_EMPLOYEE

1 row deleted.

All four of the triggers fired. Each trigger fired once. Order was before anything,
before a row, after a row, and after anything (TBDS, TBDR, TADS, TADR).
*/



--Question #1g

ROLLBACK;

SELECT COUNT(employeeid)
FROM LAB9_EMPLOYEE
WHERE employeeid LIKE '101135';

/* Q1g Query Results

The data is restored. Trigger execution does not implicitly perform a commit.

Rollback complete.

COUNT(EMPLOYEEID)
-----------------
                1
*/



--Question #1h

DELETE FROM LAB9_EMPLOYEE
WHERE jobtitle LIKE 'Sales';

/* Q1h Query Results

All four triggers fired. Trigger before anything is deleted fired once at the begining. 
Trigger before a is deleted row fired three times, once for every row. Trigger after a 
deleted row fired 3 times once for every row. Trigger after anything is deleted fired once 
and was last. Trigger before/after a row is deleted alternated before the last trigger.

Trigger fired before deleting anything from LAB9_EMPLOYEE
Trigger fired before deleting a row from LAB9_EMPLOYEE
Trigger fired after deleting a row from LAB9_EMPLOYEE
Trigger fired before deleting a row from LAB9_EMPLOYEE
Trigger fired after deleting a row from LAB9_EMPLOYEE
Trigger fired before deleting a row from LAB9_EMPLOYEE
Trigger fired after deleting a row from LAB9_EMPLOYEE
Trigger fired after deleting anything from LAB9_EMPLOYEE


3 rows deleted.
*/



--Question #1i

ROLLBACK;

SELECT COUNT(employeeid)
FROM LAB9_EMPLOYEE
WHERE jobtitle LIKE 'Sales';

/* Q1i Query Results

The data is restored. I expected this to happen, this problem is very similar to 
the previous problem.

Rollback complete.

COUNT(EMPLOYEEID)
-----------------
                3
*/



--Question #1j

TRUNCATE TABLE LAB9_EMPLOYEE;

/* Q1j Query Results

None of the triggers fired. 

Table LAB9_EMPLOYEE truncated.
*/



--Question #2a

CREATE OR REPLACE TRIGGER ONCE_BEFORE_LAB9_EMPLOYEE
    BEFORE INSERT ON LAB9_EMPLOYEE
BEGIN
    dbms_output.put_line('Trigger fired before inserting anything into LAB9_EMPLOYEE');
END;


CREATE OR REPLACE TRIGGER BEFORE_EACH_LAB9_EMPLOYEE
    BEFORE INSERT ON LAB9_EMPLOYEE
    FOR EACH ROW
BEGIN
    dbms_output.put_line('Trigger fired before inserting a row into LAB9_EMPLOYEE');
END;


CREATE OR REPLACE TRIGGER ONCE_AFTER_LAB9_EMPLOYEE
    AFTER INSERT ON LAB9_EMPLOYEE
BEGIN
    dbms_output.put_line('Trigger fired after inserting anything into LAB9_EMPLOYEE');
END;


CREATE OR REPLACE TRIGGER AFTER_EACH_LAB9_EMPLOYEE
    AFTER INSERT ON LAB9_EMPLOYEE
    FOR EACH ROW
BEGIN
    dbms_output.put_line('Trigger fired after inserting a row into LAB9_EMPLOYEE');
END;

/* Q2a Query Results

Trigger ONCE_BEFORE_LAB9_EMPLOYEE compiled

Trigger BEFORE_EACH_LAB9_EMPLOYEE compiled

Trigger ONCE_AFTER_LAB9_EMPLOYEE compiled

Trigger AFTER_EACH_LAB9_EMPLOYEE compiled
*/



/* Question #2b
I expect all four triggers to fire once if 1 row of data is inserted. 
ONCE_BEFORE_LAB9_EMPLOYEE trigger will fire first.
BEFORE_EACH_LAB9_EMPLOYEE trigger will fire next. 
ONCE_AFTER_LAB9_EMPLOYEE trigger will fire next.
AFTER_EACH_LAB9_EMPLOYEE trigger will fire last.
*/



--Question #2c

INSERT INTO LAB9_EMPLOYEE(employeeid, lastname, firstname)
    VALUES('999999', 'Mahedy', 'Jack');

/* Q2c Query Results

My hypothesis was correct.

Trigger fired before inserting anything into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting anything into LAB9_EMPLOYEE

1 row inserted.
*/



/* Question #2d
I expect all of the triggers to fire. I think there will be a total of 82 triggers fired.
Trigger before anything will be first and fire once. Then before each row and after each row will 
alternate and both will fire 40 times. Then the after anything trigger will fire last and once.

*/



--Question #2e

INSERT INTO LAB9_EMPLOYEE
    SELECT *
    FROM employee
    FETCH FIRST 40 ROWS ONLY;

/* Q2e Query Results

My hypothesis was kind of correct. There were 82 trigger messages but all of the before
and afters were seperate.

Trigger fired before inserting anything into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired before inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting a row into LAB9_EMPLOYEE
Trigger fired after inserting anything into LAB9_EMPLOYEE

40 rows inserted.
*/



--Question #3a

CREATE OR REPLACE TRIGGER RESTRICT_UPDATE
    BEFORE UPDATE ON LAB9_EMPLOYEE
    FOR EACH ROW
    WHEN(NEW.emailaddr NOT LIKE '%.com')
BEGIN
    Raise_APPLICATION_ERROR(100, 'Invalid_Email');
END;

/* Q3a Query Results

Trigger RESTRICT_UPDATE compiled
*/



--Question #3b

UPDATE LAB9_EMPLOYEE
SET emailaddr = 'jackm@gmail.com'
WHERE employeeid LIKE '100001';

UPDATE LAB9_EMPLOYEE
SET emailaddr = 'jackm@gmail.net'
WHERE employeeid LIKE '100001';

/* Q3b Query Results

1 row updated.

Error starting at line : 405 in command -
UPDATE LAB9_EMPLOYEE
SET emailaddr = 'jackm@gmail.net'
WHERE employeeid LIKE '100001'
Error report -
ORA-21000: error number argument to raise_application_error of 100 is out of range
ORA-06512: at "JMAHEDY.RESTRICT_UPDATE", line 2
ORA-04088: error during execution of trigger 'JMAHEDY.RESTRICT_UPDATE'
*/



--Question #3c

CREATE OR REPLACE TRIGGER RESTRICT_UPDATE
    BEFORE UPDATE ON LAB9_EMPLOYEE
    FOR EACH ROW
BEGIN
    IF(:NEW.emailaddr NOT LIKE '%.com') THEN
        Raise_APPLICATION_ERROR(100, 'Invalid_Email');
    END IF;
END;

/* Q3c Query Results

Trigger RESTRICT_UPDATE compiled
*/



--Question #3d

UPDATE LAB9_EMPLOYEE
SET emailaddr = 'jackm@gmail.com'
WHERE employeeid LIKE '100001';

UPDATE LAB9_EMPLOYEE
SET emailaddr = 'jackm@gmail.net'
WHERE employeeid LIKE '100001';

/* Q3d Query Results

1 row updated.

Error starting at line : 449 in command -
UPDATE LAB9_EMPLOYEE
SET emailaddr = 'jackm@gmail.net'
WHERE employeeid LIKE '100001'
Error report -
ORA-21000: error number argument to raise_application_error of 100 is out of range
ORA-06512: at "JMAHEDY.RESTRICT_UPDATE", line 3
ORA-04088: error during execution of trigger 'JMAHEDY.RESTRICT_UPDATE'
*/



--Question #4

DROP TABLE LAB9_EMPLOYEE CASCADE CONSTRAINTS;

/* Q4 Query Results

Table LAB9_EMPLOYEE dropped.
*/