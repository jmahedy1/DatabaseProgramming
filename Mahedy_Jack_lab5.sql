/*
Jack Mahedy
CNIT 372 Lab section 007
Estimated Time Spent: 4
Late Hours Used: 0
*/

--Option A
--Question #1a

CREATE OR REPLACE PROCEDURE print_employee_roster
AS
    current_employeeid employee.employeeid%TYPE;
    current_lastname employee.lastname%TYPE;
    current_firstname employee.firstname%TYPE;
    
    CURSOR all_employees
    IS
        SELECT employeeid, lastname, firstname 
        FROM employee;
BEGIN
    OPEN all_employees;
    FETCH all_employees INTO current_employeeid, current_lastname, current_firstname;
    WHILE all_employees%FOUND LOOP
        dbms_output.put(RPAD(current_employeeid, 15, ' '));
        dbms_output.put(RPAD(current_lastname, 30, ' '));
        dbms_output.put_line(RPAD(current_firstname, 15, ' '));
        FETCH all_employees INTO current_employeeid, current_lastname, current_firstname;
    END LOOP;
    
    CLOSE all_employees;
END print_employee_roster;



--Question #1b

EXEC print_employee_roster;

/* Q1b Query Results

100001         Manaugh                       Jim            
100101         Rosner                        Joanne         
100103         Bush                          Rita           
100104         Abbott                        Michael        
100106         Eckelman                      Paul           
100112         Hickman                       Steven         
100120         Nairn                         Michelle       
100125         Stevenson                     Gabrielle      
100127         Wendling                      Jason          
100200         Zobitz                        Beth           
100204         Keck                          David          
100206         Xolo                          Kathleen       
100209         Yates                         Tina           
100220         Vigus                         Todd           
100330         Gustavel                      Kristen        
100365         Cheswick                      Sherman        
100399         Day                           Ronald         
100475         Hess                          Steve          
100488         Osman                         Jamie          
100550         Roland                        Allison        
100559         Tyrie                         Meghan         
100600         Zollman                       Calie          
100650         Lilley                        Edna           
100700         Jones                         Charles        
100880         German                        Gary           
100892         Platt                         Joseph         
100944         Stahley                       Ryan           
100967         Albregts                      Nicholas       
100989         Deagen                        Kathryn        
101007         Krasner                       Jason          
101030         Moore                         Kristey        
101045         Ortman                        Austin         
101066         Rodgers                       Laura          
101088         Underwood                     Patricha       
101089         Alvarez                       Melissa        
101097         Brose                         Jack           
101115         Cochran                       Steve          
101135         Deppe                         David          
101154         Hettinger                     Gregory        
101166         Reece                         Phil
*/



--Question #2a

CREATE OR REPLACE PROCEDURE print_employee_roster
AS
    
    CURSOR all_employees
    IS
        SELECT employeeid, lastname, firstname 
        FROM employee;
        
    current_employee all_employees%ROWTYPE;
BEGIN
    OPEN all_employees;
    FETCH all_employees INTO current_employee;
    WHILE all_employees%FOUND LOOP
        dbms_output.put(RPAD(current_employee.employeeid, 15, ' '));
        dbms_output.put(RPAD(current_employee.lastname, 30, ' '));
        dbms_output.put_line(RPAD(current_employee.firstname, 15, ' '));
        FETCH all_employees INTO current_employee;
    END LOOP;
    
    CLOSE all_employees;
END print_employee_roster;



--Question #2b

EXEC print_employee_roster;

/* Q1a Query Results

100001         Manaugh                       Jim            
100101         Rosner                        Joanne         
100103         Bush                          Rita           
100104         Abbott                        Michael        
100106         Eckelman                      Paul           
100112         Hickman                       Steven         
100120         Nairn                         Michelle       
100125         Stevenson                     Gabrielle      
100127         Wendling                      Jason          
100200         Zobitz                        Beth           
100204         Keck                          David          
100206         Xolo                          Kathleen       
100209         Yates                         Tina           
100220         Vigus                         Todd           
100330         Gustavel                      Kristen        
100365         Cheswick                      Sherman        
100399         Day                           Ronald         
100475         Hess                          Steve          
100488         Osman                         Jamie          
100550         Roland                        Allison        
100559         Tyrie                         Meghan         
100600         Zollman                       Calie          
100650         Lilley                        Edna           
100700         Jones                         Charles        
100880         German                        Gary           
100892         Platt                         Joseph         
100944         Stahley                       Ryan           
100967         Albregts                      Nicholas       
100989         Deagen                        Kathryn        
101007         Krasner                       Jason          
101030         Moore                         Kristey        
101045         Ortman                        Austin         
101066         Rodgers                       Laura          
101088         Underwood                     Patricha       
101089         Alvarez                       Melissa        
101097         Brose                         Jack           
101115         Cochran                       Steve          
101135         Deppe                         David          
101154         Hettinger                     Gregory        
101166         Reece                         Phil
*/



--Question #2c
/* 
The database object that the current_employee variable is based upon is the all_employees cursor.
*/



--Question #3a

CREATE OR REPLACE PROCEDURE print_employee_roster
AS
    
    CURSOR all_employees
    IS
        SELECT employeeid, lastname || ', ' || firstname AS name
        FROM employee;
        
    current_employee all_employees%ROWTYPE;
BEGIN
    OPEN all_employees;
    FETCH all_employees INTO current_employee;
    WHILE all_employees%FOUND LOOP
        dbms_output.put(RPAD(current_employee.employeeid, 15, ' '));
        dbms_output.put_line((current_employee.name));
        FETCH all_employees INTO current_employee;
    END LOOP;
    
    CLOSE all_employees;
END print_employee_roster;



--Question #3b

EXEC print_employee_roster;

/* Q3b Query Results

100001         Manaugh, Jim
100101         Rosner, Joanne
100103         Bush, Rita
100104         Abbott, Michael
100106         Eckelman, Paul
100112         Hickman, Steven
100120         Nairn, Michelle
100125         Stevenson, Gabrielle
100127         Wendling, Jason
100200         Zobitz, Beth
100204         Keck, David
100206         Xolo, Kathleen
100209         Yates, Tina
100220         Vigus, Todd
100330         Gustavel, Kristen
100365         Cheswick, Sherman
100399         Day, Ronald
100475         Hess, Steve
100488         Osman, Jamie
100550         Roland, Allison
100559         Tyrie, Meghan
100600         Zollman, Calie
100650         Lilley, Edna
100700         Jones, Charles
100880         German, Gary
100892         Platt, Joseph
100944         Stahley, Ryan
100967         Albregts, Nicholas
100989         Deagen, Kathryn
101007         Krasner, Jason
101030         Moore, Kristey
101045         Ortman, Austin
101066         Rodgers, Laura
101088         Underwood, Patricha
101089         Alvarez, Melissa
101097         Brose, Jack
101115         Cochran, Steve
101135         Deppe, David
101154         Hettinger, Gregory
101166         Reece, Phil
*/



--Question #4a

CREATE OR REPLACE PROCEDURE print_employee_roster
AS
    CURSOR all_employees
    IS
        SELECT employeeid, lastname || ', ' || firstname as name
        FROM employee;
BEGIN
    FOR current_employee IN all_employees LOOP
        dbms_output.put(RPAD(current_employee.employeeid, 15, ' '));
        dbms_output.put_line(current_employee.name);
    END LOOP;
END print_employee_roster;
        


--Question #4b

EXEC print_employee_roster;

/* Q4b Query Results

100001         Manaugh, Jim
100101         Rosner, Joanne
100103         Bush, Rita
100104         Abbott, Michael
100106         Eckelman, Paul
100112         Hickman, Steven
100120         Nairn, Michelle
100125         Stevenson, Gabrielle
100127         Wendling, Jason
100200         Zobitz, Beth
100204         Keck, David
100206         Xolo, Kathleen
100209         Yates, Tina
100220         Vigus, Todd
100330         Gustavel, Kristen
100365         Cheswick, Sherman
100399         Day, Ronald
100475         Hess, Steve
100488         Osman, Jamie
100550         Roland, Allison
100559         Tyrie, Meghan
100600         Zollman, Calie
100650         Lilley, Edna
100700         Jones, Charles
100880         German, Gary
100892         Platt, Joseph
100944         Stahley, Ryan
100967         Albregts, Nicholas
100989         Deagen, Kathryn
101007         Krasner, Jason
101030         Moore, Kristey
101045         Ortman, Austin
101066         Rodgers, Laura
101088         Underwood, Patricha
101089         Alvarez, Melissa
101097         Brose, Jack
101115         Cochran, Steve
101135         Deppe, David
101154         Hettinger, Gregory
101166         Reece, Phil
*/



--Question #4c
/*
The DML and PL/SQL select statements are implicitly handeled by the PL/SQL engine
*/



--Question #5a

CREATE OR REPLACE PROCEDURE print_employee_roster
(p_jobtitle IN employee.jobtitle%TYPE)
AS
    CURSOR all_employees
    IS
        SELECT employeeid, lastname || ', ' || firstname as name
        FROM employee
        WHERE UPPER(TRIM(jobtitle)) = UPPER(TRIM(p_jobtitle));
BEGIN
    FOR current_employee IN all_employees LOOP
        dbms_output.put(RPAD(current_employee.employeeid, 15, ' '));
        dbms_output.put_line(current_employee.name);
    END LOOP;
END print_employee_roster;



--Question #5b

EXEC print_employee_roster('sales');

/* Q1a Query Results

100600         Zollman, Calie
101007         Krasner, Jason
101066         Rodgers, Laura
*/



--Question #5c

EXEC print_employee_roster('assembly');

/* Q1a Query Results

100101         Rosner, Joanne
100120         Nairn, Michelle
100204         Keck, David
100399         Day, Ronald
100475         Hess, Steve
100550         Roland, Allison
100892         Platt, Joseph
100967         Albregts, Nicholas
100989         Deagen, Kathryn
101030         Moore, Kristey
101045         Ortman, Austin
101088         Underwood, Patricha
101089         Alvarez, Melissa
101097         Brose, Jack
101115         Cochran, Steve
101135         Deppe, David
101154         Hettinger, Gregory
101166         Reece, Phil
*/



--Question #5d

EXEC print_employee_roster('student');

/* Q5d Query Results

Script Output:
PL/SQL procedure successfully completed.

The prodecure runs successfully, but there is no result to the DBMS output.
*/



--Question #6a

CREATE OR REPLACE PROCEDURE print_employee_roster
(p_jobtitle IN employee.jobtitle%TYPE)
AS
    CURSOR all_employees
    IS
        SELECT employeeid, lastname || ', ' || firstname as name
        FROM employee
        WHERE UPPER(TRIM(jobtitle)) = UPPER(TRIM(p_jobtitle));
BEGIN
    FOR current_employee IN all_employees LOOP
        dbms_output.put(RPAD(current_employee.employeeid, 15, ' '));
        dbms_output.put_line(current_employee.name);
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put(SQLCODE);
        dbms_output.put(': ');
        dbms_output.put_line(SUBSTR(SQLERRM, 1, 100));
END print_employee_roster;



--Question #6b

EXEC print_employee_roster('assembly');

/* Q6b Query Results

100101         Rosner, Joanne
100120         Nairn, Michelle
100204         Keck, David
100399         Day, Ronald
100475         Hess, Steve
100550         Roland, Allison
100892         Platt, Joseph
100967         Albregts, Nicholas
100989         Deagen, Kathryn
101030         Moore, Kristey
101045         Ortman, Austin
101088         Underwood, Patricha
101089         Alvarez, Melissa
101097         Brose, Jack
101115         Cochran, Steve
101135         Deppe, David
101154         Hettinger, Gregory
101166         Reece, Phil
*/



--Question #6c
/*
The code that casued the error would print first, then the descriptions of the error would print.
*/



--Question #7a

CREATE OR REPLACE PROCEDURE customer_roster
(p_state IN customer.state%TYPE)
AS
    CURSOR all_customers
    IS
        SELECT NVL(companyname, 'Residential Customer') AS company_name, city, state, custlastname || ', ' || custfirstname as name
        FROM customer
        WHERE UPPER(TRIM(p_state)) = UPPER(TRIM(state));
        
        current_customer all_customers%ROWTYPE;
BEGIN
    OPEN all_customers;
    FETCH all_customers INTO current_customer;
    WHILE all_customers%FOUND LOOP
        dbms_output.put(RPAD(current_customer.company_name, 30, ' '));
        dbms_output.put(RPAD(current_customer.city, 30, ' '));
        dbms_output.put(RPAD(current_customer.state, 20, ' '));
        dbms_output.put_line(RPAD(current_customer.name, 20, ' '));
        FETCH all_customers INTO current_customer;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put(SQLCODE);
        dbms_output.put(': ');
        dbms_output.put_line(SUBSTR(SQLERRM, 1, 100));
END customer_roster;



--Question #7b

EXEC customer_roster('GA');

/* Q7b Query Results

Residential Customer          Macon                         GA                  Vanderhoff, Rosemary
Residential Customer          Nahunta                       GA                  Malady, Frank       
Family Medical Center         Adel                          GA                  Strong, Susan       
Down Deep Drilling Inc.       Elberton                      GA                  Torres, Don         
Residential Customer          Swainsboro                    GA                  Osborne, Shirley    
Residential Customer          Athens                        GA                  Thompson, Jamie
*/



--Question #8a

CREATE OR REPLACE PROCEDURE customer_search
(p_name IN VARCHAR2)
AS
    CURSOR all_customers
    IS
        SELECT NVL(companyname, 'Residential Customer') AS company_name, custfirstname, custlastname, custtitle
        FROM customer
        WHERE UPPER(TRIM(custlastname)) LIKE '%' || UPPER(TRIM(p_name)) || '%';
        
        current_customer all_customers%ROWTYPE;
BEGIN
    OPEN all_customers;
    FETCH all_customers INTO current_customer;
    WHILE all_customers%FOUND LOOP
        dbms_output.put(RPAD(current_customer.custtitle, 5, ' '));
        dbms_output.put(RPAD(current_customer.custfirstname, 15, ' '));
        dbms_output.put(RPAD(current_customer.custlastname, 15, ' '));
        dbms_output.put_line(RPAD(current_customer.company_name, 20, ' '));
        FETCH all_customers INTO current_customer;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put(SQLCODE);
        dbms_output.put(': ');
        dbms_output.put_line(SUBSTR(SQLERRM, 1, 100));
END customer_search;

--Question #8b

EXEC customer_search('NA');

/* Q8b Query Results

Mr.  Daniel         Hundnall       Bobs Repair Service 
Ms.  Jessica        Nakamura       Automart            
Dr.  Dorlan         Bresnaham      Residential Customer
Mr.  Jay            Hanau          Residential Customer
Mr.  Matt           Nakanishi      Residential Customer
Mr.  Jim            Manaugh        Residential Customer
*/




--Question #8c

CREATE OR REPLACE PROCEDURE customer_search
(p_name IN VARCHAR2)
AS
    CURSOR all_customers
    IS
        SELECT NVL(companyname, 'Residential Customer') AS company_name, custfirstname, custlastname, custtitle
        FROM customer
        WHERE UPPER(TRIM(custlastname)) LIKE '%' || UPPER(TRIM(p_name)) || '%' OR UPPER(TRIM(custfirstname)) LIKE '%' || UPPER(TRIM(p_name)) || '%';
        
        current_customer all_customers%ROWTYPE;
BEGIN
    OPEN all_customers;
    FETCH all_customers INTO current_customer;
    WHILE all_customers%FOUND LOOP
        dbms_output.put(RPAD(current_customer.custtitle, 5, ' '));
        dbms_output.put(RPAD(current_customer.custfirstname, 15, ' '));
        dbms_output.put(RPAD(current_customer.custlastname, 15, ' '));
        dbms_output.put_line(RPAD(current_customer.company_name, 20, ' '));
        FETCH all_customers INTO current_customer;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put(SQLCODE);
        dbms_output.put(': ');
        dbms_output.put_line(SUBSTR(SQLERRM, 1, 100));
END customer_search;



--Question #8d

EXEC customer_search('na');

/* Q8d Query Results

Mr.  Daniel         Hundnall       Bobs Repair Service 
Ms.  Jessica        Nakamura       Automart            
Dr.  Anna           Mayton         Residential Customer
Mr.  Ronald         Miller         Residential Customer
Dr.  Dorlan         Bresnaham      Residential Customer
Ms.  Verna          McGrew         Residential Customer
Mrs. Christina      Wilson         Residential Customer
Mr.  Jay            Hanau          Residential Customer
Mr.  Matt           Nakanishi      Residential Customer
Mrs. Nancy          Basham         Residential Customer
Mr.  Jim            Manaugh        Residential Customer
Mr.  Jonathon       Blanco         Residential Customer
*/



--Question #8e

CREATE OR REPLACE PROCEDURE customer_search
(p_name IN VARCHAR2)
AS

BEGIN
    FOR current_customer IN(
        SELECT NVL(companyname, 'Residential Customer') AS company_name, custfirstname, custlastname, custtitle 
        FROM customer
        WHERE UPPER(TRIM(custlastname)) LIKE '%' || UPPER(TRIM(p_name)) || '%' OR UPPER(TRIM(custfirstname)) LIKE '%' || UPPER(TRIM(p_name)) || '%') LOOP
    
        dbms_output.put(RPAD(current_customer.custtitle, 5, ' '));
        dbms_output.put(RPAD(current_customer.custfirstname, 15, ' '));
        dbms_output.put(RPAD(current_customer.custlastname, 15, ' '));
        dbms_output.put_line(RPAD(current_customer.company_name, 20, ' '));
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put(SQLCODE);
        dbms_output.put(': ');
        dbms_output.put_line(SUBSTR(SQLERRM, 1, 100));
END customer_search;



--Question #8f

EXEC customer_search('na');

/* Q8f Query Results

Mr.  Daniel         Hundnall       Bobs Repair Service 
Ms.  Jessica        Nakamura       Automart            
Dr.  Anna           Mayton         Residential Customer
Mr.  Ronald         Miller         Residential Customer
Dr.  Dorlan         Bresnaham      Residential Customer
Ms.  Verna          McGrew         Residential Customer
Mrs. Christina      Wilson         Residential Customer
Mr.  Jay            Hanau          Residential Customer
Mr.  Matt           Nakanishi      Residential Customer
Mrs. Nancy          Basham         Residential Customer
Mr.  Jim            Manaugh        Residential Customer
Mr.  Jonathon       Blanco         Residential Customer
*/