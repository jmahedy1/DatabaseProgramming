/*
Jack Mahedy
CNIT 372 Lab section 007
Estimated Time Spent: 8hrs
Late Hours Used: 0
*/

--Question #1

SELECT ip.partnumber, partdescription, ROUND(AVG(orderquantity), 1) AS "AVG_QUANTITY"
FROM inventorypart ip INNER JOIN custorderline col
ON ip.partnumber = col.partnumber
WHERE categoryid LIKE 'ACCESS'
GROUP BY ip.partnumber, partdescription
ORDER BY AVG(orderquantity) DESC;

/* Q1 Query Results

PARTNUMBER PARTDESCRIPTION                                    AVG_QUANTITY
---------- -------------------------------------------------- ------------
MOD-001    PCI DATA/FAX/VOICE MODEM                                    8.3
MOD-002    112K DUAL MODEM                                             5.1
PRT-006    SINGLEHEAD THERMAL INKJET PRINTER                           3.8
PRT-004    3-IN-1 COLOR INKJET PRINTER                                 3.6
SCN-002    SCANJET BUSINESS SERIES COLOR SCANNER                       3.5
PRT-003    LASER JET 2500SE                                            3.4
MOD-005    V.90/K56 FLEX 56K FAX MODEM                                 3.1
PRT-001    LASER JET 1999SE                                            2.9
MOD-003    PCI MODEM                                                   2.4
PRT-002    LASER JET 2000SE                                            2.3
SCN-001    SCANJET CSE COLOR SCANNER                                   1.8

PARTNUMBER PARTDESCRIPTION                                    AVG_QUANTITY
---------- -------------------------------------------------- ------------
MOD-004    PCI V.90 DATA/FAX/VOICE MODEM                               1.6

12 rows selected.
*/

--Question #2a

SELECT TO_CHAR(orderdate, 'mm') AS "MONTH", TO_CHAR(orderdate, 'yyyy') AS "YEAR", ROUND(AVG(orderquantity), 1) AS "AVG_QUANT"
FROM custorder co INNER JOIN custorderline col
ON co.orderid = col.orderid
WHERE partnumber LIKE 'DVD-001'
GROUP BY TO_CHAR(orderdate, 'mm'), TO_CHAR(orderdate, 'yyyy')
ORDER BY TO_CHAR(orderdate, 'yyyy'), TO_CHAR(orderdate, 'mm');

/* Q2a Query Results

MO YEAR  AVG_QUANT
-- ---- ----------
07 2010        1.5
09 2010          4
10 2010          1
11 2010          2
12 2010          1
01 2011          1
02 2011          8
03 2011          1

8 rows selected.
*/

--Question #2b
/* 
The average was around 1, but there were spikes in spetember of 2010 and februrary of 2011. The spikes were 4 and 8 
respectively. We do not currently know the type of company, but from the information from 2a we could say that this 
comapny sells romantic relationship things since there was a huge spike in Feb. (Valentines day).
*/

--Question #3a

SELECT (TO_CHAR(orderdate, 'mm')||'-'||TO_CHAR(orderdate, 'yyyy')) AS "DATE", ROUND(SUM(orderquantity), 1) AS "TOTAL_QUANT"
FROM custorder co INNER JOIN custorderline col
ON co.orderid = col.orderid
WHERE partnumber LIKE 'DVD-001'
GROUP BY TO_CHAR(orderdate, 'mm'), TO_CHAR(orderdate, 'yyyy')
ORDER BY TO_CHAR(orderdate, 'yyyy'), TO_CHAR(orderdate, 'mm');

/* Q3a Query Results

DATE    TOTAL_QUANT
------- -----------
07-2010           3
09-2010          12
10-2010           1
11-2010           4
12-2010           3
01-2011           1
02-2011          16
03-2011           1

8 rows selected.
*/

--Question #3b
/* 
I would not produce a lot of DVD-001 from April to August, but then in September I would produce a lot of it to 
prepare for the demand.
*/

--Question #4

SELECT TO_CHAR(orderdate, 'mm') AS "MONTH", TO_CHAR(orderdate, 'yyyy') AS "YEAR", COUNT(co.orderid) AS "COUNT"
FROM custorder co INNER JOIN custorderline col
ON co.orderid = col.orderid
WHERE partnumber LIKE 'DVD-001'
GROUP BY TO_CHAR(orderdate, 'mm'), TO_CHAR(orderdate, 'yyyy')
ORDER BY TO_CHAR(orderdate, 'yyyy'), TO_CHAR(orderdate, 'mm');

/* Q4 Query Results

MO YEAR      COUNT
-- ---- ----------
07 2010          2
09 2010          3
10 2010          1
11 2010          2
12 2010          3
01 2011          1
02 2011          2
03 2011          1

8 rows selected.
*/

--Question #5a
/*
In Q2 it get the average order quantity for each month. Q3 gets the total order quantity. Q4 gets the number 
of orders but not the amount of dvd-001 in the order. Q2 and Q3 share the idea that there are spikes in Sep. 
2010 and Feb. 2011.
*/

--Question #5b
/*
From all of the information we can say that a few individuals are placing the orders, but in Sep. 2010 and Feb. 2011 
the few people are getting a large quantitly in the same order.
*/

--Question #5c
/*
The answers from 2 and 3 support each other because we notice the spikes in the two months. Q4 conflicts with 2 
and 3 becasue it does not show the spike, but it does not decrease confidence. Q4 shows that there are few people 
that ordered a lot.
*/

--Question #6a

SELECT orderid, s.shipmentid, packagenumber, shippeddate, shipname, shipaddress
FROM shipment s INNER JOIN packingslip ps
ON s.shipmentid = ps.shipmentid
WHERE orderid LIKE '2000000007';

/* Q6a Query Results

ORDERID    SHIPMENTID PACKAGENUMBER SHIPPEDDA SHIPNAME             SHIPADDRESS                             
---------- ---------- ------------- --------- -------------------- ----------------------------------------
2000000007 H003                   1 05-JUL-10 Evelyn Cassens       6094 Pearson Ave.                       
2000000007 H003                   2 05-JUL-10 Evelyn Cassens       6094 Pearson Ave.                       
2000000007 H003                   3 05-JUL-10 Evelyn Cassens       6094 Pearson Ave.
*/

--Question #6b
/*
Q6 get all common rows that have the orderid 2000000007. One person got 3 different items in the same order (3 different boxes,
same order).
*/

--Question #7a

SELECT (custlastname ||', '|| custfirstname) AS "NAME", c.customerid, orderid
FROM customer c LEFT JOIN custorder co
ON c.customerid = co.customerid
WHERE companyname IS NULL AND state LIKE 'PA';

/* Q7a Query Results

NAME                                  CUSTOMERID ORDERID   
------------------------------------- ---------- ----------
Wolfe, Thomas                         I-300149   2001000670
Wolfe, Thomas                         I-300149   2001000736
Wolfe, Thomas                         I-300149   2001000751
Wolfe, Thomas                         I-300149   2001000768
Wolfe, Thomas                         I-300149   2000000497
Kaleta, Don                           I-300028             

6 rows selected.
*/

--Question #7b

SELECT (custlastname ||', '|| custfirstname) AS "NAME", c.customerid, orderid
FROM customer c RIGHT JOIN custorder co
ON c.customerid = co.customerid
WHERE companyname IS NULL AND state LIKE 'PA';

/* Q7b Query Results

NAME                                  CUSTOMERID ORDERID   
------------------------------------- ---------- ----------
Wolfe, Thomas                         I-300149   2001000670
Wolfe, Thomas                         I-300149   2001000736
Wolfe, Thomas                         I-300149   2001000751
Wolfe, Thomas                         I-300149   2001000768
Wolfe, Thomas                         I-300149   2000000497
*/

--Question #8

SELECT partnumber, categoryname
FROM category c FULL JOIN inventorypart ip
ON c.categoryid = ip.categoryid;

/* Q8 Query Results

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
ADT-001    Storage                       
ADT-002    Cables                        
ADT-003    Cables                        
ADT-004    Cables                        
ADT-005    Cables                        
ADT-006    Cables                        
ADT-007    Cables                        
BB-001     Basics                        
BB-002     Basics                        
BB-003     Basics                        
BB-004     Basics                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
BB-005     Basics                        
BRK-001    Cables                        
BRK-002    Cables                        
BRK-003    Cables                        
BRK-004    Cables                        
BRK-005    Cables                        
BRK-006    Cables                        
BRK-007    Cables                        
BRK-008    Cables                        
BRK-009    Cables                        
BRK-010    Cables                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
BRK-011    Cables                        
C-001      Basics                        
C-002      Basics                        
C-003      Basics                        
CAB-001    Cables                        
CAB-002    Cables                        
CAB-003    Cables                        
CAB-004    Cables                        
CAB-005    Cables                        
CAB-006    Cables                        
CAB-007    Cables                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
CAB-008    Cables                        
CAB-009                                  
CAB-010                                  
CAB-011                                  
CAB-012                                  
CAB-013                                  
CAB-014                                  
CAB-015                                  
CAB-016                                  
CAB-017                                  
CAB-018                                  

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
CAB-019                                  
CAB-020                                  
CAB-021                                  
CAB-022                                  
CAB-023                                  
CAB-024                                  
CAB-025                                  
CAB-026                                  
CAB-027                                  
CAB-028                                  
CD-001     Storage                       

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
CD-002     Storage                       
CD-003     Storage                       
CD-004     Storage                       
CF-001     Processors                    
CF-002     Processors                    
CF-003     Processors                    
CF-004     Processors                    
CF-005     Processors                    
CF-006     Processors                    
CF-007     Processors                    
CF-008     Processors                    

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
CF-009     Processors                    
CRD-001                                  
CRD-002                                  
CRD-003                                  
CRD-004                                  
CRD-005                                  
CRD-006                                  
CRD-007                                  
CRD-008                                  
CRD-009                                  
CTR-001    Computers                     

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
CTR-002    Computers                     
CTR-003    Computers                     
CTR-004    Computers                     
CTR-005    Computers                     
CTR-006    Computers                     
CTR-007    Computers                     
CTR-008    Computers                     
CTR-009    Computers                     
CTR-010    Computers                     
CTR-011    Computers                     
CTR-012    Computers                     

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
CTR-013    Computers                     
CTR-014    Computers                     
CTR-015    Computers                     
CTR-016    Computers                     
CTR-017    Computers                     
CTR-018    Computers                     
CTR-019    Computers                     
CTR-020    Computers                     
CTR-021    Computers                     
CTR-022    Computers                     
CTR-023    Computers                     

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
CTR-024    Computers                     
CTR-025    Computers                     
CTR-026    Computers                     
CTR-027    Computers                     
CTR-028    Computers                     
CTR-029    Computers                     
DVD-001    Storage                       
DVD-002    Storage                       
ICAB-001   Cables                        
ICAB-002   Cables                        
ICAB-003   Cables                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
ICAB-004   Cables                        
ICAB-005   Cables                        
ICAB-006   Cables                        
ICAB-007   Cables                        
ICAB-008   Cables                        
KEY-001    Basics                        
KEY-002    Basics                        
KEY-003    Basics                        
KEY-004    Basics                        
KEY-005    Basics                        
KEY-006    Basics                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
KEY-007    Basics                        
KEY-008    Basics                        
KEY-009    Basics                        
MEM-001    Storage                       
MEM-002    Storage                       
MEM-003    Storage                       
MEM-004    Storage                       
MEM-005    Storage                       
MEM-006    Storage                       
MEM-007    Storage                       
MEM-008    Storage                       

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
MEM-009    Storage                       
MEM-010    Storage                       
MEM-011    Storage                       
MEM-012    Storage                       
MIC-001    Basics                        
MIC-002    Basics                        
MIC-003    Basics                        
MIC-004    Basics                        
MIC-005    Basics                        
MIC-006    Basics                        
MIC-007    Basics                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
MIC-008    Basics                        
MIC-009    Basics                        
MIC-010    Basics                        
MIC-011    Basics                        
MIC-012    Basics                        
MOD-001    Accessories                   
MOD-002    Accessories                   
MOD-003    Accessories                   
MOD-004    Accessories                   
MOD-005    Accessories                   
MOM-001    Basics                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
MOM-002    Basics                        
MOM-003    Basics                        
MOM-004    Basics                        
MON-001    Basics                        
MON-002    Basics                        
MON-003    Basics                        
MON-004    Basics                        
MON-005    Basics                        
MON-006    Basics                        
MON-007    Basics                        
MON-008    Basics                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
P-001      Processors                    
P-002      Processors                    
P-003      Processors                    
P-004      Processors                    
P-005      Processors                    
P-006      Processors                    
P-007      Processors                    
P-008      Processors                    
P-009      Processors                    
P-010      Processors                    
POW-001    Cables                        

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
POW-002    Cables                        
POW-003    Cables                        
PRT-001    Accessories                   
PRT-002    Accessories                   
PRT-003    Accessories                   
PRT-004    Accessories                   
PRT-005    Accessories                   
PRT-006    Accessories                   
PS-001     Power                         
PS-002     Power                         
PS-003     Power                         

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
PS-004     Power                         
SCN-001    Accessories                   
SCN-002    Accessories                   
SCN-003    Accessories                   
SFT-001    Software                      
SFT-002    Software                      
SFT-003    Software                      
SFT-004    Software                      
SFT-005    Software                      
SFT-006    Software                      
SFT-007    Software                      

PARTNUMBER CATEGORYNAME                  
---------- ------------------------------
SFT-008    Software                      
SFT-009    Software                      
SP-001     Basics                        
SP-002     Basics                        
SP-003     Basics                        
           Tablets                       

204 rows selected.
*/

--Question #9a

SELECT (custfirstname ||' '|| custlastname) AS "NAME", c.customerid, orderdate, s.shipmentid, packagenumber, shipname, shippeddate
FROM customer c INNER JOIN custorder co
ON c.customerid = co.customerid
LEFT JOIN shipment s
ON co.orderid = s.orderid
LEFT JOIN packingslip ps
ON s.shipmentid = ps.shipmentid
WHERE co.orderid LIKE '%2001000807%';


/* Q9a Query Results

NAME                                 CUSTOMERID ORDERDATE SHIPMENTID PACKAGENUMBER SHIPNAME             SHIPPEDDA
------------------------------------ ---------- --------- ---------- ------------- -------------------- ---------
Cecil Scheetz                        C-300003   31-MAR-11 H384                     Cecil Scheetz
*/

--Question #9b

SELECT (custfirstname ||' '|| custlastname) AS "NAME", c.customerid, orderdate, s.shipmentid, shipname
FROM customer c INNER JOIN custorder co
ON c.customerid = co.customerid
FULL JOIN shipment s
ON co.orderid = s.orderid
FULL JOIN packingslip ps
ON s.shipmentid = ps.shipmentid
WHERE shippeddate IS NULL;

/* Q9b Query Results

NAME                                 CUSTOMERID ORDERDATE SHIPMENTID SHIPNAME            
------------------------------------ ---------- --------- ---------- --------------------
Mary Jo Wales                        I-300125   30-MAR-11 L261       Mary Jo Wales       
Orville Gilliland                    C-300069   30-MAR-11 H381       Orville Gilliland   
Verna McGrew                         I-300069   27-MAR-11 L257       Verna McGrew        
Shirley Osborne                      I-300013   30-MAR-11 M161       Shirley Osborne     
Zack Hill                            I-300120   23-FEB-11 M129       Zack Hill           
Archie Doremski                      C-300032   29-MAR-11 H380       Archie Doremski     
Louise Cool                          I-300044   13-MAR-11 M147       Louise Cool         
Daniel Rodkey                        I-300141   31-MAR-11 L262       Daniel Rodkey       
Larry Osmanova                       C-300026   30-MAR-11 H382       Larry Osmanova      
Andy Huegel                          I-300151   31-MAR-11 M162       Andy Huegel         
Marjorie Vandermay                   C-300045   31-MAR-11 H383       Marjorie Vandermay  

NAME                                 CUSTOMERID ORDERDATE SHIPMENTID SHIPNAME            
------------------------------------ ---------- --------- ---------- --------------------
Steven Yaun                          I-300147   27-MAR-11 L258       Michelle Oakley     
Cecil Scheetz                        C-300003   31-MAR-11 H384       Cecil Scheetz       
Joan Hedden                          I-300024   01-MAR-11 M137       Joan Hedden         
Phil Reece                           I-300154   29-MAR-11 M159       Phil Reece          
Karen Mangus                         I-300015   29-MAR-11 M160       Karen Mangus        
Tom Baker                            I-300134   29-MAR-11 L259       Tom Baker           
Charles Jones                        I-300087   30-MAR-11 L260       Charles Jones       

18 rows selected.
*/

--Question #10a

SELECT customerid
FROM customer
WHERE state LIKE 'PA'
INTERSECT
SELECT customerid
FROM custorder;

/* Q10a Query Results

CUSTOMERID
----------
C-300006
C-300040
C-300062
I-300149
*/

--Question #10b

SELECT customerid
FROM customer
WHERE state LIKE 'PA'
MINUS
SELECT customerid
FROM custorder;

/* Q10b Query Results

CUSTOMERID
----------
I-300028
*/

--Question #10c

SELECT customerid
FROM customer
WHERE state LIKE 'PA'
INTERSECT
SELECT customerid
FROM custorder
WHERE TO_CHAR(orderdate, 'yyyy') LIKE '2011';

/* Q10c Query Results

CUSTOMERID
----------
C-300006
C-300040
I-300149
*/

--Question #10d

SELECT customerid
FROM customer
WHERE state LIKE 'PA'
MINUS
SELECT customerid
FROM custorder
WHERE TO_CHAR(orderdate, 'yyyy') LIKE '2011';

/* Q10d Query Results

CUSTOMERID
----------
C-300062
I-300028
*/

--Question #11a

SELECT partnumber
FROM inventorypart
WHERE categoryid LIKE 'CAB'
INTERSECT
SELECT partnumber
FROM custorderline;

/* Q11a Query Results

PARTNUMBER
----------
ADT-003
ADT-004
ADT-005
ADT-006
ADT-007
BRK-001
BRK-002
BRK-003
BRK-004
BRK-005
BRK-007

PARTNUMBER
----------
BRK-008
BRK-009
BRK-010
BRK-011
CAB-001
CAB-003
CAB-005
CAB-006
CAB-007
CAB-008
ICAB-001

PARTNUMBER
----------
ICAB-002
ICAB-003
ICAB-004
ICAB-005
ICAB-006
ICAB-007
ICAB-008
POW-002
POW-003

31 rows selected.
*/

--Question #11b

SELECT partnumber
FROM inventorypart
WHERE categoryid LIKE 'CAB'
MINUS
SELECT partnumber
FROM custorderline;

/* Q11b Query Results

PARTNUMBER
----------
ADT-002
BRK-006
CAB-002
CAB-004
POW-001
*/

--Question #11c

SELECT partnumber
FROM inventorypart
WHERE categoryid LIKE 'CAB'
INTERSECT
SELECT partnumber
FROM custorderline
WHERE orderid IN (SELECT orderid
                  FROM custorder
                  WHERE CAST(TO_CHAR(orderdate, 'yyyy') AS INT) >= 2010);

/* Q11c Query Results

PARTNUMBER
----------
ADT-003
ADT-004
ADT-005
ADT-006
ADT-007
BRK-001
BRK-002
BRK-003
BRK-004
BRK-005
BRK-007

PARTNUMBER
----------
BRK-008
BRK-009
BRK-010
BRK-011
CAB-001
CAB-003
CAB-005
CAB-006
CAB-007
CAB-008
ICAB-001

PARTNUMBER
----------
ICAB-002
ICAB-003
ICAB-004
ICAB-005
ICAB-006
ICAB-007
ICAB-008
POW-002
POW-003

31 rows selected.
*/

--Question #11d

SELECT partnumber
FROM inventorypart
WHERE categoryid LIKE 'CAB'
MINUS
SELECT partnumber
FROM custorderline
WHERE orderid IN (SELECT orderid
                  FROM custorder
                  WHERE CAST(TO_CHAR(orderdate, 'yyyy') AS INT) >= 2010);

/* Q11d Query Results

PARTNUMBER
----------
ADT-002
BRK-006
CAB-002
CAB-004
POW-001
*/

--Question #12a

SELECT DISTINCT custfirstname, custlastname
FROM customer
WHERE state LIKE 'FL'
UNION 
SELECT DISTINCT firstname, lastname
FROM employee
ORDER BY custfirstname ASC, custlastname ASC;

/* Q12a Query Results

CUSTFIRSTNAME   CUSTLASTNAME        
--------------- --------------------
Allison         Roland              
Austin          Ortman              
Beth            Zobitz              
Calie           Zollman             
Charles         Jones               
David           Deppe               
David           Keck                
Edna            Lilley              
Gabrielle       Stevenson           
Gary            German              
Gregory         Hettinger           

CUSTFIRSTNAME   CUSTLASTNAME        
--------------- --------------------
Jack            Barrick             
Jack            Brose               
Jamie           Osman               
Jason           Krasner             
Jason           Wendling            
Jim             Manaugh             
Joanne          Rosner              
Joseph          Platt               
Karen           Mangus              
Kathleen        Xolo                
Kathryn         Deagen              

CUSTFIRSTNAME   CUSTLASTNAME        
--------------- --------------------
Kathy           Gunderson           
Kelly           Jordan              
Kristen         Gustavel            
Kristey         Moore               
Kristy          Moore               
Laura           Rodgers             
Marla           Reeder              
Meghan          Tyrie               
Melissa         Alvarez             
Michael         Abbott              
Michael         Emore               

CUSTFIRSTNAME   CUSTLASTNAME        
--------------- --------------------
Michelle        Nairn               
Nicholas        Albregts            
Patricha        Underwood           
Paul            Eckelman            
Phil            Reece               
Rita            Bush                
Ronald          Day                 
Ryan            Stahley             
Sherman         Cheswick            
Steve           Cochran             
Steve           Hess                

CUSTFIRSTNAME   CUSTLASTNAME        
--------------- --------------------
Steven          Hickman             
Tina            Yates               
Todd            Vigus               

47 rows selected.
*/

--Question #12b

SELECT custfirstname, custlastname
FROM customer
WHERE state LIKE 'FL'
UNION ALL
SELECT firstname, lastname
FROM employee
ORDER BY custfirstname ASC, custlastname ASC;

/* Q12b Query Results

CUSTFIRSTNAME   CUSTLASTNAME        
--------------- --------------------
Allison         Roland              
Allison         Roland              
Austin          Ortman              
Beth            Zobitz              
Calie           Zollman             
Charles         Jones               
Charles         Jones               
David           Deppe               
David           Keck                
Edna            Lilley              
Gabrielle       Stevenson           

CUSTFIRSTNAME   CUSTLASTNAME        
--------------- --------------------
Gary            German              
Gregory         Hettinger           
Jack            Barrick             
Jack            Brose               
Jamie           Osman               
Jason           Krasner             
Jason           Wendling            
Jim             Manaugh             
Jim             Manaugh             
Joanne          Rosner              
Joseph          Platt               

CUSTFIRSTNAME   CUSTLASTNAME        
--------------- --------------------
Karen           Mangus              
Kathleen        Xolo                
Kathryn         Deagen              
Kathy           Gunderson           
Kelly           Jordan              
Kristen         Gustavel            
Kristey         Moore               
Kristy          Moore               
Laura           Rodgers             
Marla           Reeder              
Meghan          Tyrie               

CUSTFIRSTNAME   CUSTLASTNAME        
--------------- --------------------
Melissa         Alvarez             
Michael         Abbott              
Michael         Emore               
Michelle        Nairn               
Nicholas        Albregts            
Patricha        Underwood           
Paul            Eckelman            
Phil            Reece               
Phil            Reece               
Rita            Bush                
Ronald          Day                 

CUSTFIRSTNAME   CUSTLASTNAME        
--------------- --------------------
Ryan            Stahley             
Ryan            Stahley             
Sherman         Cheswick            
Steve           Cochran             
Steve           Hess                
Steven          Hickman             
Tina            Yates               
Todd            Vigus               

52 rows selected.
*/

--Question #13a

SELECT (custfirstname ||' '|| custlastname ||', '|| 'Residential') AS "NAME", c.customerid, orderid, orderdate
FROM customer c INNER JOIN custorder co
ON c.customerid = co.customerid
WHERE state LIKE 'PA' AND companyname IS NULL
UNION
SELECT (custfirstname ||' '|| custlastname ||', '|| companyname), c.customerid, orderid, orderdate
FROM customer c INNER JOIN custorder co
ON c.customerid = co.customerid
WHERE state LIKE 'PA' AND companyname IS NOT NULL
ORDER BY customerid, orderid;

/* Q13a Query Results

NAME                                                                           CUSTOMERID ORDERID    ORDERDATE
------------------------------------------------------------------------------ ---------- ---------- ---------
George Purcell, BMA Advertising Design                                         C-300006   2000000050 26-JUL-10
George Purcell, BMA Advertising Design                                         C-300006   2000000083 10-AUG-10
George Purcell, BMA Advertising Design                                         C-300006   2000000110 20-AUG-10
George Purcell, BMA Advertising Design                                         C-300006   2000000130 27-AUG-10
George Purcell, BMA Advertising Design                                         C-300006   2000000355 01-DEC-10
George Purcell, BMA Advertising Design                                         C-300006   2001000643 17-FEB-11
George Purcell, BMA Advertising Design                                         C-300006   2001000729 07-MAR-11
Mildred Jones, Computer Consultants                                            C-300040   2000000012 06-JUL-10
Mildred Jones, Computer Consultants                                            C-300040   2000000284 02-NOV-10
Mildred Jones, Computer Consultants                                            C-300040   2001000721 03-MAR-11
Mildred Jones, Computer Consultants                                            C-300040   2001000782 23-MAR-11

NAME                                                                           CUSTOMERID ORDERID    ORDERDATE
------------------------------------------------------------------------------ ---------- ---------- ---------
Scott Gray, Security Installation                                              C-300062   2000000361 01-DEC-10
Scott Gray, Security Installation                                              C-300062   2000000421 10-DEC-10
Scott Gray, Security Installation                                              C-300062   2000000440 14-DEC-10
Scott Gray, Security Installation                                              C-300062   2000000496 17-DEC-10
Thomas Wolfe, Residential                                                      I-300149   2000000497 17-DEC-10
Thomas Wolfe, Residential                                                      I-300149   2001000670 23-FEB-11
Thomas Wolfe, Residential                                                      I-300149   2001000736 08-MAR-11
Thomas Wolfe, Residential                                                      I-300149   2001000751 13-MAR-11
Thomas Wolfe, Residential                                                      I-300149   2001000768 20-MAR-11

20 rows selected.
*/

--Question #13b

SELECT (custfirstname ||' '|| custlastname ||', '|| NVL(companyname, 'Residential')) AS "NAME", c.customerid, co.orderid, orderdate
FROM customer c INNER JOIN custorder co
ON c.customerid = co.customerid
WHERE state LIKE 'PA'
ORDER BY c.customerid, co.orderid;

/* Q13b Query Results

NAME                                                                           CUSTOMERID ORDERID    ORDERDATE
------------------------------------------------------------------------------ ---------- ---------- ---------
George Purcell, BMA Advertising Design                                         C-300006   2000000050 26-JUL-10
George Purcell, BMA Advertising Design                                         C-300006   2000000083 10-AUG-10
George Purcell, BMA Advertising Design                                         C-300006   2000000110 20-AUG-10
George Purcell, BMA Advertising Design                                         C-300006   2000000130 27-AUG-10
George Purcell, BMA Advertising Design                                         C-300006   2000000355 01-DEC-10
George Purcell, BMA Advertising Design                                         C-300006   2001000643 17-FEB-11
George Purcell, BMA Advertising Design                                         C-300006   2001000729 07-MAR-11
Mildred Jones, Computer Consultants                                            C-300040   2000000012 06-JUL-10
Mildred Jones, Computer Consultants                                            C-300040   2000000284 02-NOV-10
Mildred Jones, Computer Consultants                                            C-300040   2001000721 03-MAR-11
Mildred Jones, Computer Consultants                                            C-300040   2001000782 23-MAR-11

NAME                                                                           CUSTOMERID ORDERID    ORDERDATE
------------------------------------------------------------------------------ ---------- ---------- ---------
Scott Gray, Security Installation                                              C-300062   2000000361 01-DEC-10
Scott Gray, Security Installation                                              C-300062   2000000421 10-DEC-10
Scott Gray, Security Installation                                              C-300062   2000000440 14-DEC-10
Scott Gray, Security Installation                                              C-300062   2000000496 17-DEC-10
Thomas Wolfe, Residential                                                      I-300149   2000000497 17-DEC-10
Thomas Wolfe, Residential                                                      I-300149   2001000670 23-FEB-11
Thomas Wolfe, Residential                                                      I-300149   2001000736 08-MAR-11
Thomas Wolfe, Residential                                                      I-300149   2001000751 13-MAR-11
Thomas Wolfe, Residential                                                      I-300149   2001000768 20-MAR-11

20 rows selected.
*/

--Question #14a

--run entire 14a
DROP TABLE Lab2_CONTACT CASCADE CONSTRAINTS;    --drop the table from the databse incase it is created from other students

CREATE TABLE Lab2_CONTACT AS    --creted table with columns and data from the customer table
SELECT c1.custfirstname, c1.custlastname, c2.city, c2.state
FROM customer
CROSS JOIN (SELECT DISTINCT custfirstname, custlastname FROM customer) c1
CROSS JOIN (SELECT DISTINCT city, state FROM customer) c2;

/* Q14a Query Results

Table LAB2_CONTACT dropped.

Table LAB2_CONTACT created.
*/

--Question #14b

SELECT COUNT(*)
FROM lab2_contact;

SELECT COUNT(DISTINCT custfirstname), COUNT(DISTINCT custlastname), COUNT(DISTINCT city), COUNT(DISTINCT state)
FROM lab2_contact;

/* Q14b Query Results

  COUNT(*)
----------
  12112947
  
COUNT(DISTINCTCUSTFIRSTNAME) COUNT(DISTINCTCUSTLASTNAME) COUNT(DISTINCTCITY) COUNT(DISTINCTSTATE)
---------------------------- --------------------------- ------------------- --------------------
                         161                         220                 224                   50
*/