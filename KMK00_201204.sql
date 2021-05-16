
CREATE TABLE KOSMOMEMBER(
	
	KNUM VARCHAR2(20) PRIMARY KEY 
   ,KNAME VARCHAR2(100)
   ,KID VARCHAR2(100)
   ,KPW VARCHAR2(300) NOT NULL
   ,KHP VARCHAR2(16) NOT NULL
   ,KGENDER VARCHAR2(1)
   ,KHOBBY VARCHAR2(200)
   ,KLOCAL VARCHAR2(50)
   ,KMSG VARCHAR2(500)
   ,KDELETEYN VARCHAR2(1) NOT NULL
   ,KINSERTDATE DATE
   ,KUPDATEDATE DATE	
);

SELECT * FROM KOSMOMEMBER;
COMMIT;

-- knum 채번 구하기 쿼리
SELECT       'M' || LPAD(NVL(MAX(SUBSTR(KNUM,2)),0) + 1,4,'0')   KNUM
FROM KOSMOMEMBER;

-- 전체조회
SELECT					 KNUM                       KNUM
                        ,KNAME						KNAME
                        ,KID                        KID
                        ,KPW                        KPW
                        ,KHP                        KHP
                        ,KGENDER                    KGENDER
                        ,KHOBBY                     KHOBBY
                        ,KLOCAL                     KLOCAL
                        ,KMSG                       KMSG
                        ,KDELETEYN                  KDELETEYN
                        ,TO_CHAR(KINSERTDATE, 'YYYYMMDD')   KINSERTDATE 
                        ,TO_CHAR(KINSERTDATE, 'YYYYMMDD')   KUPDATEDATE 	
FROM	KOSMOMEMBER										
WHERE	KDELETEYN = 'Y';

-- 채번로직 사용 방법
-- SYS_C0011455	KNUM
SELECT A.INDEX_NAME, A.COLUMN_NAME
FROM   ALL_IND_COLUMNS A 
WHERE  A.TABLE_NAME = 'KOSMOMEMBER';

SELECT  /*+ INDEX_DESC(SYS_C0011455) */
        NVL(MAX(SUBSTR(A.KNUM, -4)), 0) + 1 COMMNO	
FROM    KOSMOMEMBER A 								
WHERE   A.KDELETEYN = 'Y';	

SELECT  * FROM KOSMOMEMBER;

SELECT COUNT(A.KID) NCNT FROM KOSMOMEMBER A WHERE A.KID = '11' AND A.KDELETEYN='Y'