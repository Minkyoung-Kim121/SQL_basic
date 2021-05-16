-- view �� ����� ���� �а� ���Ⱑ ����������
-- ��������� READ, READ ON �� ����ϴ� ���� ����(?)
-- ���� VIEW ���� �������� �����͸� ������Ʈ �ϱ� �����Ѵٸ� ��Ʈ���ϱ� ���������.

-- 01) VIEW ����
COMMIT 
-- ���� ���̺� �÷����� ������ ����� ���� �ʴ´�.
-- VIEW �� �����Ǵ� �÷����� �׻� �⺻ ���̺��� ��ȸ�� �÷����� �־�� �ϸ�,
-- �������̺� ���� �÷����� ��쿡��, ������ �÷����� ���� ��
-- VIEW �� ������ �Ѵ�.

-- �ܼ� view ����� : �ܼ� ��� �⺻ ���̺� �ϳ��� ����� view.
CREATE OR REPLACE VIEW VIEW_SAL
AS 
SELECT DEPTNO, SUM(SAL) AS SUMSAL, AVG(SAL) AS AVGSAL
FROM EMP_KMK
GROUP BY DEPTNO;
SELECT * FROM VIEW_SAL;

-- 02) VIEW �� ������ �ֱ�
-- EMP ���̺��� EMPNO, ENAME, SAL, DEPTNO �� VIEW_EMP10 ���� ����
-- �μ�Ʈ �غ���
SELECT * FROM EMP_KMK
SELECT A.EMPNO, A.JOB, A.SAL, A.DEPTNO
FROM EMP_KMK A;

CREATE OR REPLACE VIEW VIEW_EMP10
AS
SELECT A.EMPNO, A.JOB, A.SAL, A.DEPTNO
FROM EMP_KMK A;
SELECT * FROM VIEW_EMP10
-- DESC JOB VIEW_EMP10
INSERT INTO VIEW_EMP10 VALUES(8000, 'ANGEL', 7000, 10);
COMMIT; -- VIEW ���� INSERT �ϸ� COMMIT ���� �ʾƵ� ���������� �� ���� �ȴ�.
ROLLBACK; -- VIEW ���� INSERT �ϸ� ROLLBACK �ص� �� �� ������.

-- *����* ���� VIEW �� ���� INSERT ����ϸ� �� �ȴ�.

-- 03) �ܼ� VIEW�� DML ��ɾ�� ������ �Ұ����� ���
-- ����Ŭ �ڰ��� �غ� ����
-- P.95
-- 1. VIEW ���ǿ� ���Ե��� ���� �÷� ��
--    �⺻���̺��� �÷��� NOT NULL ���� ������ �����Ǿ� �ִ� ���,
--    INSERT ���� ���Ұ���.
-- 2. SAL*12ȭ ���� ��� ǥ�������� ���ǵ� ���� �÷��� VIEW �� ���ǵǸ�
--    INSERT �� UPDATE �� �Ұ����ϴ�.
-- 3. DISTINCT �� ������ ��쿡�� DML(INSERT, UPDATE, DELETE) ����� ���X
-- 4. �׷��Լ��� GROUP BY ���� ������ ��쿡�� DML ����� ��� X

-- 04) 
SELECT * FROM VIEW_SAL;
SELECT   DEPTNO
        ,SUM(SAL) AS SUMSAL
        ,AVG(SAL) AS AVGSAL
FROM EMP_KMK
GROUP BY DEPTNO;
SELECT * FROM EMP_KMK;
SELECT 1,2,3 FROM EMP_KMK;

-- 05) VIEW ����
-- ��� �������̺��̱� ������ �並 �����ϴ� ���� ������ ��ųʸ��� ����� ���� ���Ǹ�
-- �����ϴ� ���� �ǹ�.
DROP VIEW ���̸�;

-- 06) FORCE : ���̺� ���� VIEW�� �����ϱ� ���� ���
-- ����Ʈ�� NOFORCE
-- NOFORCE �� ������ �ϰ� ���� ����(����)�Ϸ��� �ϴ� ���̰�,
-- FORCE �� ������ �� �ϰ� ����(����)�ϴ� ��
-- �⺻ ���̺��� �������� �ʴ��� �並 �����Ϸ��� FORCE �ɼ��� ����Ѵ�.

CREATE OR REPLACE NOFORCE VIEW VIEW_NOTABLE
AS
SELECT EMPNO, ENAME, DEPTNO
FROM EMP03
WHERE DEPTNO = 10;
-- ���̺� �Ǵ� �䰡 �������� �ʽ��ϴ�

CREATE OR REPLACE FORCE VIEW VIEW_NOTABLE_1
AS
SELECT EMPNO, ENAME, DEPTNO
FROM EMP02
WHERE DEPTNO = 10;
-- ���: ������ ������ �Բ� �䰡 �����Ǿ����ϴ�.

-- 07) WITH CHECK OPTION
-- WITH CHECK OPTION �� ����ϸ� �� ���� �� �������� ������ �÷� ����
-- �������� ���ϵ��� �Ѵ�.
CREATE OR REPLACE NOFORCE VIEW VIEW_CHKTEST
AS
SELECT EMPNO, ENAME, SAL, COMM, DEPTNO 
FROM EMP_KMK
WHERE DEPTNO = 20 WITH CHECK OPTION;
-- (SELECT EMPNO, ENAME, SAL, COMM, DEPTNO 
-- FROM EMP_KMK WHERE DEPTNO = 20)�� ���� X ( WITH CHECK OPTION )

SELECT * FROM VIEW_CHKTEST;

UPDATE VIEW_CHKTEST
SET DEPTNO = 10
WHERE SAL >= 3000;  -- ���� WITH CHECK OPTION�� ���ǿ� ���� �˴ϴ�
-- ���� ���ϰ� �����߱� ������ UPDATE �� ��.

-- 08) WITH READ ONLY
-- �並 ���ؼ��� �⺻���̺��� � �÷��� ���ؼ��� ������ ���� ���� ���ϰ� �ϴ� ��
-- cf. WITH CHECT OPTION �� ���ǿ� ����� �÷��� ���� ���� ���ϰ� �ϴ� ��
--        WHIT READ ONLY �� �⺻���̺��� ��� �����͸� ���� ���ϰ� �ϴ� ��
-- => ����Ŭ������ ���� ��� WITH READ ONLY �� �� ����ϸ� �ȴ�. (�ٸ��� �ʿ�X)
CREATE OR REPLACE VIEW VIEW_READ30
AS
SELECT EMPNO, ENAME, SAL, COMM, DEPTNO
FROM EMP_KMK
WHERE DEPTNO = 30 WITH READ ONLY;

SELECT * FROM VIEW_READ30;

UPDATE VIEW_READ30
SET COMM = 1000
WHERE ENAME = 'TURNER';
-- �б� ���� �信���� DML �۾��� ������ �� �����ϴ�.

-- 09) ������ SEQUENCE
-- ����Ŭ ������ : �ڵ� �����ϵ��� ���ִ� ���
-- * CACHE(ĳ��) n | NOCACHE
--         : ����Ŭ ������ �̸� �����ϰ� �޸𸮿� ������ ���� ����, ����Ʈ ���� 2 *
-- �������� �����ϸ�  KMK00 ������ ���̺� �����̽�(��ųʸ� ���̺�)�� ���������.
-- �������� �����Ϸ��� �ش� ������ �������� ����� ������ �־�� �ϴµ�,
-- �̴� SYS, SYSTEM �������� �ο��Ѵ�. (GRANT CREATE SEQUENCE TO KMK00;)
-- ���������� �׻� UNIQUE �ؾ��Ѵ�. 
-- �������� PRIMARY KEY ���� ������ �Ѵ�.
-- (PRIMARY KEY �� �Ѿ���� �ʱ� ������ ���� �����ϸ� PK�� ������ �Ѵ�.)

CREATE SEQUENCE EMP_SEQ
START WITH 1
INCREMENT BY 3
MAXVALUE 1000000;
-- START ���� 1�̰�, INCREAMENT BY 3 (3�� ����), �ִ��� 100000�� �Ǵ� ������ ����

CREATE TABLE EMP01
AS 
SELECT EMPNO, ENAME, HIREDATE
FROM EMP_KMK WHERE 1=0;
SELECT * FROM EMP01;
-- �������� ����ϱ� ���� ������ ���� ����ִ� ���̺� EMP01�� ����

DROP TABLE EMP01;

CREATE TABLE EMP01
AS
SELECT EMPNO, ENAME, HIREDATE
FROM EMP_KMK 
WHERE 1=0;
-- ������ ������(EMP_SEQ)�� �����ϱ� ���� ����ִ� ���̺� EMP01�� ���Ӱ� ����
-- Q)������ �� ��ü�� ����� �� ���� �����̺�(?) �� �־�� ��밡��??

INSERT INTO EMP01
VALUES(EMP_SEQ.NEXTVAL, 'JULIA', SYSDATE);
-- EMP_SEQ �������κ��� �����ȣ�� �ڵ����� �Ҵ�޾Ƽ� �����͸� INSERT INTO ��
-- .NEXTVAL : ���� ������ ���� ���� ���� ��ȯ

SELECT * FROM EMP01;
-- 2	JULIA	20/11/16 12:44:15

SELECT EMP_SEQ.CURRVAL FROM DUAL; -- 2
-- .CURRVAL : ���� �������� ���� ��ȯ
ROLLBACK; -- ������ ������.
DROP SEQUENCE EMP_SEQ;
COMMIT;

-- 09-1) EMP04 ���̺� ����, �÷� : EMPNO, ENAME, SAL
-- EMP04_SEQ ������ ���� : 1���� 1�� ���� MAX 1000;
CREATE SEQUENCE EMP04_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 1000;

CREATE TABLE EMP04
AS
SELECT EMPNO, ENAME, SAL
FROM EMP_KMK
WHERE 1=0;
DROP TABLE EMP04;
CREATE TABLE EMP04
AS
SELECT EMPNO, ENAME, SAL 
FROM EMP_KMK
WHERE 1=0;

-- �������� PK���� ������, PK�� �Ѿ���� �ʱ� ������ ���� ������ �Ѵ�.
ALTER TABLE EMP04
ADD CONSTRAINT PK_EMP04_EMPNO PRIMARY KEY (EMPNO);
-- PK_���̺��_�÷���
DESC EMP04; -- EMPNO -> NOT NULL (PK �����߱� ����)

INSERT INTO EMP04
VALUES (EMP04_SEQ.NEXTVAL, 'TEST', '3000');

SELECT * FROM EMP04;
SELECT EMP04_SEQ.CURRVAL FROM DUAL;
SELECT EMP04_SEQ.NEXTVAL FROM DUAL;

-- 10) �ƽ� ä�� MAX + 1 ������ ����ϴ� ��쵵 �ִ�.
-- ä�� ���� : ��ȣ�� ä���ϴ� ����
--          �������� ���е� ī��Ʈ�ؼ� ���� ��ȣ�� �ԷµǹǷ� �̸� �����ϱ� ����
--          ������ ���� ¥�� �̿��Ѵ�.
--          .NEXTVAL �� �߸��ص� ������ ��ȣ�� ����� �Է��� �� �ȴ�.
SELECT 1 FROM DUAL; -- 1
SELECT MAX(1) FROM DUAL; -- 1
SELECT MAX(NULL) FROM DUAL; -- NULL
SELECT NVL(MAX(NULL), 0) FROM DUAL; -- 0
SELECT NVL(MAX(NULL), 100) FROM DUAL; -- 100
SELECT NVL(MAX(NULL), 1) +1 AS COMM FROM DUAL; -- 2

-- 10-1) ���� �����
SELECT LPAD(NVL(MAX(NULL), 0) +1, 4, '0') AS COMM FROM DUAL; -- 0001
SELECT LPAD(NVL(MAX(NULL), 0) +1, 5, '0') AS COMM FROM DUAL; -- 00001
SELECT LPAD(NVL(MAX(NULL), 0) +1, 7, '0') AS COMM FROM DUAL; -- 0000001
SELECT LPAD(NVL(MAX(NULL), 0) +1, 7, '$') AS COMM FROM DUAL; -- $$$$$$1
SELECT RPAD(NVL(MAX(NULL), 0) +1, 7, '$') AS COMM FROM DUAL; -- 1$$$$$$
-- NULL : �ƹ��͵� ���� ������. ������ ������� X
SELECT   TO_CHAR(SYSDATE, 'YYYYMMDD') || 
          LPAD(NVL(MAX(NULL), 0) +1, 4, '0') AS COMM
FROM DUAL; -- 202011160001
SELECT   TO_CHAR(SYSDATE, 'YYYY*MM*DD*') || 
          LPAD(NVL(MAX(NULL), 0) +1, 4, '0') AS COMM
FROM DUAL; -- 2020*11*16*0001

SELECT  'B*' || 
        TO_CHAR(SYSDATE, 'YYYYMMDD*') || 
        LPAD(NVL(MAX(NULL), 0) + 1, 4 , '0') AS COMM
FROM DUAL; -- B*20201116*0001

SELECT   'B' ||
         TO_CHAR(SYSDATE, 'YYYY-') ||
         LPAD(NVL(MAX(NULL), 0) + 1, 4 , '0') AS COMM 
FROM DUAL; -- B2020-0001

-- 10-2) MAX_TABLE ���� ä�� ���� Ȯ���ϱ�
CREATE TABLE MAX_TABLE(
     MAXNUM VARCHAR2(20) PRIMARY KEY
    ,INSERTDATE DATE
    ,UPDATEDATE DATE);
-- ä�� ������ ���ڸ� ���� �ʰ� ����(VARCHAR2)�� ����.
DESC MAX_TABLE;
DROP TABLE MAX_TABLE;
SELECT * FROM MAX_TABLE;
INSERT INTO MAX_TABLE(
    SELECT COMM, ISYS, USYS FROM(
        SELECT   NVL(MAX(MAXNUM), 0)  + 1 COMM 
                ,TO_CHAR(SYSDATE, 'YYYYMMDD') ISYS
                ,TO_CHAR(SYSDATE, 'YYYYMMDD') USYS
        FROM MAX_TABLE) 
);
-- + Į������ ������ INSERT ����
-- : ���̺� ���� �߰��Ҷ� ��� Ư�� �÷��� �ƴ� ��� �÷��� �ڷḦ �Է��ϴ� ��쿡��,
--  ���� �÷������ ������� �ʾƵ� ����.
--  �÷� ����� �����Ǹ� VALUES �� ������ ������ ���̺��� �⺻ �÷� ������� �Էµ�.
-- Q) VALUES �� ������ ����?

SELECT NVL(MAX(MAXNUM), 0) +1 COMM FROM MAX_TABLE; -- 10
-- ���� �߰��ϸ� ���� �޶�����. MAX(MAXNUM)�� �޶����� ����.

-- 11) MAX_TABLE ���� ���� Ȯ���غ���
DROP TABLE MAX_TABLE;
SELECT * FROM MAX_TABLE;
INSERT INTO MAX_TABLE VALUES('202011160001', SYSDATE, SYSDATE);
-- ROLLBACK;
COMMIT;
SELECT MAXNUM FROM MAX_TABLE;
-- 11-1) MAXNUM �÷��� �ִ� ������ 20201110001 �ɰ��� �ѹ����ϱ�
SELECT SUBSTR(MAXNUM, 9) FROM MAX_TABLE; -- 0001 (�տ��� ���� �ɰ���)
SELECT SUBSTR(MAXNUM, -4) FROM MAX_TABLE; -- 0001 (�ڿ��� ���� �ɰ���)
SELECT SUBSTR(MAXNUM, -4) +1 FROM MAX_TABLE;  -- 2
SELECT MAX(SUBSTR(MAXNUM, -4)) +1 FROM MAX_TABLE; -- 2
SELECT NVL(MAX(SUBSTR(MAXNUM, -4)), 0) +1 FROM MAX_TABLE; -- 2
SELECT NVL(MAX(SUBSTR(MAXNUM, 9)), 0) +1 FROM MAX_TABLE; -- 2
-- �ѹ��� �����Ϸ��� ���� ����, ������� �������� ¥�鼭 ��Ȯ�� ������
SELECT SUBSTR(MAXNUM, 5, 4) FROM MAX_TABLE; -- 1116
SELECT SUBSTR(MAXNUM, -8, 4) FROM MAX_TABLE; -- 1116
SELECT SUBSTR(MAXNUM, -8, 2) FROM MAX_TABLE; -- 11

-- 11-2) �ٽ� �ٽ�
DROP TABLE MAX_TABLE;
INSERT INTO MAX_TABLE(
    SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') ||
    LPAD(NVL(MAX(SUBSTR(MAXNUM, -4)), 0) +1, 4, '0') COMM
    ,SYSDATE
    ,SYSDATE
FROM MAX_TABLE);
SELECT * FROM MAX_TABLE;

SELECT 'M' || TO_CHAR(SYSDATE, 'YYYYMMDD') ||
        LPAD(NVL(MAX(SUBSTR(MAXNUM, -4)), 0) +1, 4, '0') COMM
FROM MAX_TABLE;    -- 0.002��

-- ����Ŭ ��Ʈ
SELECT /*+ INDEX_DESC(SYS_C0011088) */
        'M' || TO_CHAR(SYSDATE, 'YYYYMMDD') ||
        LPAD(NVL(MAX(SUBSTR(MAXNUM, -4)), 0) +1, 4, '0') COMM
FROM MAX_TABLE; -- M202011160002        -- 0��
-- /*+ INDEX_DESC(SYS_C0011088) */
-- : �̰� ���� ��ȸ ������.
-- ����Ŭ ��Ʈ : MAX ä�� ���� ����� �� �ݵ�� �ۼ��ض�! 
-- ����Ŭ : ��Ƽ������(���࿣��) = �ڹ� : JVM(���࿣��)

-- ����Ŭ ��Ʈ�� C0011088 ���� ����:
SELECT A.INDEX_NAME FROM ALL_IND_COLUMNS A
WHERE A.TABLE_NAME = 'MAX_TABLE'; -- SYS_C0011088

-- => ������ ä�� ���� �� �� �ڹ� ������ �Ʒ��� ���������� ����ض�
SELECT /*+ INDEX_DESC(SYS_C0011088) */
		NVL(MAX(SUBSTR(MAXNUM, -4)), 0) +1 COMM
FROM MAX_TABLE;
-- + JAVA �� ä�� ���� INSERT �ϱ� MaxTableTest.java

SELECT * FROM MAX_TABLE;
