/*
Jack Mahedy
CNIT 372 Lab section 007
Estimated Time Spent: 4
Late Hours Used: 0
*/

--Question #1a

CREATE OR REPLACE PACKAGE MATH_CONSTANTS
IS
    c_pi CONSTANT NUMBER := acos(-1);
END MATH_CONSTANTS;

/* Q1a Query Results

Package MATH_CONSTANTS compiled
*/



/*Question #1b

ACOS() returns the arc cosine of a number. The value of ACOS(-1) is 3.1415..., it is reffered to as PI 
*/



--Question #1c

BEGIN
    dbms_output.put_line('The value is: ' || MATH_CONSTANTS.c_pi);
END;

/* Q1c Query Results

The value is: 3.1415926535897932384626433832795028842
*/



--Question #1d

SELECT c_pi
FROM dual;

/* Q1d Query Results

You get an error because you can't access the variable outside the package.

Error starting at line : 45 in command -
SELECT c_pi
FROM dual
Error at Command Line : 45 Column : 8
Error report -
SQL Error: ORA-00904: "C_PI": invalid identifier
00904. 00000 -  "%s: invalid identifier"
*Cause:    
*Action:
*/



--Question #1e

CREATE OR REPLACE FUNCTION CALCULATE_AREA(p_radius NUMBER) 
    RETURN NUMBER
AS
    v_area NUMBER;
BEGIN
    v_area := MATH_CONSTANTS.c_pi * POWER(p_radius, 2);
    RETURN ROUND(v_area, 3);
END CALCULATE_AREA;

/* Q1e Query Results

Function CALCULATE_AREA compiled
*/



--Question #1f

BEGIN
    dbms_output.put_line('The area for 5 is: ' || CALCULATE_AREA(5));
    dbms_output.put_line('The area for 10 is: ' || CALCULATE_AREA(10));
    dbms_output.put_line('The area for 15 is: ' || CALCULATE_AREA(15));
END;

/* Q1f Query Results

The area for 5 is: 78.54
The area for 10 is: 314.159
The area for 15 is: 706.858
*/



--Question #2a

CREATE OR REPLACE FUNCTION PARSE_FIRSTNAME(p_fullname supplier.contactname%type)
    RETURN VARCHAR2
IS
    v_firstname supplier.contactname%type;
BEGIN
    v_firstname := SUBSTR(p_fullname, 1, INSTR(p_fullname, ' ', 1, 1) -1);
    RETURN v_firstname;
END PARSE_FIRSTNAME;

/* Q2a Query Results

Function PARSE_FIRSTNAME compiled
*/



--Question #2b

SELECT PARSE_FIRSTNAME(contactname)
FROM supplier;

/* Q2b Query Results

PARSE_FIRSTNAME(CONTACTNAME)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
--------------------------------------------------
Dorthy
Rob
Sandy
Timothy
Adam
William
Debra
Paul
Kelli
Kevin
Loraine

PARSE_FIRSTNAME(CONTACTNAME)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
--------------------------------------------------
Wade
Elizabeth
David
Alice
Gordon
Jamie
Donald
Lance
Gary
Tim
Darlene

PARSE_FIRSTNAME(CONTACTNAME)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
--------------------------------------------------
Pam
Thurman
Jennie
Travis
Stephen
Yauleng
Brenda

29 rows selected.
*/



--Question #2c

DROP FUNCTION PARSE_FIRSTNAME;

/* Q2c Query Results

Function PARSE_FIRSTNAME dropped.
*/



--Question #2d

CREATE OR REPLACE PACKAGE PKG_FORMAT_EAGLE_DATA
IS
    FUNCTION PARSE_FIRSTNAME(p_fullname supplier.contactname%TYPE)
    RETURN VARCHAR2;
END PKG_FORMAT_EAGLE_DATA;

/* Q2d Query Results

Package PKG_FORMAT_EAGLE_DATA compiled
*/



--Question #2e

CREATE OR REPLACE PACKAGE BODY PKG_FORMAT_EAGLE_DATA
IS
    FUNCTION PARSE_FIRSTNAME(p_fullname supplier.contactname%TYPE)
    RETURN VARCHAR2
    IS
        v_firstname supplier.contactname%TYPE;
    BEGIN
        v_firstname := SUBSTR(p_fullname, 1, INSTR(p_fullname, ' ', 1, 1) -1);
        RETURN v_firstname;
    END PARSE_FIRSTNAME;
END PKG_FORMAT_EAGLE_DATA;

/* Q2e Query Results

Package Body PKG_FORMAT_EAGLE_DATA compiled
*/



--Question #2f

SELECT PKG_FORMAT_EAGLE_DATA.PARSE_FIRSTNAME(contactname)
FROM supplier;

/* Q2f Query Results

PKG_FORMAT_EAGLE_DATA.PARSE_FIRSTNAME(CONTACTNAME)
--------------------------------------------------
Dorthy
Rob
Sandy
Timothy
Adam
William
Debra
Paul
Kelli
Kevin
Loraine

PKG_FORMAT_EAGLE_DATA.PARSE_FIRSTNAME(CONTACTNAME)
--------------------------------------------------
Wade
Elizabeth
David
Alice
Gordon
Jamie
Donald
Lance
Gary
Tim
Darlene

PKG_FORMAT_EAGLE_DATA.PARSE_FIRSTNAME(CONTACTNAME)
--------------------------------------------------
Pam
Thurman
Jennie
Travis
Stephen
Yauleng
Brenda

29 rows selected.
*/



--Question #2g

CREATE OR REPLACE PACKAGE PKG_FORMAT_EAGLE_DATA
IS
    FUNCTION PARSE_FIRSTNAME(p_fullname supplier.contactname%TYPE)
    RETURN VARCHAR2;
    
    FUNCTION PARSE_LASTNAME(p_fullname supplier.contactname%TYPE)
    RETURN VARCHAR2;
END PKG_FORMAT_EAGLE_DATA;

/* Q2g Query Results

Package PKG_FORMAT_EAGLE_DATA compiled
*/



--Question #2h

CREATE OR REPLACE PACKAGE BODY PKG_FORMAT_EAGLE_DATA
IS
    FUNCTION PARSE_FIRSTNAME(p_fullname supplier.contactname%TYPE)
    RETURN VARCHAR2
    IS
        v_firstname supplier.contactname%TYPE;
    BEGIN
        v_firstname := SUBSTR(p_fullname, 1, INSTR(p_fullname, ' ', 1, 1) -1);
        RETURN v_firstname;
    END PARSE_FIRSTNAME;
    
    
    FUNCTION PARSE_LASTNAME(p_fullname supplier.contactname%TYPE)
    RETURN VARCHAR2
    IS
        v_lastname supplier.contactname%TYPE;
    BEGIN
        v_lastname := SUBSTR(p_fullname, INSTR(p_fullname, ' ', 1, 1) +1);
        RETURN v_lastname;
    END PARSE_LASTNAME;
END PKG_FORMAT_EAGLE_DATA;

/* Q2h Query Results

Package Body PKG_FORMAT_EAGLE_DATA compiled
*/



--Question #2i

SELECT PKG_FORMAT_EAGLE_DATA.PARSE_LASTNAME(contactname)
FROM supplier;

SELECT PKG_FORMAT_EAGLE_DATA.PARSE_FIRSTNAME(contactname)
FROM supplier;

/* Q2i Query Results

PKG_FORMAT_EAGLE_DATA.PARSE_LASTNAME(CONTACTNAME)
--------------------------------------------------
Beering
Thomas
Goodman
Neal
Cyr
Newlon
Cruz
Smith
Jones
Martin
Platt

PKG_FORMAT_EAGLE_DATA.PARSE_LASTNAME(CONTACTNAME)
--------------------------------------------------
Holle
Clark
Becker
Mynhier
Mayes
Pickett
Blythe
Andrews
Mikels
White
Jenkins

PKG_FORMAT_EAGLE_DATA.PARSE_LASTNAME(CONTACTNAME)
--------------------------------------------------
Krick
Mezzo
Fry
Honn
Bird
Depoe
Pritchett


29 rows selected.

PKG_FORMAT_EAGLE_DATA.PARSE_FIRSTNAME(CONTACTNAME)
--------------------------------------------------
Dorthy
Rob
Sandy
Timothy
Adam
William
Debra
Paul
Kelli
Kevin
Loraine

PKG_FORMAT_EAGLE_DATA.PARSE_FIRSTNAME(CONTACTNAME)
--------------------------------------------------
Wade
Elizabeth
David
Alice
Gordon
Jamie
Donald
Lance
Gary
Tim
Darlene

PKG_FORMAT_EAGLE_DATA.PARSE_FIRSTNAME(CONTACTNAME)
--------------------------------------------------
Pam
Thurman
Jennie
Travis
Stephen
Yauleng
Brenda

29 rows selected.
*/



--Question #3

CREATE OR REPLACE PACKAGE PKG_SHAPE_CALCULATION
IS
    FUNCTION RECTANGLE_AREA(p_length NUMBER, p_width NUMBER)
        RETURN NUMBER;
    
    FUNCTION RECTANGLE_AREA(p_length NUMBER)
        RETURN NUMBER;
    
    FUNCTION CIRCLE_AREA(p_radius NUMBER)
        RETURN NUMBER;
END PKG_SHAPE_CALCULATION;

/* Q3 Query Results

Package PKG_SHAPE_CALCULATION compiled
*/



--Question #3a-e

CREATE OR REPLACE PACKAGE BODY PKG_SHAPE_CALCULATION AS

--Question #3c

    c_pi CONSTANT NUMBER := acos(-1);

/*Results
Since the value of PI will never change we want to keep it private so nobody can change it.
*/

--Question #3e

    FUNCTION CHECK_VALUE(p_lwr NUMBER)
        RETURN BOOLEAN
    AS
    BEGIN
        IF p_lwr > 0 THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
        EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put(SQLCODE);
            dbms_output.put(': ');
            dbms_output.put_line(SUBSTR(SQLERRM, 1, 100));
            RETURN FALSE;
    END CHECK_VALUE;

--Question #3a

    FUNCTION RECTANGLE_AREA(p_length NUMBER, p_width NUMBER)
        RETURN NUMBER
    AS
        v_area NUMBER;
    BEGIN
        BEGIN 
            IF CHECK_VALUE(p_length) = TRUE AND CHECK_VALUE(p_width) = TRUE THEN
                v_area := p_length * p_width;
                RETURN v_area;
            ELSE
                dbms_output.put_line('The area can not be calculated change your parameters');
                RETURN NULL;
            END IF;
        END;
        EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put(SQLCODE);
            dbms_output.put(': ');
            dbms_output.put_line(SUBSTR(SQLERRM, 1, 100));
            RETURN NULL;
    END RECTANGLE_AREA;

--Question #3b

    FUNCTION RECTANGLE_AREA(p_length NUMBER)
        RETURN NUMBER
    AS
        v_area NUMBER;
    BEGIN
        BEGIN 
            IF CHECK_VALUE(p_length) = TRUE THEN
                v_area := p_length * p_length;
                RETURN v_area;
            ELSE
                dbms_output.put_line('The area can not be calculated change your parameters');
                RETURN NULL;
            END IF;
        END;
        
        EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put(SQLCODE);
            dbms_output.put(': ');
            dbms_output.put_line(SUBSTR(SQLERRM, 1, 100));
            RETURN NULL;
    END RECTANGLE_AREA;

--Question #3d

    FUNCTION CIRCLE_AREA(p_radius IN NUMBER)
        RETURN NUMBER
    AS
        v_area NUMBER;
    BEGIN
        BEGIN
            IF CHECK_VALUE(p_radius) = TRUE THEN
                v_area := c_pi * POWER(p_radius, 2);
                RETURN v_area;
            ELSE
                dbms_output.put_line('The area can not be calculated change your parameters');
                RETURN NULL;
            END IF;
        END;
    
        EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put(SQLCODE);
            dbms_output.put(': ');
            dbms_output.put_line(SUBSTR(SQLERRM, 1, 100));
            RETURN NULL;
    END CIRCLE_AREA;
END PKG_SHAPE_CALCULATION;

/* Q3 Query Results

Package Body PKG_SHAPE_CALCULATION compiled
*/



--Question #3f

SELECT PKG_SHAPE_CALCULATION.RECTANGLE_AREA(5, 5)
FROM DUAL;
SELECT PKG_SHAPE_CALCULATION.RECTANGLE_AREA(-5, -5)
FROM DUAL;
SELECT PKG_SHAPE_CALCULATION.RECTANGLE_AREA(0, 0)
FROM DUAL;

SELECT PKG_SHAPE_CALCULATION.RECTANGLE_AREA(5)
FROM DUAL;
SELECT PKG_SHAPE_CALCULATION.RECTANGLE_AREA(-5)
FROM DUAL;
SELECT PKG_SHAPE_CALCULATION.RECTANGLE_AREA(0)
FROM DUAL;

SELECT PKG_SHAPE_CALCULATION.CIRCLE_AREA(5)
FROM DUAL;
SELECT PKG_SHAPE_CALCULATION.CIRCLE_AREA(-5)
FROM DUAL;
SELECT PKG_SHAPE_CALCULATION.CIRCLE_AREA(0)
FROM DUAL;

/* Q3f Query Results

PKG_SHAPE_CALCULATION.RECTANGLE_AREA(5,5)
-----------------------------------------
                                       25

PKG_SHAPE_CALCULATION.RECTANGLE_AREA(-5,-5)
-------------------------------------------
The area can not be calculated change your parameters

PKG_SHAPE_CALCULATION.RECTANGLE_AREA(0,0)
-----------------------------------------
The area can not be calculated change your parameters

---------------------------------------------------------------------------------

PKG_SHAPE_CALCULATION.RECTANGLE_AREA(5)
---------------------------------------
                                     25

PKG_SHAPE_CALCULATION.RECTANGLE_AREA(-5)
----------------------------------------
The area can not be calculated change your parameters

PKG_SHAPE_CALCULATION.RECTANGLE_AREA(0)
---------------------------------------
The area can not be calculated change your parameters

---------------------------------------------------------------------------------

PKG_SHAPE_CALCULATION.CIRCLE_AREA(5)
------------------------------------
                          78.5398163

PKG_SHAPE_CALCULATION.CIRCLE_AREA(-5)
-------------------------------------
The area can not be calculated change your parameters

PKG_SHAPE_CALCULATION.CIRCLE_AREA(0)
------------------------------------
The area can not be calculated change your parameters
*/