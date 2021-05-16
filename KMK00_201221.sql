2020-12-21
1.�Խ��� ������
���̺� ��: MVC_MEMBER
- ����
CREATE TABLE MVC_MEMBER(
	MNUM VARCHAR2(20) PRIMARY KEY 
   ,MNAME VARCHAR2(200)
   ,MID VARCHAR2(200) NOT NULL
   ,MPW VARCHAR2(300) NOT NULL 
   ,MGENDER VARCHAR2(1)
   ,MBIRTH VARCHAR2(8)
   ,MHP VARCHAR2(16) NOT NULL
   ,MTEL VARCHAR2(16)
   ,MEMAIL VARCHAR2(300) NOT NULL
   ,MZIPCODE VARCHAR2(5)
   ,MADDR VARCHAR2(500)
   ,MADDRDETAIL VARCHAR2(500)
   ,MGIBUN VARCHAR2(500)
   ,MHOBBY VARCHAR2(100)
   ,MINFO VARCHAR2(2000)
   ,MPHOTO VARCHAR2(300)
   ,MDELETEYN VARCHAR2(1) NOT NULL
   ,MINSERTDATE DATE
   ,MUPDATEDATE DATE
);
- SYS_c0011532 MNUM
SELECT A.INDEX_NAME, A.COLUMN_NAME
FROM   ALL_IND_COLUMNS A 
WHERE  A.TABLE_NAME = 'MVC_MEMBER';
- ȸ��ä�� M0001
SELECT /* +INDEX+DESC(SYS_c0011532) */ 
    NVL(MAX(SUBSTR(A.MNUM, -4)), 0) + 1 COMMNO
FROM MVC_MEMBER A
- ��ü��ȸ
SELECT  A.MNUM          MNUM
       ,A.MNAME         MNAME
       ,A.MID           MID
       ,A.MPW           MPW
       ,A.MGENDER       MGENDER
       ,A.MBIRTH        MBIRTH
       ,A.MHP           MHP
       ,A.MTEL          MTEL
       ,A.MEMAIL        MEMAIL
       ,A.MZIPCODE      MZIPCODE
       ,A.MADDR         MADDR
       ,A.MADDRDETAIL   MADDRDETAIL
       ,A.MGIBUN        MGIBUN
       ,A.MHOBBY        MHOBBY
       ,A.MINFO         MINFO
       ,A.MPHOTO        MPHOTO
       ,A.MDELETEYN     MDELETEYN
       ,TO_CHAR(A.MINSERTDATE, 'YYYY-MM-DD')    MINSERTDATE
       ,TO_CHAR(A.MUPDATEDATE, 'YYYY-MM-DD')    MUPDATEDATE
FROM MVC_MEMBER A
WHERE A.MDELETEYN = 'Y'
ORDER BY 1;
-������ȸ
SELECT  A.MNUM          MNUM
       ,A.MNAME         MNAME
       ,A.MID           MID
       ,A.MPW           MPW
       ,A.MGENDER       MGENDER
       ,A.MBIRTH        MBIRTH
       ,A.MHP           MHP
       ,A.MTEL          MTEL
       ,A.MEMAIL        MEMAIL
       ,A.MZIPCODE      MZIPCODE
       ,A.MADDR         MADDR
       ,A.MADDRDETAIL   MADDRDETAIL
       ,A.MGIBUN        MGIBUN
       ,A.MHOBBY        MHOBBY
       ,A.MINFO         MINFO
       ,A.MPHOTO        MPHOTO
       ,A.MDELETEYN     MDELETEYN
       ,TO_CHAR(A.MINSERTDATE, 'YYYY-MM-DD')    MINSERTDATE
       ,TO_CHAR(A.MUPDATEDATE, 'YYYY-MM-DD')    MUPDATEDATE
FROM MVC_MEMBER A
WHERE A.MDELETEYN = 'Y'
    AND A.MNUM = ?;
-���
INSERT INTO MVC_MEMBER
(
        MNUM
       ,MNAME
       ,MID
       ,MPW
       ,MGENDER
       ,MBIRTH
       ,MHP
       ,MTEL 
       ,MEMAIL
       ,MZIPCODE
       ,MADDR
       ,MADDRDETAIL
       ,MGIBUN
       ,MHOBBY
       ,MINFO
       ,MPHOTO
       ,MDELETEYN
       ,MINSERTDATE
       ,MUPDATEDATE
)
VALUES
(
        ?
       ,?
       ,?
       ,?
       ,?
       ,?
       ,?
       ,? 
       ,?
       ,?
       ,?
       ,?
       ,?
       ,?
       ,?
       ,?
       ,'Y'
       ,SYSDATE
       ,SYSDATE
);
-����
UPDATE MVC_MEMBER
SET
         MZIPCODE
        ,MADDR
        ,MGIBUN
        ,MHOBBY
        ,MUPDATEDATE = SYSDATE
WHERE MNUM = '?'
AND  MDELETEYN = 'Y';
-����
UPDATE MVC_MEMBER
SET
       MDELETEYN = 'N'
      ,MUPDATEDATE = SYSDATE
WHERE MNUM = '?'
AND   MDELETEYN = 'Y';
-�α��� Ȯ��
SELECT COUNT(A.MID) NCNT
FROM MVC_MEMBER A
WHERE A.MDELETEYN = 'Y'
    AND A.MID = ?
    AND A.MPW = ?
- ���̵� ã��
SELECT A.MID    MID
FROM MVC_MEMBER A
WHERE A.MDELETEYN = 'Y'
    AND A.MNAME = ?
    AND A.MHP = ?
- ��й�ȣ ã��
SELECT  A.MPW   MPW
       ,A.MID   MID
       ,A.MHP   MHP
FROM MVC_MEMBER A
WHERE A.MDELETEYN = 'Y'
    AND A.MID = ?
    AND A.MHP = ?
- �ӽ� ��й�ȣ ����(���̵�, �ڵ�����ȣ�� Ȯ��)
UPDATE MVC_MEMBER
SET MPW = ?
   ,MUPDATEDATE = SYSDATE
WHERE MID = ?
    AND MHP = ?
    AND MDELETEYN = 'Y'
- �ӽ� ��й�ȣ ����(��й�ȣ�� Ȯ��)
UPDATE MVC_MEMBER
SET MPW = ?
   ,MUPDATEDATE = SYSDATE
WHERE MPW = ?
    AND MDELETEYN = 'Y'

DROP TABLE MVC_BOARD;
2.�Խ��� ������
���̺� ��: MVCBOARD
- ����
CREATE TABLE MVC_BOARD(
	BNUM VARCHAR2(20) PRIMARY KEY 
   ,BSUBJECT VARCHAR2(200)
   ,BWRITER VARCHAR2(200) NOT NULL
   ,BPW VARCHAR2(300) NOT NULL
   ,BMEMO VARCHAR2(2000)
   ,BPHOTO VARCHAR2(2000)
   ,BDELETEYN VARCHAR2(1) NOT NULL
   ,BINSERTDATE DATE
   ,BUPDATEDATE DATE
);
- SYS_c0011536 BNUM
SELECT A.INDEX_NAME, A.COLUMN_NAME
FROM   ALL_IND_COLUMNS A 
WHERE  A.TABLE_NAME = 'MVC_BOARD';
- BNUM ä��
SELECT  /*+ INDEX_DESC(SYS_c0011536) */ 			
NVL(MAX(SUBSTR(A.BNUM, -4)), 0) + 1 COMMNO
FROM    MVC_BOARD A;
- ��ü��ȸ ����¡ ó�� 
SELECT * FROM (
SELECT 
A.BNUM 		BNUM
,A.BSUBJECT  	BSUBJECT
,A.BWRITER  	BWRITER 
,A.BPW  		BPW   	
,A.BDELETEYN 	BDELETEYN	
,TO_CHAR(A.BINSERTDATE, 'YYYY-MM-DD')  BINSERTDATE	
,TO_CHAR(A.BUPDATEDATE, 'YYYY-MM-DD')  BUPDATEDATE	
,A.BMEMO  		BMEMO
,A.BPHOTO  		BPHOTO
,CEIL(ROW_NUMBER() OVER(ORDER BY A.BNUM DESC) / ? ) PAGENO
,COUNT(A.BNUM) OVER() AS TOTALCOUNT
FROM 
MVC_BOARD A 
WHERE A.BDELETEYN = 'Y'
ORDER BY 1 DESC
	) WHERE PAGENO = ?
- ��ü��ȸ
SELECT  
        B.BNUM  BNUM
       ,B.BSUBJECT  BSUBJECT
       ,B.BWRITER   BWRITER
       ,B.BPW   BPW
       ,B.BMEMO BMEMO
       ,B.BDELETEYN BDELETEYN
       ,TO_CHAR(B.BINSERTDATE, 'YYYY-MM-DD')    BINSERTDATE
       ,TO_CHAR(B.BUPDATEDATE, 'YYYY-MM-DD')    BUPDATEDATE
FROM 
        MVC_BOARD B
WHERE B.DELETEYN = 'Y'
ORDER BY 1;
-������ȸ
SELECT  
        B.BNUM  BNUM
       ,B.BSUBJECT  BSUBJECT
       ,B.BWRITER   BWRITER
       ,B.BPW   BPW
       ,B.BMEMO BMEMO
       ,B.BDELETEYN BDELETEYN
       ,TO_CHAR(B.BINSERTDATE, 'YYYY-MM-DD')    BINSERTDATE
       ,TO_CHAR(B.BUPDATEDATE, 'YYYY-MM-DD')    BUPDATEDATE
FROM 
        MVC_BOARD B 
WHERE B.BDELETEYN = 'Y'
AND B.BNUM = ?;
-���
INSERT INTO 
    MVC_BOARD
        (
        BNUM
       ,BSUBJECT
       ,BWRITER
       ,BPW
       ,BMEMO
       ,BDELETEYN
       ,BINSERTDATE 
       ,BUPDATEDATE
        )
VALUES  (
        ?
       ,?
       ,?
       ,?
       ,?
       ,?
       ,SYSDATE
       ,SYSDATE
);
-����
UPDATE 
    MVC_BOARD
SET
        ��׸�         = ?       
       ,BUPDATEDATE = SYSDATE
WHERE BNUM = ?
AND  BDELETEYN = 'Y';
-����
UPDATE 
    MVC_BOARD
SET
       BDELETEYN = 'N'
      ,BUPDATEDATE = SYSDATE
WHERE BNUM = ?
AND   BDELETEYN = 'Y';
- �Խ���(MVC_BOARD) ��й�ȣ(BPW) Ȯ��
SELECT 
COUNT(A.BPW)  NCNT 
FROM MVC_BOARD A 
WHERE A.BDELETEYN 	= 'Y'
AND   A.BNUM = ?
AND   A.BPW = ? 

3.��� �Խ��� ������
�Խ������̺� �� : MVC_RBOARD
- ����
CREATE TABLE MVC_RBOARD(
	RBNUM VARCHAR2(20) PRIMARY KEY 
   ,RBSUBJECT VARCHAR2(200)
   ,RBWRITER VARCHAR2(200) NOT NULL
   ,RBPW VARCHAR2(300) NOT NULL
   ,RBMEMO VARCHAR2(2000)
   ,BNUM VARCHAR2(20)
   ,RBDELETEYN VARCHAR2(1) NOT NULL
   ,RBINSERTDATE DATE
   ,RBUPDATEDATE DATE
);
- SYS_c0011522 RBNUM
SELECT A.INDEX_NAME, A.COLUMN_NAME
FROM   ALL_IND_COLUMNS A 
WHERE  A.TABLE_NAME = 'MVC_RBOARD';
- ��ü��ȸ
SELECT  RBNUM
       ,RBSUBJECT
       ,RBWRITER
       ,RBPW
       ,RBMEMO
       ,BNUM
       ,RBDELETEYN
       ,RBINSERTDATE
       ,RBUPDATEDATE FROM MVC_RBOARD;
-������ȸ
SELECT  RBNUM
       ,RBSUBJECT
       ,RBWRITER
       ,RBPW
       ,RBMEMO
       ,BNUM
       ,RBDELETEYN
       ,RBINSERTDATE
       ,RBUPDATEDATE
FROM MVC_RBOARD WHERE RBDELETEYN = 'Y';
-���
INSERT INTO 
    MVC_RBOARD
        (
        RBNUM
       ,RBSUBJECT
       ,RBWRITER
       ,RBPW
       ,RBMEMO
       ,BNUM
       ,RBDELETEYN
       ,RBINSERTDATE
       ,RBUPDATEDATE
)
VALUES
(
        ?
       ,?
       ,?
       ,?
       ,?
       ,?
       ,?
       ,SYSDATE
       ,SYSDATE
);
-����
UPDATE MVC_RBOARD
SET
        ��׸�         = '?'       
       ,RBUPDATEDATE = SYSDATE
WHERE RBNUM = '?'
AND  RBDELETEYN = 'Y';
-����
UPDATE MVC_RBOARD
SET
       RBDELETEYN = 'N'
      ,RBUPDATEDATE = SYSDATE
WHERE RBNUM = '?'
AND   RBDELETEYN = 'Y';