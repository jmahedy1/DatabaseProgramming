/*
Jack Mahedy
CNIT 372 Lab section 007
Estimated Time Spent: 1hr
Late Hours Used: 0
*/

--Question #1

select user
from dual;

/* Q1 Query Results

USER                                                                                                                            
--------------------------------------------------------------------------------------------------------------------------------
JMAHEDY
*/


--Question #2

select current_timestamp
from dual;

/* Q2 Query Results

CURRENT_TIMESTAMP                                           
------------------------------------------------------------
28-AUG-22 05.29.35.047840000 PM AMERICA/INDIANA/INDIANAPOLIS
*/


--Question #3

select count(customerid)
from customer
where companyname is not null;

/* Q3 Query Results

COUNT(CUSTOMERID)
-----------------
               74
*/


--Question #4

select count(customerid)
from customer
where companyname is null;

/* Q4 Query Results

COUNT(CUSTOMERID)
-----------------
              157
*/


--Question #5

select count(customerid)
from customer
where state = 'IN';

/* Q5 Query Results

COUNT(CUSTOMERID)
-----------------
                4
*/


--Question #6

select count(customerid)
from customer
where state = 'PA' and city = 'Scranton';

/* Q6 Query Results

COUNT(CUSTOMERID)
-----------------
                2
*/


--Question #7

select customerid, companyname, custlastname, custfirstname, phone, lower(emailaddr) as email
from customer
where state = 'MI' or state = 'IL'
order by custlastname asc;

/* Q7 Query Results

CUSTOMERID COMPANYNAME                              CUSTLASTNAME         CUSTFIRSTNAME   PHONE        EMAIL                                             
---------- ---------------------------------------- -------------------- --------------- ------------ --------------------------------------------------
I-300007                                            Cain                 Jessica         517-901-2610                                                   
C-300023   TAS                                      Dalury               Robert          906-278-6446 tas@zeronet.net                                   
I-300093                                            Hanau                Jay             773-490-8254                                                   
I-300031                                            Hession              Phillip         231-711-6837 howdy@usol.com                                    
C-300024   Bankruptcy Help                          Lichty               Jim             618-847-1904 bankrupt@usol.com                                 
I-300025                                            Miller               Ronald          734-820-2076 picky@zeronet.net                                 
C-300039   Gards Auto Repair                        Sammons              Dennis          616-544-1969 repairit@free.com                                 
I-300038                                            Smith                David           309-980-4350 emerald@onlineservice.com                         
I-300052                                            Yelnick              Andrew          517-803-5818 family@free.com                                   

9 rows selected. 
*/


--Question #8

select customerid, (custlastname ||','|| custfirstname) as "Full Name", phone
from customer
where companyname is null and state = 'OH';

/* Q8 Query Results

CUSTOMERID Full Name                            PHONE       
---------- ------------------------------------ ------------
I-300003   Hague,Carl                           419-890-3531
I-300039   Chang,David                          740-750-1272
I-300045   Kempf,Gary                           937-724-7313
I-300094   Schuman,Joseph                       330-209-1273
I-300119   Skadberg,John                        513-282-3919
*/


--Question #9

select customerid, substr(custfirstname, 1, 1) ||','|| custlastname as Name, phone, lower(emailaddr) as Email
from customer
where companyname is null and (state = 'IN' or state = 'OH')
order by custlastname desc;

/* Q9 Query Results

CUSTOMERID NAME                   PHONE        EMAIL                                             
---------- ---------------------- ------------ --------------------------------------------------
I-300147   S,Yaun                 317-780-9804 yawn@fast.com                                     
I-300119   J,Skadberg             513-282-3919 skad@zeronet.net                                  
I-300094   J,Schuman              330-209-1273                                                   
I-300030   E,Quintero             812-805-1588 diamond@onlineservice.com                         
I-300045   G,Kempf                937-724-7313 kempfg@free.com                                   
I-300003   C,Hague                419-890-3531                                                   
I-300039   D,Chang                740-750-1272 lion@free.com                                     

7 rows selected. 
*/


--Question #10

select distinct count(customerid)
from customer
where companyname is not null and state = 'OH';

/* Q10 Query Results

COUNT(CUSTOMERID)
-----------------
                2
*/


--Question #11

select companyname, count(address)
from customer
where companyname is not null and (state = 'IN' or state = 'IL')
group by companyname
order by companyname asc;

/* Q11 Query Results

COMPANYNAME                              COUNT(ADDRESS)
---------------------------------------- --------------
Baker and Company                                     1
Bankruptcy Help                                       1
R and R Air                                           1
*/


--Question #12

select customerid, companyname, (custfirstname ||' '|| custlastname) as "full name", phone
from customer
where state = 'CO'
order by phone asc;

/* Q12 Query Results

CUSTOMERID COMPANYNAME                              full name                            PHONE       
---------- ---------------------------------------- ------------------------------------ ------------
C-300031   Copy Center                              Allen Robles                         644-730-8090
I-300049                                            Paul Rice                            719-541-1837
I-300141                                            Daniel Rodkey                        719-748-3205
C-300041   Laser Graphics Associates                Paul Kaakeh                          719-750-4539
I-300021                                            Matt Smith                           719-822-8828
I-300061                                            Brenda Jones                         720-800-2638
I-300043                                            Carey Dailey                         728-896-2767
I-300073                                            Dean Eagon                           970-581-8611
I-300078                                            Andrea Griswold                      970-746-0995

9 rows selected.
*/
