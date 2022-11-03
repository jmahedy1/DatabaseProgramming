/*
Jack Mahedy
CNIT 372 Lab section 007
Estimated Time Spent: 8
Late Hours Used: 0
*/

--Table 1
--Question #1a

SELECT jobtitle, count(employeeid)
FROM employee
GROUP BY jobtitle;

/* Q1a Query Results

JOBTITLE                            COUNT(EMPLOYEEID)
----------------------------------- -----------------
VP Finance                                          1
Sales                                               3
VP Information                                      1
Chief Information Officer                           1
Chief Sales Officer                                 1
VP Operations                                       1
Accountant                                          2
President                                           1
DBA                                                 1
Chief Financial Officer                             1
Engineer                                            5

JOBTITLE                            COUNT(EMPLOYEEID)
----------------------------------- -----------------
Programmer Analyst                                  2
Operations Officer                                  2
Assembly                                           18

14 rows selected.
*/



--Question #1b

DECLARE
    v_number_employees number;
    v_jobtitle varchar2(50) := '&v_jobtitle';
    
BEGIN
    SELECT count(employeeid)
    INTO v_number_employees
    FROM employee
    WHERE jobtitle = v_jobtitle;
    
    IF v_number_employees < 1 THEN
        dbms_output.put_line('There are no employees with the job title: ' || v_jobtitle);
    ELSIF v_number_employees < 4 THEN
        dbms_output.put_line('There are between 1 and 3 employees with the job title: ' || v_jobtitle);
    ELSIF v_number_employees < 7 THEN
        dbms_output.put_line('There are between 4 and 6 employees with the job title: ' || v_jobtitle);
    ELSE
        dbms_output.put_line('There are 7 or more employees with the job title: ' || v_jobtitle);
    END IF;
END;

/* Q1b Query Results

There are no employees with the job title: CIO
*/



--Question #1c
/*
There are between 1 and 3 employees with the job title: Accountant
*/



--Question #1d
/*
There are between 4 and 6 employees with the job title: Engineer
*/



--Question #1e
/*
There are 7 or more employees with the job title: Assembly
*/



--Question #2a

DECLARE
    v_number_employees number;
    v_jobtitle varchar2(50) := '&v_jobtitle';
    
BEGIN
    SELECT count(employeeid)
    INTO v_number_employees
    FROM employee
    WHERE jobtitle = v_jobtitle;
    
    CASE v_number_employees
        WHEN 0 THEN
            dbms_output.put_line('There are no employees with the job title: ' || v_jobtitle);
        WHEN 1 THEN
            dbms_output.put_line('There are between 1 and 3 employees with the job title: ' || v_jobtitle);
        WHEN 2 THEN
            dbms_output.put_line('There are between 1 and 3 employees with the job title: ' || v_jobtitle);
        WHEN 3 THEN
            dbms_output.put_line('There are between 1 and 3 employees with the job title: ' || v_jobtitle);
        WHEN 4 THEN
            dbms_output.put_line('There are between 4 and 6 employees with the job title: ' || v_jobtitle);
        WHEN 5 THEN
            dbms_output.put_line('There are between 4 and 6 employees with the job title: ' || v_jobtitle);
        WHEN 6 THEN
            dbms_output.put_line('There are between 4 and 6 employees with the job title: ' || v_jobtitle);
        ELSE
            dbms_output.put_line('There are 7 or more employees with the job title: ' || v_jobtitle);
        END CASE;
END;

/* Q2a Query Results

There are no employees with the job title: CIO
*/



--Question #2b
/*
There are between 1 and 3 employees with the job title: Accountant
*/



--Question #2c
/*
There are between 4 and 6 employees with the job title: Engineer
*/



--Question #2d
/*
There are 7 or more employees with the job title: Assembly
*/



--Question #3

DECLARE
    v_number_employees number;
    v_jobtitle employee.jobtitle%TYPE := '&v_jobtitle';
    v_staff_level varchar2(100);
    
BEGIN
    SELECT count(employeeid)
    INTO v_number_employees
    FROM employee
    WHERE jobtitle = v_jobtitle;
    
    CASE v_number_employees
        WHEN 0 THEN
            v_staff_level := 'There are no employees with the job title: ' || v_jobtitle;
        WHEN 1 THEN
            v_staff_level := 'There are between 1 and 3 employees with the job title: ';
        WHEN 2 THEN
            v_staff_level := 'There are between 1 and 3 employees with the job title: ';
        WHEN 3 THEN
            v_staff_level := 'There are between 1 and 3 employees with the job title: ';
        WHEN 4 THEN
            v_staff_level := 'There are between 4 and 6 employees with the job title: ';
        WHEN 5 THEN
            v_staff_level := 'There are between 4 and 6 employees with the job title: ';
        WHEN 6 THEN
            v_staff_level := 'There are between 4 and 6 employees with the job title: ';
        ELSE
            v_staff_level := 'There are 7 or more employees with the job title: ';
        END CASE;
        
        dbms_output.put_line(v_staff_level || v_jobtitle);
END;

/* Q3 Query Results

There are between 4 and 6 employees with the job title: Engineer
*/



--Question #4a

DECLARE
    my_count INTEGER := '&my_count';
    my_counter INTEGER := 1;
    my_number INTEGER;

BEGIN
    LOOP
        my_number := dbms_random.value(1, my_count);
        dbms_output.put(my_number || ', ');
        my_counter := my_counter + 1;
        EXIT WHEN my_counter > my_count;
    END LOOP;
    dbms_output.put_line('');

END;

/* Q4a Query Results

2, 2, 2, 5, 1, 
*/

--Question #4b
/*
The code loops for the amount you entered. For each loop it prints a random number from 1 to the number you entered.
During each itteration of the loop, my_counter increments by 1 starting at 1. The loop ends after my_counter is 
greater then my_count.
*/

--Question #4a

DECLARE
    my_count INTEGER := '&my_count';
    my_counter INTEGER := 1;
    my_number INTEGER;

BEGIN
    WHILE(my_counter <= my_count) LOOP
        my_number := dbms_random.value(1, my_count);
        dbms_output.put(my_number || ', ');
        my_counter := my_counter + 1;
    END LOOP;
    dbms_output.put_line('');

END;



--Question #4b
/*
3, 3, 3, 5, 4,
*/



--Question #5a

DECLARE
    my_count INTEGER := '&my_count';
    my_counter INTEGER := 1;
    my_number INTEGER;

BEGIN
    FOR my_counter in 1..my_count LOOP
        my_number := dbms_random.value(1, my_count);
        dbms_output.put(my_number || ', ');
    END LOOP;
    dbms_output.put_line('');

END;



--Question #5b
/*
3, 4, 5, 5, 3, 
*/



--Table 2
--Question #1a

CREATE OR REPLACE PROCEDURE HELLO_WORLD
AS
    v_output VARCHAR2(35) := 'Hello World';
BEGIN
    dbms_output.put_line(v_output);
END HELLO_WORLD;

/* Q1a Query Results

Procedure HELLO_WORLD compiled. This was printed to the Script output.
*/

--Question #1b

EXEC HELLO_WORLD;



--Question #1c
/*
Hello World
*/



--Question #1d
/* 
Anonymous blocks have no names. If you only used anonymous blocks, it would be hard ot create a complex program.
Named blocks allow you to organize your statements. They are also called subprograms. They are used to execute
procedures and functions.
*/



--Question #2

CREATE OR REPLACE PROCEDURE HELLO_WORLD
AS
    v_output VARCHAR2(35) := 'Hello World';
BEGIN
    dbms_output.put_line(v_output);
END HELLO_WORLD;

/* Q2 Query Results

CREATE OR REPLACE PROCEDURE hello_world AS
    v_output VARCHAR2(35) := 'Hello World';
BEGIN
    dbms_output.put_line(v_output);
END hello_world;

Made hello world lower case and put AS on the previous line
*/

--Question #3

CREATE OR REPLACE PROCEDURE HELLO_WORLD
(p_name IN varchar2)
AS
    v_output VARCHAR2(35);
BEGIN
    v_output := 'HELLO ' || p_name;
    dbms_output.put_line(v_output);
END HELLO_WORLD;



--Question #3a

EXEC HELLO_WORLD('World');

/* Q3a Query Results

HELLO World
*/



--Question #3b

EXEC HELLO_WORLD('MARK');

/* Q3b Query Results

HELLO MARK
*/



--Question #3c

EXEC HELLO_WORLD('World. procedure. I have so much fun coding in SQL and PLSQL.');

/* Q3c Query Results

Error starting at line : 366 in command -
BEGIN HELLO_WORLD('World. procedure. I have so much fun coding in SQL and PLSQL.'); END;
Error report -
ORA-06502: PL/SQL: numeric or value error: character string buffer too small
ORA-06512: at "JMAHEDY.HELLO_WORLD", line 6
ORA-06512: at line 1
06502. 00000 -  "PL/SQL: numeric or value error%s"
*Cause:    An arithmetic, numeric, string, conversion, or constraint error
           occurred. For example, this error occurs if an attempt is made to
           assign the value NULL to a variable declared NOT NULL, or if an
           attempt is made to assign an integer larger than 99 to a variable
           declared NUMBER(2).
*Action:   Change the data, how it is manipulated, or how it is declared so
           that values do not violate constraints.
*/



--Question #3d

CREATE OR REPLACE PROCEDURE HELLO_WORLD
(p_name IN varchar2)
AS
    v_output VARCHAR2(100);
BEGIN
    v_output := 'HELLO ' || p_name;
    dbms_output.put_line(v_output);
END HELLO_WORLD;



--Question #3e

EXEC HELLO_WORLD('World. procedure. I have so much fun coding in SQL and PLSQL.');

/* Q3e Query Results

HELLO World. procedure. I have so much fun coding in SQL and PLSQL.
*/



--Question #4

CREATE OR REPLACE PROCEDURE HELLO_WORLD
(
    p_greeting IN varchar2,
    p_name IN varchar2
)
AS
    v_output VARCHAR2(75);
BEGIN
    v_output := p_greeting || ' ' || p_name;
    dbms_output.put_line(v_output);
end HELLO_WORLD;

/* Q4 Query Results

Procedure HELLO_WORLD compiled
*/



--Question #4a

EXEC HELLO_WORLD('Hello', 'World');

/* Q4a Query Results

Hello World
*/



--Question #4b

EXEC HELLO_WORLD('Hello');

/* Q4b Query Results

I get an error: wrong number or types of arguments in call to 'HELLO_WORLD'
*/



--Question #4c

EXEC HELLO_WORLD('Goodbye', 'Hal');

/* Q4c Query Results

Goodbye Hal
*/



--Question #4d

EXEC HELLO_WORLD('Hello', null);

/* Q4d Query Results

Hello 
*/



--Question #5

CREATE OR REPLACE FUNCTION NUMBER_OF_EMPLOYEES
    RETURN NUMBER
AS
    v_number_of_employees NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO v_number_of_employees
    FROM employee;
    RETURN v_number_of_employees;
END NUMBER_OF_EMPLOYEES;

BEGIN
    dbms_output.put_line('Output: ' || NUMBER_OF_EMPLOYEES());
END;

/* Q5 Query Results

Output: 40
*/



--Question #Q6

CREATE OR REPLACE FUNCTION NUMBER_OF_EMPLOYEES(p_jobtitle IN varchar2)
    RETURN NUMBER
AS
    v_number_of_employees NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO v_number_of_employees
    FROM employee
    WHERE jobtitle = p_jobtitle;
    
    RETURN v_number_of_employees;
END NUMBER_OF_EMPLOYEES;



--Question #6a

BEGIN
    dbms_output.put_line('Output: ' || NUMBER_OF_EMPLOYEES('Engineer'));
END;

/* Q6a Query Results

Output: 5
*/



--Question #6b

CREATE OR REPLACE FUNCTION NUMBER_OF_EMPLOYEES(p_jobtitle IN employee.jobtitle%TYPE)
    RETURN NUMBER
AS
    v_number_of_employees NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO v_number_of_employees
    FROM employee
    WHERE lower(jobtitle) = trim(lower(p_jobtitle));
    
    RETURN v_number_of_employees;
END NUMBER_OF_EMPLOYEES;



--Question #6c

BEGIN
    dbms_output.put_line('Output: ' || NUMBER_OF_EMPLOYEES('engineer'));
END;

/* Q6c Query Results

Output: 5
*/



--Question #6d

BEGIN
    dbms_output.put_line('Output: ' || NUMBER_OF_EMPLOYEES('dba'));
END;

/* Q6d Query Results

Output: 1
*/



--Question #6e

BEGIN
    dbms_output.put_line('Output: ' || NUMBER_OF_EMPLOYEES('DBA'));
END;

/* Q6e Query Results

Output: 1
*/



--Question #6f

BEGIN
    dbms_output.put_line('Output: ' || NUMBER_OF_EMPLOYEES('chief sales officer'));
END;

/* Q6f Query Results

Output: 1
*/



--Question #6g

BEGIN
    dbms_output.put_line('Output: ' || NUMBER_OF_EMPLOYEES(' chief sales officer '));
END;

/* Q6g Query Results

Output: 1
*/



--Question #6h

BEGIN
    dbms_output.put_line('Output: ' || NUMBER_OF_EMPLOYEES('CEO'));
END;

/* Q6h Query Results

Output: 0
*/



--Question #7a

CREATE OR REPLACE FUNCTION DAYS_AWAY(in_date IN DATE)
    RETURN NUMBER
AS
    date_difference number;
BEGIN
    SELECT ROUND(in_date - sysdate, 0)
    INTO date_difference
    FROM dual;
    
    RETURN date_difference;
END DAYS_AWAY;



--Question #7b

BEGIN
    dbms_output.put_line('Days away: ' || DAYS_AWAY('10-SEP-22'));
    dbms_output.put_line('Days away: ' || DAYS_AWAY('10-OCT-22'));
END;

/* Q7b Query Results

Days away: -21
Days away: 9
*/



--Question #8a

CREATE OR REPLACE PROCEDURE Day_OF_THE_WEEK(in_day IN DATE) 
AS 
    out_day varchar2(100);
BEGIN 
    SELECT TO_CHAR(in_day - 1, 'DAY') || TO_CHAR(in_day, 'DAY') || TO_CHAR(in_day + 1, 'DAY')
    INTO out_day
    FROM dual;
    dbms_output.put_line(out_day);
END DAY_OF_THE_WEEK;

--Question #8b

EXEC DAY_OF_THE_WEEK('10-SEP-22');
EXEC DAY_OF_THE_WEEK(sysdate);

/* Q8b Query Results

FRIDAY   SATURDAY SUNDAY   

SATURDAY SUNDAY   MONDAY
*/



--Question #8a

CREATE OR REPLACE PROCEDURE DAYS_FROM_WEEKEND(in_day IN DATE DEFAULT sysdate()) 
AS 
    out_day varchar2(100);
BEGIN 
    out_day := TO_CHAR(in_day, 'DY');
    
    IF out_day = 'MON' THEN
        dbms_output.put_line('5 Day until the weekend');
    ELSIF out_day = 'TUE' THEN
        dbms_output.put_line('4 Day until the weekend');
    ELSIF out_day = 'WED' THEN
        dbms_output.put_line('3 Day until the weekend');
    ELSIF out_day = 'THU' THEN
        dbms_output.put_line('2 Day until the weekend');
    ELSIF out_day = 'FRI' THEN
        dbms_output.put_line('1 Day until the weekend');
    ELSIF out_day = 'SAT' THEN
        dbms_output.put_line('Happy Weekend!');
    ELSIF out_day = 'SUN' THEN
        dbms_output.put_line('Happy Weekend!');
    END IF;
END DAYS_FROM_WEEKEND;
        


--Question #8b

EXEC DAYS_FROM_WEEKEND('03-OCT-22');
EXEC DAYS_FROM_WEEKEND(sysdate);

/* Q8b Query Results

5 Day until the weekend

Happy Weekend!
*/