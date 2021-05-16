
SELECT * FROM RAON_EMPLOYEE;

SELECT * FROM RAON_MEMBER;

SELECT * FROM RAON_APPOINTMENT;

--RAON_EMPLOYEE
--테이블 생성
DROP TABLE RAON_EMPLOYEE;
CREATE TABLE RAON_EMPLOYEE(
        	 EMPNUM	    	VARCHAR2(20)	      PRIMARY KEY
        	,EPW	    	VARCHAR2(20)          NOT NULL
        	,ENAME	    	VARCHAR2(20)          NOT NULL
        	,EJOB	    	VARCHAR2(20)
        	,EBIRTH	    	VARCHAR2(8)           NOT NULL 
        	,EGENDER	    VARCHAR2(1)     
        	,EHP		    VARCHAR2(13)          NOT NULL
        	,EEMAIL		    VARCHAR2(300)         NOT NULL
        	,EADDR		    VARCHAR2(500)   
        	,EDELETEYN  	VARCHAR2(1)     
        	,EINSERTDATE	DATE            
        	,EUPDATEDATE	DATE            
);  

SELECT * FROM RAON_EMPLOYEE;

--삽입
INSERT INTO RAON_EMPLOYEE
(
        	 EMPNUM	            
            ,EPW	            
        	,ENAME              
        	,EJOB               
        	,EBIRTH	
        	,EGENDER            
        	,EHP	            
        	,EEMAIL	            
        	,EADDR	            
        	,EDELETEYN          
        	,EINSERTDATE        
        	,EUPDATEDATE
)
VALUES
(        'E201101'
        ,'1234' 
        ,'박보검' 
        ,'간호사' 
        ,'19930616'
        ,'M' 
        ,'010-5555-0616'
        ,'bogummy486@gmail.com'
        ,'서울시 양천구 목동'
        ,'Y'
        ,SYSDATE
        ,SYSDATE
);

SELECT * FROM RAON_EMPLOYEE;

ROLLBACK;

--조회
SELECT
         A.EMPNUM                                       EMPNUM
        ,A.EPW										 	EPW
        ,A.ENAME										ENAME
        ,A.EJOB										  	EJOB 
        ,A.EBIRTH										EBIRTH
        ,(SELECT 
            TRUNC(MONTHS_BETWEEN
                (TRUNC(SYSDATE),TO_DATE(
                    (SELECT B.EBIRTH FROM RAON_EMPLOYEE	B
                     WHERE B.EMPNUM = A.EMPNUM ),'YYYYMMDD')) / 12) 
                     FROM DUAL)  					    EAGE
        ,A.EGENDER									    EGENDER 
        ,A.EHP										    EHP	
        ,A.EEMAIL										EEMAIL
        ,A.EADDR										EADDR 
        ,A.EDELETEYN									EDELETEYN 
        ,TO_CHAR(A.EINSERTDATE, 'YYYY/MM/DD HH:MM:SS')  EINSERTDATE
        ,TO_CHAR(A.EUPDATEDATE, 'YYYY/MM/DD HH:MM:SS')  EUPDATEDATE
FROM  RAON_EMPLOYEE	A
WHERE   EDELETEYN = 'Y'
AND     EMPNUM = 'E201101';

--업데이트
UPDATE RAON_EMPLOYEE
SET
        EPW         = '5678'       
       ,EUPDATEDATE = SYSDATE
WHERE EMPNUM = 'E201101'
AND  EDELETEYN = 'Y';

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

ROLLBACK;


--###########################################################################--

--RAON_MEMBER
--테이블 생성
DROP TABLE RAON_MEMBER;
CREATE TABLE RAON_MEMBER(
             MNUM		    VARCHAR2(20)        PRIMARY KEY
            ,PNAME		    VARCHAR2(20)        NOT NULL
            ,PKIND		    VARCHAR2(10)
            ,PBIRTH		    VARCHAR2(8)         NOT NULL
        	,PGENDER	    VARCHAR2(1)
        	,MNAME		    VARCHAR2(20)        NOT NULL
        	,MHP		    VARCHAR2(13)        NOT NULL
        	,MADDR		    VARCHAR2(500)
        	,MDELETEYN      VARCHAR2(1)
        	,MINSERTDATE    DATE
        	,MUPDATEDATE    DATE
);

SELECT * FROM RAON_MEMBER;

--삽입
INSERT INTO RAON_MEMBER
(
             MNUM
            ,PNAME
            ,PKIND
            ,PBIRTH
        	,PGENDER
        	,MNAME
        	,MHP
        	,MADDR
        	,MDELETEYN
        	,MINSERTDATE 
        	,MUPDATEDATE
)
VALUES 
(
             'P20111900'
            ,'뽑삐'
            ,'51'
            ,'20181010'
        	,'F'
        	,'박보검'
            ,'010-5555-0616'
            ,'서울시 양천구 목동'
            ,'Y'
            ,SYSDATE
            ,SYSDATE
);

SELECT * FROM RAON_MEMBER;
commit;
ROLLBACK;

--조회
SELECT	
         RM.MNUM                    MNUM	
        ,RM.PNAME                   PNAME
        ,RM.PKIND                   PKIND
        ,RM.PBIRTH                  PBIRTH
        ,AAA.PAGE                   PAGE
        ,RM.PGENDER                 PGENDER
        ,RM.MNAME                   MNAMME
        ,RM.MHP                     MHP
        ,RM.MADDR                   MADDR
        ,RM.MDELETEYN               MDELETEYN
        ,RM.MINSERTDATE             MINSERTDATE
        ,RM.MUPDATEDATE             MUPDATEDATE
FROM  RAON_MEMBER RM
     ,(SELECT A.MNUM
            ,CASE
                WHEN A.RAONAGE > 12 THEN TRUNC(A.RAONAGE / 12) || '살'
                WHEN A.RAONAGE <= 12 THEN TRUNC(A.RAONAGE) || '개월'	
             END PAGE
       FROM (SELECT MNUM, TRUNC(MONTHS_BETWEEN(SYSDATE, PBIRTH)) RAONAGE
             FROM RAON_MEMBER) A)   AAA	
WHERE   RM.MDELETEYN = 'Y'
AND     RM.MNUM = AAA.MNUM;
--AND   MNAME = '박보검'
--AND   MHP = '010-5555-0616';

--업데이트 HP
UPDATE RAON_MEMBER
SET
        MHP         = '010-7777-0616'
       ,MUPDATEDATE = SYSDATE
WHERE MNAME = 'P20111900'
AND   MHP = '010-5555-0616'
AND   MDELETEYN = 'Y';

--업데이트 ADDR
UPDATE RAON_MEMBER
SET
        MADDR       = '서울시 강남구 청담동'
       ,MUPDATEDATE = SYSDATE
WHERE MNAME = 'P20111900'
AND   MHP = '010-5555-0616'
AND   MDELETEYN = 'Y';

SELECT * FROM RAON_MEMBER;
ROLLBACK;

--삭제
UPDATE RAON_MEMBER
SET
        MDELETEYN = 'N'
       ,MUPDATEDATE = SYSDATE
WHERE MNAME = 'P20111900'
AND   MHP = '010-5555-0616'
AND   MDELETEYN = 'Y';

SELECT * FROM RAON_MEMBER;
ROLLBACK;


--###########################################################################--

--RAON_APPOINTMENT
--테이블 생성
DROP TABLE RAON_APPOINTMENT;
CREATE TABLE RAON_APPOINTMENT(
        	 ANUM		    VARCHAR2(30)        PRIMARY KEY
        	,MNUM		    VARCHAR2(20)        NOT NULL
        	,PNAME          VARCHAR2(20)
            ,MNAME          VARCHAR2(20)
            ,MHP            VARCHAR2(13)
            ,ADATE		    DATE                NOT NULL
        	,ATIME		    VARCHAR2(5)         NOT NULL
        	,AMEMO		    VARCHAR2(500)
        	,ADELETEYN	    VARCHAR2(1)
        	,AINSERTDATE	DATE
        	,AUPDATEDATE	DATE
);

SELECT * FROM RAON_APPOINTMENT;

--삽입
INSERT INTO RAON_APPOINTMENT
(
        	 ANUM
        	,MNUM
        	,ADATE
        	,ATIME
        	,AMEMO
        	,ADELETEYN
        	,AINSERTDATE
        	,AUPDATEDATE
)
VALUES
(
        'A201120-P2011190001-001'
       ,'P20111900'
       ,'2020/11/20'
       ,'16:30'
       ,'복통 호소'
       ,'Y'
       ,SYSDATE
       ,SYSDATE
);

SELECT * FROM RAON_APPOINTMENT;

--조회
SELECT
        A.ANUM                                          ANUM           
       ,A.MNUM                                          MNUM
       ,BB.PNAME                                        PNAME
       ,BB.MNAME                                        MNAME
       ,BB.MHP                                          MHP
       ,TO_CHAR(A.ADATE, 'YYYY/MM/DD')                  ADATE
       ,A.ATIME                                         ATIME
       ,A.AMEMO                                         AMEMO
       ,A.ADELETEYN                                     ADELETEYN
       ,TO_CHAR(A.AINSERTDATE, 'YYYY/MM/DD HH:MM:SS')   AINSERTDATE
       ,TO_CHAR(A.AUPDATEDATE, 'YYYY/MM/DD HH:MM:SS')   AUPDATEDATE
FROM  RAON_APPOINTMENT A
      ,(SELECT B.MNUM, B.PNAME, B.MNAME, B.MHP 
        FROM RAON_MEMBER B 
        WHERE MDELETEYN = 'Y' 
        AND MNUM = 'P20111900') BB
WHERE A.ADELETEYN = 'Y'
AND   A.MNUM = 'P20111900'
AND   A.MNUM = BB.MNUM;



SELECT
		 ANUM     	 	  						    	ANUM
		,MNUM     								    	MNUM
		,PNAME     								    	PNAME
		,MNAME     								    	MNAME
		,MHP     								    	MHP
		,TO_CHAR(ADATE, 'YYYY/MM/DD') 			    	ADATE 
		,ATIME       									ATIME
		,AMEMO     								    	AMEMO
		,ADELETEYN    							    	ADELETEYN 
		,TO_CHAR(AINSERTDATE, 'YYYY/MM/DD HH:MM:SS')	AINSERTDATE
		,TO_CHAR(AUPDATEDATE, 'YYYY/MM/DD HH:MM:SS')	AUPDATEDATE
FROM  RAON_APPOINTMENT
WHERE ADELETEYN = 'Y' 
AND MNUM = 'P20111900';


SELECT * FROM RAON_APPOINTMENT;
ROLLBACK;

--업데이트 DATE
UPDATE RAON_APPOINTMENT
SET
      ADATE = '2020/11/30'
     ,AUPDATEDATE = SYSDATE
WHERE ANUM = 'A201120-P2011190001-001'
AND   ADELETEYN = 'Y';

--업데이트 TIME
UPDATE RAON_APPOINTMENT
SET
      ATIME = '16:30'
     ,AUPDATEDATE = SYSDATE
WHERE ANUM = 'A201120-P2011190001-001'
AND   ADELETEYN = 'Y';

--업데이트 MEMO
UPDATE RAON_APPOINTMENT
SET
      AMEMO = '늦을 수 있음'
     ,AUPDATEDATE = SYSDATE
WHERE ANUM = 'A201120-P2011190001-001'
AND   ADELETEYN = 'Y';

SELECT * FROM RAON_APPOINTMENT;
ROLLBACK;
commit;
--삭제
UPDATE RAON_APPOINTMENT
SET
      ADELETEYN = 'N'
     ,AUPDATEDATE = SYSDATE
WHERE ANUM = 'A201120-P2011190001-001'
AND   ADELETEYN = 'Y';

SELECT * FROM RAON_APPOINTMENT;

SELECT * FROM RAON_APPOINTMENT;
ROLLBACK;



/*
-- 오라클에서 제공하는 가상의 테이블 
-- DUMMY 라는 컬럼 하나 가 있는 가상의 테이블 
-- 연산이 가능 
SELECT 1 + 1 FROM DUAL;
SELECT SYSDATE FROM DUAL;
SELECT SYSTIMESTAMP FROM DUAL;
SELECT DUMP(NULL) FROM DUAL;
SELECT DUMP(' ') FROM DUAL;
SELECT DUMP('A') FROM DUAL;
SELECT DUMP(' A  B') FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'Y') AS AA FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YY') AS AA FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYY') AS AA FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY') AS AA FROM DUAL;

SELECT SUBSTR(TO_CHAR(SYSDATE, 'YYYY'), -2) AS AA FROM DUAL;



SELECT 
       'E' ||
       SUBSTR(TO_CHAR(EINSERTDATE, 'YYYY'), -2) ||
       TO_CHAR(EINSERTDATE, 'MM') ||
       (SELECT LPAD(NVL(MAX(NULL), 0)+1, 2, '0') FROM DUAL) AS EMPNUM
FROM RAON_EMPLOYEE;


SELECT 
       'P' ||
       SUBSTR(TO_CHAR(MINSERTDATE, 'YYYY'), -2) ||
       TO_CHAR(MINSERTDATE, 'MM') ||
       TO_CHAR(MINSERTDATE, 'DD') ||
       (SELECT LPAD(NVL(MAX(NULL), 0)+1, 3, '0') FROM DUAL) AS MNUM
FROM RAON_MEMBER;



SELECT 
       'A' ||
       SUBSTR(TO_CHAR(AINSERTDATE, 'YYYY'), -2) ||
       TO_CHAR(AINSERTDATE, 'MM') ||
       TO_CHAR(AINSERTDATE, 'DD') ||
       '-' ||
       (SELECT MNUM FROM RAON_MEMBER) ||
       '-' ||
       (SELECT LPAD(NVL(MAX(NULL), 0)+1, 2, '0') FROM DUAL) AS ANUM
FROM RAON_APPOINTMENT;

SELECT TRUNC(MONTHS_BETWEEN(TRUNC(SYSDATE), TO_DATE('19890326','YYYYMMDD')) / 12)
FROM DUAL;



*/