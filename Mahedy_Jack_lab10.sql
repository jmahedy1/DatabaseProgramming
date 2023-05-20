/*
Jack Mahedy
CNIT 372 Lab section 007
Estimated Time Spent: 4
Late Hours Used: 0
*/

--Question #1

DROP TABLE AIRDB_ALL_INFO CASCADE CONSTRAINTS;

CREATE TABLE AIRDB_ALL_INFO AS 
    SELECT * 
    FROM CNIT372TA.AIRDB_ALL_INFO;

/* Q1 Query Results

Table AIRDB_ALL_INFO created.
*/



--Question #2

ALTER TABLE AIRDB_ALL_INFO
MODIFY origin_city_name NOT NULL;

ALTER TABLE AIRDB_ALL_INFO
MODIFY dest_city_name NOT NULL;

ALTER TABLE AIRDB_ALL_INFO
MODIFY origin_state_nm NOT NULL;

ALTER TABLE AIRDB_ALL_INFO
MODIFY dest_state_nm NOT NULL;

ALTER TABLE AIRDB_ALL_INFO
ADD CONSTRAINT AIRDB_ALL_INFO_UQ UNIQUE (origin_airport_id, dest_airport_id,
                                         fl_num, carrier, fl_date);

/* Q2 Query Results

Table AIRDB_ALL_INFO altered.
Table AIRDB_ALL_INFO altered.
Table AIRDB_ALL_INFO altered.
Table AIRDB_ALL_INFO altered.
Table AIRDB_ALL_INFO altered.
*/



--Question #3

SELECT * 
FROM User_Constraints 
WHERE Table_Name = 'AIRDB_ALL_INFO';

/* Q3 Query Results

There are 4 not null constraints and 1 unique constraints that covers the 5 columns from Q2.

OWNER    CONSTRAINT_NAME       C TABLE_NAME        SEARCH_CONDITION                  SEARCH_CONDITION_VC               R_OWNER     R_CONSTRAINT_NAME   DELETE_RU STATUS    DEFERRABLE     DEFERRED  VALIDATED     GENERATED      BAD RELY LAST_CHAN INDEX_OWNER     INDEX_NAME        INVALID VIEW_RELATED   ORIGIN_CON_ID
-------- --------------------- - ----------------- --------------------------------- --------------------------------- ----------- ------------------- --------- --------- -------------- --------- ------------- -------------- --- ---- --------- --------------- ----------------- ------- --------------- ------------ 
JMAHEDY  SYS_C00487837         C AIRDB_ALL_INFO    "ORIGIN_STATE_NM" IS NOT NULL     "ORIGIN_STATE_NM" IS NOT NULL                                               ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     GENERATED NAME          01-DEC-22                                                           0
JMAHEDY  SYS_C00487838         C AIRDB_ALL_INFO    "DEST_STATE_NM" IS NOT NULL       "DEST_STATE_NM" IS NOT NULL                                                 ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     GENERATED NAME          01-DEC-22                                                           0
JMAHEDY  AIRDB_ALL_INFO_UQ     U AIRDB_ALL_INFO                                                                                                                  ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     USER NAME               01-DEC-22  JMAHEDY         AIRDB_ALL_INFO_UQ                        0
JMAHEDY  SYS_C00487835         C AIRDB_ALL_INFO    "ORIGIN_CITY_NAME" IS NOT NULL    "ORIGIN_CITY_NAME" IS NOT NULL                                              ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     GENERATED NAME          01-DEC-22                                                           0
JMAHEDY  SYS_C00487836         C AIRDB_ALL_INFO    "DEST_CITY_NAME" IS NOT NULL      "DEST_CITY_NAME" IS NOT NULL                                                ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     GENERATED NAME          01-DEC-22                                                           0
*/



--Question #4

DROP TABLE AIRDB_CLONE CASCADE CONSTRAINTS;

CREATE TABLE AIRDB_CLONE AS 
    SELECT * 
    FROM AIRDB_ALL_INFO;

/* Q4 Query Results

Table AIRDB_CLONE created.
*/



--Question #5

SELECT * 
FROM User_Constraints 
WHERE Table_Name = 'AIRDB_CLONE';

/* Q5 Query Results

The 4 null constraints are still present after the clone. The unique constraint on the 5 columns is not present after the clone.

OWNER    CONSTRAINT_NAME       C TABLE_NAME        SEARCH_CONDITION                  SEARCH_CONDITION_VC               R_OWNER     R_CONSTRAINT_NAME   DELETE_RU STATUS    DEFERRABLE     DEFERRED  VALIDATED     GENERATED      BAD RELY LAST_CHAN INDEX_OWNER     INDEX_NAME        INVALID VIEW_RELATED    ORIGIN_CON_ID
-------- --------------------- - ----------------- --------------------------------- --------------------------------- ----------- ------------------- --------- --------- -------------- --------- ------------- -------------- --- ---- --------- --------------- ----------------- ------- --------------- ------------ 
JMAHEDY  SYS_C00487837         C AIRDB_ALL_INFO    "ORIGIN_STATE_NM" IS NOT NULL     "ORIGIN_STATE_NM" IS NOT NULL                                               ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     GENERATED NAME          01-DEC-22                                                            0
JMAHEDY  SYS_C00487838         C AIRDB_ALL_INFO    "DEST_STATE_NM" IS NOT NULL       "DEST_STATE_NM" IS NOT NULL                                                 ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     GENERATED NAME          01-DEC-22                                                            0
JMAHEDY  SYS_C00487835         C AIRDB_ALL_INFO    "ORIGIN_CITY_NAME" IS NOT NULL    "ORIGIN_CITY_NAME" IS NOT NULL                                              ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     GENERATED NAME          01-DEC-22                                                            0
JMAHEDY  SYS_C00487836         C AIRDB_ALL_INFO    "DEST_CITY_NAME" IS NOT NULL      "DEST_CITY_NAME" IS NOT NULL                                                ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     GENERATED NAME          01-DEC-22                                                            0
*/



--Question #6

ALTER TABLE AIRDB_CLONE
ADD CONSTRAINT AIRDB_CLONE_UQ UNIQUE (origin_airport_id, dest_airport_id,
                                      fl_num, carrier, fl_date);

/* Q6 Query Results

Table AIRDB_CLONE altered.
*/



--Question #7

DROP TABLE AIRDB_AIRPORTS CASCADE CONSTRAINTS;

CREATE TABLE AIRDB_AIRPORTS(
    airport_id         NUMBER,
    city_market_id     NUMBER,
    airport_code       VARCHAR2(3) PRIMARY KEY,
    city_name          VARCHAR2(30),
    state_abr          VARCHAR2(2),
    state_fips         NUMBER,
    state_name         VARCHAR2(30));

/* Q7 Query Results

Table AIRDB_AIRPORTS created.
*/



--Question #8

INSERT INTO AIRDB_AIRPORTS(airport_id, city_market_id, airport_code, city_name, state_abr, state_fips, state_name)
SELECT origin_airport_id, origin_city_market_id, origin, origin_city_name, origin_state_abr, origin_state_fips, origin_state_nm
FROM AIRDB_ALL_INFO
UNION ALL
SELECT dest_airport_id, dest_city_market_id, dest, dest_city_name, dest_state_abr, dest_state_fips, dest_state_nm
FROM AIRDB_ALL_INFO;

INSERT INTO AIRDB_AIRPORTS(airport_id, city_market_id, airport_code, city_name, state_abr, state_fips, state_name)
SELECT origin_airport_id, origin_city_market_id, origin, origin_city_name, origin_state_abr, origin_state_fips, origin_state_nm
FROM AIRDB_ALL_INFO
UNION
SELECT dest_airport_id, dest_city_market_id, dest, dest_city_name, dest_state_abr, dest_state_fips, dest_state_nm
FROM AIRDB_ALL_INFO;

/* Q8 Query Results

I get a unique constraint error for part a. I'm able to insert 294 rows for part b.
Union selects only distinct values, union all allows for duplicates. Since airport_code
is the primary key and will not allow duplicates union will only work.

Error report -
ORA-00001: unique constraint (JMAHEDY.SYS_C00487862) violated

294 rows inserted.
*/



--Question #9

ALTER TABLE AIRDB_CLONE
    ADD CONSTRAINT airdb_clone_origin_FK 
        FOREIGN KEY(origin) REFERENCES AIRDB_AIRPORTS(airport_code);

ALTER TABLE AIRDB_CLONE
    ADD CONSTRAINT airdb_clone_dest_FK 
        FOREIGN KEY(dest) REFERENCES AIRDB_AIRPORTS(airport_code);

/* Q9 Query Results

Table AIRDB_CLONE altered.
Table AIRDB_CLONE altered.
*/



--Question #10

ALTER TABLE AIRDB_CLONE
DROP (origin_city_market_id, origin_state_fips, dest_city_market_id, dest_state_fips);



/* Q10 Query Results

Table AIRDB_CLONE altered.
*/



--Question #11

ALTER TABLE AIRDB_AIRPORTS
ADD CONSTRAINT AIRDB_AIRPORTS_CK CHECK(state_abr IN('AK', 'AL', 'AR', 'AZ', 'CA', 
                                                    'CO', 'CT', 'DE', 'FL', 'GA', 
                                                    'HI', 'IA', 'ID', 'IL', 'IN', 
                                                    'KS', 'KY', 'LA', 'MA', 'MD', 
                                                    'ME', 'MI', 'MN', 'MO', 'MS', 
                                                    'MT', 'NC', 'ND', 'NE', 'NH', 
                                                    'NJ', 'NM', 'NV', 'NY', 'OH', 
                                                    'OK', 'OR', 'PA', 'RI', 'SC', 
                                                    'SD', 'TN', 'TX', 'UT', 'VA', 
                                                    'VT', 'WA', 'WI', 'WV', 'WY'));

/* Q11 Query Results

We are getting this error becasue the data includes US territories.

Error starting at line : 204 in command -
ALTER TABLE AIRDB_AIRPORTS
ADD CONSTRAINT AIRDB_AIRPORTS_CK CHECK(state_abr IN('AK', 'AL', 'AR', 'AZ', 'CA', 
                                                    'CO', 'CT', 'DE', 'FL', 'GA', 
                                                    'HI', 'IA', 'ID', 'IL', 'IN', 
                                                    'KS', 'KY', 'LA', 'MA', 'MD', 
                                                    'ME', 'MI', 'MN', 'MO', 'MS', 
                                                    'MT', 'NC', 'ND', 'NE', 'NH', 
                                                    'NJ', 'NM', 'NV', 'NY', 'OH', 
                                                    'OK', 'OR', 'PA', 'RI', 'SC', 
                                                    'SD', 'TN', 'TX', 'UT', 'VA', 
                                                    'VT', 'WA', 'WI', 'WV', 'WY'))
Error report -
ORA-02293: cannot validate (JMAHEDY.AIRDB_AIRPORTS_CK) - check constraint violated
02293. 00000 - "cannot validate (%s.%s) - check constraint violated"
*Cause:    an alter table operation tried to validate a check constraint to
           populated table that had nocomplying values.
*Action:   Obvious
*/



--Question #12

ALTER TABLE AIRDB_AIRPORTS
ADD CONSTRAINT AIRDB_AIRPORTS_CK CHECK(state_abr IN('AK', 'AL', 'AR', 'AZ', 'CA', 
                                                    'CO', 'CT', 'DE', 'FL', 'GA', 
                                                    'HI', 'IA', 'ID', 'IL', 'IN', 
                                                    'KS', 'KY', 'LA', 'MA', 'MD', 
                                                    'ME', 'MI', 'MN', 'MO', 'MS', 
                                                    'MT', 'NC', 'ND', 'NE', 'NH', 
                                                    'NJ', 'NM', 'NV', 'NY', 'OH', 
                                                    'OK', 'OR', 'PA', 'RI', 'SC', 
                                                    'SD', 'TN', 'TX', 'UT', 'VA', 
                                                    'VT', 'WA', 'WI', 'WV', 'WY')) DISABLE;
                                                    
SELECT * 
FROM User_Constraints 
WHERE Table_Name = 'AIRDB_AIRPORTS';

/* Q12 Query Results

Table AIRDB_AIRPORTS altered.

OWNER                                                                                                                            CONSTRAINT_NAME                                                                                                                  C TABLE_NAME                                                                                                                       SEARCH_CONDITION                                                                 SEARCH_CONDITION_VC                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              R_OWNER                                                                                                                          R_CONSTRAINT_NAME                                                                                                                DELETE_RU STATUS   DEFERRABLE     DEFERRED  VALIDATED     GENERATED      BAD RELY LAST_CHAN INDEX_OWNER                                                                                                                      INDEX_NAME                                                                                                                       INVALID VIEW_RELATED   ORIGIN_CON_ID
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- - -------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- --------- -------- -------------- --------- ------------- -------------- --- ---- --------- -------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- ------- -------------- -------------
JMAHEDY                                                                                                                          AIRDB_AIRPORTS_CK                                                                                                                C AIRDB_AIRPORTS                                                                                                                   state_abr IN('AK', 'AL', 'AR', 'AZ', 'CA',                                       state_abr IN('AK', 'AL', 'AR', 'AZ', 'CA',                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   DISABLED NOT DEFERRABLE IMMEDIATE NOT VALIDATED USER NAME               02-DEC-22                                                                                                                                                                                                                                                                                                      0
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          'CO', 'CT', 'DE', 'FL', 'GA',                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          'HI', 'IA', 'ID', 'IL', 'IN',                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          'KS', 'KY', 'LA', 'MA', 'MD',                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          'ME', 'MI', 'MN', 'MO', 'MS',                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          'MT', 'NC', 'ND', 'NE', 'NH',                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          'NJ', 'NM', 'NV', 'NY', 'OH',                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          'OK', 'OR', 'PA', 'RI', 'SC',                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          'SD', 'TN', 'TX', 'UT', 'VA',                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          'VT', 'WA', 'WI', 'WV', 'WY')                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    


OWNER                                                                                                                            CONSTRAINT_NAME                                                                                                                  C TABLE_NAME                                                                                                                       SEARCH_CONDITION                                                                 SEARCH_CONDITION_VC                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              R_OWNER                                                                                                                          R_CONSTRAINT_NAME                                                                                                                DELETE_RU STATUS   DEFERRABLE     DEFERRED  VALIDATED     GENERATED      BAD RELY LAST_CHAN INDEX_OWNER                                                                                                                      INDEX_NAME                                                                                                                       INVALID VIEW_RELATED   ORIGIN_CON_ID
-------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- - -------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- --------- -------- -------------- --------- ------------- -------------- --- ---- --------- -------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------- ------- -------------- -------------
JMAHEDY                                                                                                                          SYS_C00487913                                                                                                                    P AIRDB_AIRPORTS                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 ENABLED  NOT DEFERRABLE IMMEDIATE VALIDATED     GENERATED NAME          01-DEC-22 JMAHEDY                                                                                                                          SYS_C00487913                                                                                                                                                       0

*/



--Question #13

DELETE FROM AIRDB_AIRPORTS 
WHERE state_abr IN('AS', 'FM', 'GU', 'MH', 'MP', 'PR', 'PW', 'VI', 'UM');

/* Q13 Query Results

The state_abr column is referenced as a forign key from the AIRDB_CLONE table.
So you can not delete the data in the tables current state.

Error starting at line : 288 in command -
DELETE FROM AIRDB_AIRPORTS 
WHERE state_abr IN('AS', 'FM', 'GU', 'MH', 'MP', 'PR', 'PW', 'VI', 'UM')
Error report -
ORA-02292: integrity constraint (JMAHEDY.AIRDB_CLONE_DEST_FK) violated - child record found
*/



--Question #14

ALTER TABLE AIRDB_CLONE
    DROP CONSTRAINT airdb_clone_dest_FK;

ALTER TABLE AIRDB_CLONE
    ADD CONSTRAINT airdb_clone_dest_FK 
        FOREIGN KEY(dest) REFERENCES AIRDB_AIRPORTS(airport_code) ON DELETE SET NULL;

/* Q14 Query Results

Table AIRDB_CLONE altered.

Table AIRDB_CLONE altered.
*/



--Question #15

ALTER TABLE AIRDB_CLONE
    DROP CONSTRAINT airdb_clone_origin_FK;

ALTER TABLE AIRDB_CLONE
    ADD CONSTRAINT airdb_clone_origin_FK 
        FOREIGN KEY(origin) REFERENCES AIRDB_AIRPORTS(airport_code) ON DELETE CASCADE;

/* Q15 Query Results

Table AIRDB_CLONE altered.

Table AIRDB_CLONE altered.
*/



--Question #16

DELETE FROM AIRDB_AIRPORTS 
WHERE state_abr IN('AS', 'FM', 'GU', 'MH', 'MP', 'PR', 'PW', 'VI', 'UM');

/* Q16 Query Results

The data is able to be deleted becasue we made the foriegn key constraint have 
the ability to delete the data and replace it with null or delete all records 
that corospond with the data. 

5 rows deleted.
*/



--Question #17

ALTER TABLE AIRDB_AIRPORTS
ENABLE CONSTRAINT AIRDB_AIRPORTS_CK;

/* Q17 Query Results

This constraint works now becasue we just deleted all of the US territory data and
there is just the 50 states left.

Table AIRDB_AIRPORTS altered.
*/



--Question #18

SELECT COUNT(*)
FROM AIRDB_CLONE
WHERE dest_airport_id IS NULL;

SELECT COUNT(*)
FROM AIRDB_CLONE
WHERE origin_airport_id IS NULL;

SELECT COUNT(*)
FROM AIRDB_ALL_INFO
WHERE dest_airport_id IS NULL;

SELECT COUNT(*)
FROM AIRDB_ALL_INFO
WHERE origin_airport_id IS NULL;


/* Q18 Query Results

I got 0 rows for all my selects. The error code for foriegn key constraint was on the 
AIRDB_CLONE_DEST_FK so I thought I would get 5 rows for the select on the dest AIRDB_CLONE.
I'm not sure if I did this right or wrong.

  COUNT(*)
----------
         0


  COUNT(*)
----------
         0
         
  COUNT(*)
----------
         0


  COUNT(*)
----------
         0
*/



--Question #19

ALTER TABLE AIRDB_AIRPORTS
ADD CONSTRAINT AIRDB_AIRPORTS_UQ UNIQUE(airport_code);

ALTER TABLE AIRDB_AIRPORTS
ADD CONSTRAINT AIRDB_AIRPORTS_NL CHECK(airport_code IS NOT NULL);

/* Q19 Query Results

The unique constraint did not work becasue we set airport_code to be the primary key
in question 7. I thought the null constraint would not work but it did becasue when the
primary key is set unique and not null constraints get automatically set.


Error starting at line : 421 in command -
ALTER TABLE AIRDB_AIRPORTS
ADD CONSTRAINT AIRDB_AIRPORTS_UQ UNIQUE(airport_code)
Error report -
ORA-02261: such unique or primary key already exists in the table
02261. 00000 -  "such unique or primary key already exists in the table"
*Cause:    Self-evident.
*Action:   Remove the extra key.


Table AIRDB_AIRPORTS altered.
*/



--Question #20

ALTER TABLE AIRDB_AIRPORTS
ADD CONSTRAINT AIRDB_AIRPORTS_cityName_UQ UNIQUE(city_name);

/* Q20 Query Results

The city_name column has duplicate values to we can not create the unique constraint.

Error starting at line : 451 in command -
ALTER TABLE AIRDB_AIRPORTS
ADD CONSTRAINT AIRDB_AIRPORTS_cityName_UQ UNIQUE(city_name)
Error report -
ORA-02299: cannot validate (JMAHEDY.AIRDB_AIRPORTS_CITYNAME_UQ) - duplicate keys found
02299. 00000 - "cannot validate (%s.%s) - duplicate keys found"
*Cause:    an alter table validating constraint failed because the table has
           duplicate key values.
*Action:   Obvious
*/



--Question #21

DROP TABLE AIRDB_ALL_INFO CASCADE CONSTRAINTS;
DROP TABLE AIRDB_CLONE CASCADE CONSTRAINTS;
DROP TABLE AIRDB_AIRPORTS CASCADE CONSTRAINTS;

/* Q21 Query Results

Table AIRDB_ALL_INFO dropped.

Table AIRDB_CLONE dropped.

Table AIRDB_AIRPORTS dropped.
*/