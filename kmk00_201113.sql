show user;
-- kmk00 �����Դϴ�.

-- kmk00 �������� SESSION ���Ѹ� �ο��� ����
-- ���̺��� �����Ϸ��� �Ѵ�.
-- -> ����� SYSTEM ���� ������ �ο��� �� ��,
-- ���̺� ���� ������ ������ �ٽ� ���̺��� �����ϸ�
CREATE TABLE EMPTEST(
     EMPNO  NUMBER(4)
    ,ENAME  VARCHAR2(20)
    ,JOB    VARCHAR2(20)
    ,DEPTNO NUMBER(2)
);
-- �����ȴ�.
SELECT * FROM EMPTEST;

SELECT * FROM TAB;

SELECT * FROM SCOTT.EMP;
SELECT * FROM SCOTT.DEPT;
SELECT * FROM SCOTT.SALGRADE;

CREATE TABLE EMP_KMK
AS
SELECT * FROM SCOTT.EMP WHERE 1=1;

CREATE TABLE DEPT_KMK
AS
SELECT * FROM SCOTT.EMP WHERE 1=1;

CREATE TABLE SALGRADE_KMK
AS
SELECT * FROM SCOTT.EMP WHERE 1=1;

CREATE TABLE DEPT_KMK
AS
SELECT * FROM SCOTT.DEPT WHERE 1=1;

SELECT * FROM TAB;

-- create table ~ as �������� ���̺� �����ؿ��� �÷���� �����ʹ� ���������,
-- ��Ű��(������Ʈ)�� �� �Ѿ�ͼ� ���� �Ѱܾ� �Ѵ�.
-- ��Ű��(������Ʈ) : PK, NOT NULL, FK ���� 
-- �ɼ����� ���� �����ؾ� �Ѵ�.

ALTER TABLE DEPT_KMK
ADD CONSTRAINT PK_DEPTNO PRIMARY KEY (DEPTNO);


