/*
Jack Mahedy
CNIT 372 Lab section 007
Estimated Time Spent: 10hrs
Late Hours Used: 0
*/

--Question #1

/*
1. FROM BOOKSHELF
2. WHERE RATING>1
3. GROUP BY CATEGORY_NAME
4. HAVING CATEGORY_NAME LIKE ‘A%’
5. SELECT NAME, COUNT(*), AVG(RATING)
6. ORDER BY COUNT(*);
*/


--Question #2

SELECT DISTINCT SUBSTR(phone, 1, 3)
FROM customer
WHERE state = 'CO';

/* Q2 Query Results

SUB
---
719
970
728
644
720
*/


--Question #3

SELECT SUBSTR(phone, 1, 3), COUNT(customerid) AS "Count"
FROM customer
WHERE state = 'CO'
GROUP BY SUBSTR(phone, 1, 3)
ORDER BY COUNT(customerid) DESC;

/* Q3 Query Results

SUB      Count
--- ----------
719          4
970          2
644          1
720          1
728          1
*/


--Question #4

SELECT SUBSTR(phone, 1, 3)
FROM customer
WHERE state = 'CO'
GROUP BY SUBSTR(phone, 1, 3)
HAVING COUNT(customerid) = (SELECT MAX(COUNT(customerid))
                            FROM customer
                            WHERE state = 'CO'
                            GROUP BY SUBSTR(phone, 1, 3));
                                  
/* Q4 Query Results

SUB
---
719
*/


--Question #5

SELECT (custlastname || ',' || custfirstname) AS "Name", city, state, phone
FROM customer
WHERE SUBSTR(phone, 1, 3) = (SELECT SUBSTR(phone, 1, 3)
                             FROM customer
                             WHERE state = 'CO'
                             GROUP BY SUBSTR(phone, 1, 3)
                             HAVING COUNT(customerid) = (SELECT MAX(COUNT(customerid))
                                                         FROM customer
                                                         WHERE state = 'CO'
                                                         GROUP BY SUBSTR(phone, 1, 3)));
                                                          

/* Q5 Query Results

Name                                 CITY                 ST PHONE       
------------------------------------ -------------------- -- ------------
Rodkey,Daniel                        Lamar                CO 719-748-3205
Kaakeh,Paul                          Gunnison             CO 719-750-4539
Smith,Matt                           Montrose             CO 719-822-8828
Rice,Paul                            Craig                CO 719-541-1837
*/


--Question #6
/*
When we know the area that has the most customers, we can shift the business advertisements to 
effect the people that live there since they are the biggest audience. We can also use the area code number
can cold call other people in that area becasue they might know someone who uses our business.
*/


--Question #7

SELECT customerid, COUNT(orderid)
FROM custorder
WHERE orderdate BETWEEN '01-AUG-10' AND '31-AUG-10'
GROUP BY customerid
ORDER BY COUNT(orderid) DESC;

/* Q7 Query Results

CUSTOMERID COUNT(ORDERID)
---------- --------------
C-300006                3
I-300016                2
C-300041                2
C-300031                2
I-300015                2
C-300055                2
I-300010                2
C-300005                2
C-300027                2
I-300014                2
I-300070                1

CUSTOMERID COUNT(ORDERID)
---------- --------------
C-300017                1
I-300031                1
I-300126                1
C-300001                1
I-300091                1
I-300020                1
C-300011                1
I-300069                1
C-300033                1
I-300024                1
I-300117                1

CUSTOMERID COUNT(ORDERID)
---------- --------------
C-300002                1
I-300132                1
I-300005                1
C-300010                1
I-300122                1
C-300013                1
C-300053                1
I-300068                1
C-300020                1
I-300096                1
I-300120                1

CUSTOMERID COUNT(ORDERID)
---------- --------------
I-300112                1
I-300115                1
I-300076                1
C-300035                1
I-300012                1
I-300095                1
I-300017                1
I-300026                1
I-300042                1
I-300097                1
I-300093                1

CUSTOMERID COUNT(ORDERID)
---------- --------------
I-300102                1
I-300007                1
I-300138                1
I-300043                1
I-300108                1
I-300044                1
I-300110                1
C-300051                1
I-300009                1
C-300004                1
C-300026                1

CUSTOMERID COUNT(ORDERID)
---------- --------------
C-300003                1
I-300004                1
I-300025                1
I-300129                1
I-300002                1
I-300011                1
I-300081                1
I-300088                1
I-300013                1
I-300061                1
I-300018                1

66 rows selected.
*/


--Question #8

SELECT COUNT(orderid)
FROM custorder
WHERE orderdate BETWEEN '01-AUG-10' AND '31-AUG-10'
GROUP BY customerid
HAVING COUNT(orderid) = (SELECT MAX(COUNT(orderid))
                         FROM custorder
                         WHERE orderdate BETWEEN '01-AUG-10' AND '31-AUG-10'
                         GROUP BY customerid);

/* Q8 Query Results

COUNT(ORDERID)
--------------
             3
*/


--Question #9

SELECT customerid, COUNT(orderid)
FROM custorder
WHERE orderdate BETWEEN '01-AUG-10' AND '31-AUG-10'
GROUP BY customerid
HAVING COUNT(orderid) = (SELECT MAX(COUNT(orderid))
                         FROM custorder
                         WHERE orderdate BETWEEN '01-AUG-10' AND '31-AUG-10'
                         GROUP BY customerid);

/* Q9 Query Results

CUSTOMERID COUNT(ORDERID)
---------- --------------
C-300006                3
*/


--Question #10

SELECT customerid, count(orderid)
FROM custorder
WHERE orderdate BETWEEN '01-AUG-10' AND '31-AUG-10'
GROUP BY customerid
HAVING COUNT(orderid) > (SELECT AVG(COUNT(orderid))
                         FROM custorder
                         WHERE orderdate BETWEEN '01-AUG-10' AND '31-AUG-10'
                         GROUP BY customerid)
ORDER BY COUNT(orderid) DESC;               

/* Q10 Query Results

CUSTOMERID COUNT(ORDERID)
---------- --------------
C-300006                3
I-300016                2
C-300041                2
C-300031                2
I-300015                2
C-300055                2
I-300010                2
C-300005                2
C-300027                2
I-300014                2

10 rows selected. 
*/


--Question #11

SELECT customerid, count(orderid)
FROM custorder
WHERE orderdate BETWEEN '01-AUG-10' AND '31-AUG-10'
GROUP BY customerid
HAVING COUNT(orderid) < (SELECT AVG(COUNT(orderid))
                         FROM custorder
                         WHERE orderdate BETWEEN '01-AUG-10' AND '31-AUG-10'
                         GROUP BY customerid)
ORDER BY COUNT(orderid) ASC;

/* Q11 Query Results

CUSTOMERID COUNT(ORDERID)
---------- --------------
I-300070                1
I-300018                1
I-300031                1
I-300126                1
C-300001                1
I-300091                1
I-300020                1
C-300011                1
I-300069                1
C-300033                1
I-300024                1

CUSTOMERID COUNT(ORDERID)
---------- --------------
I-300117                1
C-300002                1
I-300132                1
I-300005                1
C-300010                1
I-300122                1
C-300013                1
C-300053                1
I-300068                1
C-300020                1
I-300096                1

CUSTOMERID COUNT(ORDERID)
---------- --------------
I-300120                1
I-300112                1
I-300115                1
I-300076                1
C-300035                1
I-300012                1
I-300095                1
I-300017                1
I-300026                1
I-300042                1
I-300097                1

CUSTOMERID COUNT(ORDERID)
---------- --------------
I-300093                1
I-300102                1
I-300007                1
I-300138                1
I-300043                1
I-300108                1
I-300044                1
I-300110                1
C-300051                1
I-300009                1
C-300004                1

CUSTOMERID COUNT(ORDERID)
---------- --------------
C-300026                1
C-300003                1
I-300004                1
I-300025                1
I-300129                1
I-300002                1
I-300011                1
I-300081                1
I-300088                1
I-300013                1
I-300061                1

CUSTOMERID COUNT(ORDERID)
---------- --------------
C-300017                1

56 rows selected.
*/


--Question #12
/* 
If you know which customers are above and below the average you can say that the above 
average are loyal customers and then give them a discount to show your gratitude.
You can do other things with the below average customers to try to gain their loyalty.
*/


--Question #13

SELECT c.customerid, c.companyname, (c.custlastname || ',' || c.custfirstname) as "Name", to_char(orderdate, 'mm.dd.yyyy') AS "Date"
FROM customer c INNER JOIN custorder co
ON c.customerid = co.customerid
WHERE co.orderdate BETWEEN '01-JAN-10' AND '31-DEC-10' AND c.state = 'IN'
ORDER BY co.orderdate ASC;

/* Q13 Query Results

CUSTOMERID COMPANYNAME                              Name                                 Date      
---------- ---------------------------------------- ------------------------------------ ----------
C-300001   Baker and Company                        Abbott,Gregory                       07.08.2010
C-300001   Baker and Company                        Abbott,Gregory                       07.14.2010
C-300001   Baker and Company                        Abbott,Gregory                       08.13.2010
I-300030                                            Quintero,Eric                        09.15.2010
C-300014   R and R Air                              Bending,Cathy                        10.04.2010
C-300001   Baker and Company                        Abbott,Gregory                       12.02.2010
I-300147                                            Yaun,Steven                          12.07.2010

7 rows selected.
*/


--Question #14

SELECT companyname, (custtitle || ' ' || SUBSTR(custlastname, 1, 1) || '. ' || custfirstname) AS "NAME", orderdate, requireddate
FROM customer c INNER JOIN custorder co
ON c.customerid = co.customerid
WHERE c.customerid LIKE 'C-300001'
ORDER BY orderdate ASC;

/* Q14 Query Results

COMPANYNAME                              NAME                     ORDERDATE REQUIREDD
---------------------------------------- ------------------------ --------- ---------
Baker and Company                        Mr. A. Gregory           08-JUL-10 12-JUL-10
Baker and Company                        Mr. A. Gregory           14-JUL-10 15-JUL-10
Baker and Company                        Mr. A. Gregory           13-AUG-10 20-AUG-10
Baker and Company                        Mr. A. Gregory           02-DEC-10 08-DEC-10
Baker and Company                        Mr. A. Gregory           27-JAN-11 03-FEB-11
Baker and Company                        Mr. A. Gregory           24-FEB-11 03-MAR-11
Baker and Company                        Mr. A. Gregory           10-MAR-11 15-MAR-11
*/


--Question #15

SELECT col.orderid, ip.partnumber, ip.partdescription, col.unitprice, col.orderquantity, c.categoryname
FROM category c INNER JOIN inventorypart ip
ON c.categoryid = ip.categoryid
INNER JOIN custorderline col
ON ip.partnumber = col.partnumber
WHERE partdescription LIKE '%BOARD GAMES%'
ORDER BY col.orderquantity DESC;

/* Q15 Query Results

ORDERID    PARTNUMBER PARTDESCRIPTION                                     UNITPRICE ORDERQUANTITY CATEGORYNAME                  
---------- ---------- -------------------------------------------------- ---------- ------------- ------------------------------
2001000536 SFT-005    BOARD GAMES                                              9.99            15 Software                      
2000000050 SFT-005    BOARD GAMES                                              9.99            14 Software                      
2000000279 SFT-005    BOARD GAMES                                              9.99            10 Software                      
2000000426 SFT-005    BOARD GAMES                                              9.99            10 Software                      
2000000139 SFT-005    BOARD GAMES                                              9.99             2 Software                      
2000000348 SFT-005    BOARD GAMES                                              9.99             2 Software                      
2000000362 SFT-005    BOARD GAMES                                              9.99             1 Software                      
2000000005 SFT-005    BOARD GAMES                                              9.99             1 Software                      
2000000436 SFT-005    BOARD GAMES                                              9.99             1 Software                      
2001000722 SFT-005    BOARD GAMES                                              9.99             1 Software                      
2000000206 SFT-005    BOARD GAMES                                              9.99             1 Software                      

ORDERID    PARTNUMBER PARTDESCRIPTION                                     UNITPRICE ORDERQUANTITY CATEGORYNAME                  
---------- ---------- -------------------------------------------------- ---------- ------------- ------------------------------
2001000600 SFT-005    BOARD GAMES                                              9.99             1 Software                      
2000000011 SFT-005    BOARD GAMES                                              9.99             1 Software                      
2000000040 SFT-005    BOARD GAMES                                              9.99             1 Software                      

14 rows selected.
*/


--Question #16

SELECT col.orderid, ip.partnumber, ip.partdescription, col.unitprice, col.orderquantity
FROM inventorypart ip INNER JOIN custorderline col
ON ip.partnumber = col.partnumber
INNER JOIN custorder co
ON co.orderid = col.orderid
WHERE co.customerid LIKE '%C-300001%' AND co.orderdate BETWEEN '14-JUL-10' AND '14-JUL-10'
ORDER BY col.orderquantity DESC;

/* Q16 Query Results

ORDERID    PARTNUMBER PARTDESCRIPTION                                     UNITPRICE ORDERQUANTITY
---------- ---------- -------------------------------------------------- ---------- -------------
2000000032 BRK-011    2ND PARALLEL PORT                                        5.99            20
2000000032 CTR-019    FLY XPST                                              1717.99             9
2000000032 ADT-003    EXTERNAL SCSI-3 MALE TERMINATOR                         39.99             8
2000000032 CAB-027    2FT 3/1 SCSI CABLE                                      44.99             6
2000000032 SCN-002    SCANJET BUSINESS SERIES COLOR SCANNER                     249             4
*/


--Question #17

SELECT TO_CHAR(co.orderdate,'MM.DD.YYYY') AS "Date", co.orderid, ip.partnumber, ip.partdescription, col.unitprice, col.orderquantity
FROM customer c INNER JOIN custorder co
ON c.customerid = co.customerid
INNER JOIN custorderline col
ON co.orderid = col.orderid
INNER JOIN inventorypart ip
ON ip.partnumber = col.partnumber
WHERE c.companyname LIKE '%Bankruptcy Help%' AND co.orderdate BETWEEN '01-JAN-11' AND '31-DEC-11'
ORDER BY co.orderdate DESC, col.orderquantity DESC;

/* Q17 Query Results

Date       ORDERID    PARTNUMBER PARTDESCRIPTION                                     UNITPRICE ORDERQUANTITY
---------- ---------- ---------- -------------------------------------------------- ---------- -------------
03.22.2011 2001000778 BRK-002    1X4 USB CABLE AND BRACKET                                9.99            20
03.22.2011 2001000778 MEM-004    30.7GB HARD DRIVE                                      269.99            10
03.22.2011 2001000778 P-006      600 PENTIUM III PROCESSOR                              339.99             6
02.28.2011 2001000699 MOD-002    112K DUAL MODEM                                         89.99            16
02.28.2011 2001000699 MEM-001    2MB FLASH BUFFER MEMORY                                259.95            12
02.28.2011 2001000699 PRT-003    LASER JET 2500SE                                          699             3
02.24.2011 2001000676 MIC-009    WHEEL MOUSE                                              29.5            27
02.14.2011 2001000622 BB-004     SOCKET MINI BAREBONE                                   199.99             6
02.14.2011 2001000622 P-005      700 PENTIUM III PROCESSOR                              399.99             4

9 rows selected.
*/


--Question #18

SELECT TO_CHAR(co.orderdate,'MM.DD.YYYY') AS "Date", co.orderid, ip.partnumber, ip.partdescription, (col.unitprice * col.orderquantity) AS "Line_ITEM_TOTAL"
FROM customer c INNER JOIN custorder co
ON c.customerid = co.customerid
INNER JOIN custorderline col
ON co.orderid = col.orderid
INNER JOIN inventorypart ip
ON ip.partnumber = col.partnumber
WHERE c.companyname LIKE '%Bankruptcy Help%' AND co.orderdate BETWEEN '01-JAN-11' AND '31-DEC-11'
ORDER BY co.orderdate DESC, col.orderquantity DESC;

/* Q18 Query Results

Date       ORDERID    PARTNUMBER PARTDESCRIPTION                                    Line_ITEM_TOTAL
---------- ---------- ---------- -------------------------------------------------- ---------------
03.22.2011 2001000778 BRK-002    1X4 USB CABLE AND BRACKET                                    199.8
03.22.2011 2001000778 MEM-004    30.7GB HARD DRIVE                                           2699.9
03.22.2011 2001000778 P-006      600 PENTIUM III PROCESSOR                                  2039.94
02.28.2011 2001000699 MOD-002    112K DUAL MODEM                                            1439.84
02.28.2011 2001000699 MEM-001    2MB FLASH BUFFER MEMORY                                     3119.4
02.28.2011 2001000699 PRT-003    LASER JET 2500SE                                              2097
02.24.2011 2001000676 MIC-009    WHEEL MOUSE                                                  796.5
02.14.2011 2001000622 BB-004     SOCKET MINI BAREBONE                                       1199.94
02.14.2011 2001000622 P-005      700 PENTIUM III PROCESSOR                                  1599.96

9 rows selected.
*/


--Question #19

SELECT c.customerid, c.companyname, (c.custlastname ||', '|| c.custfirstname) AS "NAME", COUNT(c.customerid) AS "Count"
FROM customer c INNER JOIN custorder co
ON c.customerid = co.customerid
WHERE c.state = 'IN' AND co.orderdate BETWEEN '01-JAN-11' AND '31-JAN-11'
GROUP BY c.customerid, c.companyname, c.custlastname, c.custfirstname
ORDER BY COUNT(c.customerid);

/* Q19 Query Results

CUSTOMERID COMPANYNAME                              NAME                                       Count
---------- ---------------------------------------- ------------------------------------- ----------
C-300001   Baker and Company                        Abbott, Gregory                                1
C-300014   R and R Air                              Bending, Cathy                                 1
I-300030                                            Quintero, Eric                                 2
*/


--Question #20

SELECT c.categoryname, CAST(AVG(ip.stocklevel) AS DECIMAL(10,2)) AS "STOCK_AVG"
FROM category c INNER JOIN inventorypart ip
ON c.categoryid = ip.categoryid
GROUP BY c.categoryname
ORDER BY AVG(ip.stocklevel);

/* Q20 Query Results

CATEGORYNAME                    STOCK_AVG
------------------------------ ----------
Computers                            2.45
Accessories                          9.21
Power                                10.5
Storage                             20.47
Basics                               20.5
Processors                          23.74
Software                            33.89
Cables                              35.86

8 rows selected.
*/


--Question #21

SELECT (c.categoryname || ': ' || c.description) AS "CATEGORY_DETAIL", COUNT(ip.partdescription) AS "NUMBER_PART_TYPES"
FROM category c INNER JOIN inventorypart ip
ON c.categoryid = ip.categoryid
GROUP BY c.categoryname, c.description
ORDER BY COUNT(ip.partdescription);

/* Q21 Query Results

CATEGORY_DETAIL                                                                                                                      NUMBER_PART_TYPES
------------------------------------------------------------------------------------------------------------------------------------ -----------------
Power: Power Supplies                                                                                                                                4
Software: Games, maps                                                                                                                                9
Accessories: Scanners, Printers, Modems                                                                                                             14
Storage: CD-ROM, DVD, Hard Drives, Memory                                                                                                           19
Processors: Athlon, Celeron, Pentium, Fans                                                                                                          19
Computers: Assembled Computers                                                                                                                      29
Cables: Printer, Keyboard, Internal, SCSI, Connectors, Brackets                                                                                     36
Basics: Casing, Barebone, Monitors, Keyboards, Mice                                                                                                 44

8 rows selected.
*/


--Question #22

SELECT MAX(ip.weight) AS "WEIGHT"
FROM category c INNER JOIN inventorypart ip
ON c.categoryid = ip.categoryid
WHERE c.categoryname LIKE 'Software';

/* Q22 Query Results

WEIGHT
----------
      .438
*/


--Question #23

SELECT c.categoryname, MAX(ip.weight) AS "WEIGHT"
FROM category c INNER JOIN inventorypart ip
ON c.categoryid = ip.categoryid
WHERE c.categoryname LIKE 'Power' OR c.categoryname LIKE 'Software' OR c.categoryname LIKE 'Storage'
GROUP BY c.categoryname
ORDER BY c.categoryname ASC;

/* Q23 Query Results

CATEGORYNAME                       WEIGHT
------------------------------ ----------
Power                                   3
Software                             .438
Storage                                 4
*/


--Question #24

SELECT c.categoryname, MAX(ip.weight), ip.partdescription
FROM category c INNER JOIN inventorypart ip
ON c.categoryid = ip.categoryid
WHERE c.categoryname LIKE 'Power' OR c.categoryname LIKE 'Software' OR c.categoryname LIKE 'Storage'
GROUP BY c.categoryname, ip.partdescription
HAVING MAX(weight) IN (SELECT MAX(ip.weight)
                       FROM category c INNER JOIN inventorypart ip
                       ON c.categoryid = ip.categoryid
                       WHERE c.categoryname LIKE 'Power') OR MAX(weight) IN (SELECT MAX(ip.weight)
                                                                             FROM category c INNER JOIN inventorypart ip
                                                                             ON c.categoryid = ip.categoryid
                                                                             WHERE c.categoryname LIKE 'Software') OR MAX(weight) IN (SELECT MAX(ip.weight)
                                                                                                                                      FROM category c INNER JOIN inventorypart ip
                                                                                                                                      ON c.categoryid = ip.categoryid
                                                                                                                                      WHERE c.categoryname LIKE 'Storage')                   
ORDER BY c.categoryname ASC;

/* Q24 Query Results

CATEGORYNAME                   MAX(IP.WEIGHT) PARTDESCRIPTION                                   
------------------------------ -------------- --------------------------------------------------
Power                                       3 250 WATT POWER SUPPLY                             
Power                                       3 300 WATT POWER SUPPLY                             
Software                                 .438 BOARD GAMES                                       
Software                                 .438 DESKTOP PUBLISHER                                 
Storage                                     3 30.7GB HARD DRIVE                                 
Storage                                     4 ETHERNET FIBER OPTIC MINI-TRANSCEIVER             

6 rows selected.
*/


--Question #25
/*
To make the statement run faster I could try to avoid nested querys and avoid using Or in joins.
The time difference is very small, it will not make a big difference. 
*/