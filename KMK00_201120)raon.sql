-- 201120 employee table ����
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
        ,'�ں���' 
        ,'��ȣ��' 
        ,'19930616'
        ,'27'
        ,'M' 
        ,'010-5555-0616'
        ,'bogummy486@gmail.com'
        ,'����� ��õ�� ��'
        ,'Y'
        ,SYSDATE
        ,SYSDATE);
commit;

--��ȸ
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

--������Ʈ HP
UPDATE RAON_EMPLOYEE
SET
        EHP         = '010-7777-0616'       
       ,EUPDATEDATE = SYSDATE
WHERE EMPNUM = 'E201101'
AND  EDELETEYN = 'Y';

--������Ʈ EMAIL
UPDATE RAON_EMPLOYEE
SET
        EEMAIL      = 'bogummy4848@gmail.com'  
       ,EUPDATEDATE = SYSDATE
WHERE EMPNUM = 'E201101'
AND  EDELETEYN = 'Y';

--������Ʈ ADDR
UPDATE RAON_EMPLOYEE
SET
        EADDR       = '����� ������ û�㵿'       
       ,EUPDATEDATE = SYSDATE
WHERE EMPNUM = 'E201101'
AND  EDELETEYN = 'Y';

SELECT * FROM RAON_EMPLOYEE;

--����
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

-- ���� ������ �Է��� �� �� ������ ���̸� ����ؼ� �Է��ϰ�
-- �� �����͸� ��ȸ�ؼ� ��� �Ǵµ� 
-- �̰� �ð��� �������� ���̰� �ٲ��. 
-- ���̰� �ٲ� �� ���� ��������� ����ؼ� ������Ʈ �ؾ� �Ѵ�. 

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
