-- 201120 employee table 실행
CREATE TABLE RAON_EMPLOYEE(
     EMPNUM VARCHAR2(20) PRIMARY KEY
    ,EPW VARCHAR2(20) NOT NULL
    ,ENAME VARCHAR2(20) NOT NULL
    ,EJOB VARCHAR2(20)
    ,EBIRTH VARCHAR2(8) NOT NULL
    ,EAGE VARCHAR2(3) 
    ,EGENDER VARCHAR2(1)
    ,EHP VARCHAR2(13) NOT NULL
    ,EEMAIL VARCHAR2(300) NOT NULL
    ,EADDR VARCHAR2(500)
    ,EDELETEYN VARCHAR2(1)
    ,EINSERTDATE DATE
    ,EUPDATEDATE DATE);
    
SELECT * FROM RAON_EMPLOYEE;
COMMIT;
DROP TABLE RAON_EMPLOYEE;

SELECT 											
		 TRUNC(MONTHS_BETWEEN						 	
		 (TRUNC(SYSDATE),TO_DATE(					 
		   (SELECT EBIRTH							 		
		  FROM RAON_EMPLOYEE),'YYYYMMDD')) / 12)
FROM DUAL;



SELECT * FROM RAON_EMPLOYEE WHERE EMPNUM = 'E201101' AND EPW = '1234';

COMMIT;
INSERT INTO RAON_EMPLOYEE(
             EMPNUM	            
            ,EPW	            
        	,ENAME              
        	,EJOB               
        	,EBIRTH	            
            ,EAGE
        	,EGENDER            
        	,EHP	            
        	,EEMAIL	            
        	,EADDR	            
        	,EDELETEYN          
        	,EINSERTDATE        
        	,EUPDATEDATE)
VALUES(
         'E201101'
        ,'1234' 
        ,'박보검' 
        ,'간호사' 
        ,'19930616'
        ,'27'
        ,'M' 
        ,'010-5555-0616'
        ,'bogummy486@gmail.com'
        ,'서울시 양천구 목동'
        ,'Y'
        ,SYSDATE
        ,SYSDATE);
commit;

--조회
SELECT
        EMPNUM                                          EMPNUM
       ,EPW                                             EPW
       ,ENAME                                           ENAME
       ,EJOB                                            EJOB
       ,EBIRTH                                          EBIRTH
       ,(SELECT 
                TRUNC(MONTHS_BETWEEN
                     (TRUNC(SYSDATE),TO_DATE(
                     (SELECT EBIRTH 
                      FROM RAON_EMPLOYEE 
                      WHERE EPW = '1234'),'YYYYMMDD')) / 12)
         FROM DUAL)                                     EAGE
       ,EGENDER                                         EGENDER
       ,EHP                                             EHP
       ,EEMAIL                                          EEMAIL
       ,EADDR                                           EADDR
       ,EDELETEYN                                       EDELETEYN
       ,TO_CHAR(EINSERTDATE, 'YYYY/MM/DD HH:MM:SS')     EINSERTDATE
       ,TO_CHAR(EUPDATEDATE, 'YYYY/MM/DD HH:MM:SS')     EUPDATEDATE
FROM RAON_EMPLOYEE
WHERE EDELETEYN = 'Y'
AND   EMPNUM = 'E201101';

--업데이트 HP
UPDATE RAON_EMPLOYEE
SET
        EHP         = '010-7777-0616'       
       ,EUPDATEDATE = SYSDATE
WHERE EMPNUM = 'E201101'
AND  EDELETEYN = 'Y';

--업데이트 EMAIL
UPDATE RAON_EMPLOYEE
SET
        EEMAIL      = 'bogummy4848@gmail.com'  
       ,EUPDATEDATE = SYSDATE
WHERE EMPNUM = 'E201101'
AND  EDELETEYN = 'Y';

--업데이트 ADDR
UPDATE RAON_EMPLOYEE
SET
        EADDR       = '서울시 강남구 청담동'       
       ,EUPDATEDATE = SYSDATE
WHERE EMPNUM = 'E201101'
AND  EDELETEYN = 'Y';

SELECT * FROM RAON_EMPLOYEE;

--삭제
UPDATE RAON_EMPLOYEE
SET
       EDELETEYN = 'N'
      ,EUPDATEDATE = SYSDATE
WHERE EMPNUM = 'E201101'
AND   EDELETEYN = 'Y';

SELECT * FROM RAON_EMPLOYEE;

COMMIT;


ROLLBACK;
UPDATE RAON_EMPLOYEE SET EAGE = (SELECT TRUNC(MONTHS_BETWEEN (TRUNC(SYSDATE),TO_DATE((SELECT EBIRTH FROM RAON_EMPLOYEE WHERE EPW = '1234'),'YYYYMMDD')) / 12) FROM DUAL) WHERE EMPNUM = 'E201101' AND  EDELETEYN = 'Y';
SELECT * FROM RAON_EMPLOYEE;
(SELECT TRUNC(MONTHS_BETWEEN (TRUNC(SYSDATE),TO_DATE((SELECT EBIRTH FROM RAON_EMPLOYEE WHERE EPW = '1234'),'YYYYMMDD')) / 12) FROM DUAL)

WHERE EMPNUM = 'E201101' AND  EDELETEYN = 'Y';



SELECT
EMPNUM
EMPNUM
,EPW
EPW
,ENAME
ENAME
,EJOB
EJOB
,EBIRTH
EBIRTH
,(SELECT

TRUNC(MONTHS_BETWEEN

(TRUNC(SYSDATE),TO_DATE(                                                        
(SELECT EBIRTH

FROM RAON_EMPLOYEE                                                             
WHERE EPW = '1234'),'YYYYMMDD')) / 12)
FROM DUAL)                                                                 EAGE

,EGENDER                                                                  EGENDER
,EHP
EHP
,EEMAIL
EEMAIL
,EADDR
EADDR
,EDELETEYN                                                                EDELETEYN
,TO_CHAR(EINSERTDATE, 'YYYY/MM/DD HH:MM:SS')  EINSERTDATE
,TO_CHAR(EUPDATEDATE, 'YYYY/MM/DD HH:MM:SS')  EUPDATEDATE
FROM
RAON_EMPLOYEE
WHERE EDELETEYN = 'Y'
AND   EMPNUM   =  'E201101'
commit;

-- 최초 생일을 입력할 때 그 시점의 나이를 계산해서 입력하고
-- 그 데이터를 조회해서 사용 되는데 
-- 이게 시간이 지나가면 나이가 바뀐다. 
-- 나이가 바뀔 대 마다 생년월일을 계산해서 업데이트 해야 한다. 

SELECT  FROM RAON_EMPLOYEE;

SELECT                                                                                     
    TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE),TO_DATE((SELECT EBIRTH FROM RAON_EMPLOYEE),'YYYYMMDD')) / 12)
FROM DUAL            
       

 SELECT
                 EMPNUM                                                                           EMPNUM
                ,EPW                                                                              EPW
                ,ENAME                                                                            ENAME
                ,EJOB                                                                             EJOB
                ,EBIRTH                                                                           EBIRTH
 /*               ,(SELECT                                                                                     
            TRUNC(MONTHS_BETWEEN
            (TRUNC(SYSDATE),TO_DATE(
            (SELECT EBIRTH
             FROM RAON_EMPLOYEE),'YYYYMMDD')) / 12)
       FROM DUAL)                                                                 EAGE 
*/       
                ,EGENDER                                                                          EGENDER
                ,EHP                                                                              EHP
                ,EEMAIL                                                                           EEMAIL
                ,EADDR                                                                            EADDR
                ,EDELETEYN                                                                        EDELETEYN  
                ,TO_CHAR(EINSERTDATE, 'YYYY/MM/DD HH:MM:SS')  EINSERTDATE
                ,TO_CHAR(EUPDATEDATE, 'YYYY/MM/DD HH:MM:SS')  EUPDATEDATE
FROM                                                                                                         
                RAON_EMPLOYEE                                                                                
WHERE EDELETEYN = 'Y';
