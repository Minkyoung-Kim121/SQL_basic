-- <REVIEW>
-- 01) MAX() ä�� ����
SELECT 1 FROM DUAL;
SELECT NULL FROM DUAL;
SELECT NULL +1 FROM DUAL;
SELECT MAX(1) FROM DUAL;
-- ���̺��� ó�� �����Ǹ� �÷��� �����Ͱ� ���� ���°� �Ǵµ�
-- �� ���°� �ٷ� NULL.
SELECT MAX(NULL) FROM DUAL;
SELECT MAX(NULL) +1 FROM DUAL; -- (null) : +1 �� �� ��.

SELECT NVL(MAX(NULL), 0) FROM DUAL; -- 0
SELECT NVL(MAX(NULL), 0) +1 FROM DUAL; -- 1 : NVL() �Լ��� �̿��� +1 �� �����ϰ� ��.
SELECT NVL(MAX(NULL), 0) +1 AS COMMNO FROM DUAL; -- 
-- ^ ������ �ڵ��� ������ DBA ���� �ֱ� ������ ��������� �ϰ� �������� DBA���� �ðܶ� 
-- 01-1) �ڸ��� 4��
-- LPAD() �Լ�
SELECT LPAD(NVL(MAX(NULL), 0) +1, 4, '0') AS COMMNO FROM DUAL; -- 0001

-- 02) �Խ��� �����
-- ��������, �����Խ���, �ϹݰԽ��� ���� �ִ�.
-- �ϹݰԽ��� ä�� �����
SELECT  'B' ||
        LPAD(NVL(MAX(NULL), 0) +1, 4, '0') AS COMMNO
FROM    DUAL;
-- �������� �Խ��� ä�� �����
SELECT  'N' ||
        LPAD(NVL(MAX(NULL), 0) +1, 4, '0') AS COMMNO
FROM    DUAL; -- N0001

SELECT  'N' || TO_CHAR(SYSDATE, 'YYYYMMDD') ||
        LPAD(NVL(MAX(NULL), 0) +1, 4, '0') AS COMMNO
FROM    DUAL; -- N202011170001

SELECT  'N' || TO_CHAR(SYSDATE, 'YYYY') ||
        LPAD(NVL(MAX(NULL), 0) +1, 4, '0') AS COMMNO
FROM    DUAL; -- N20200001

-- 02) ��Ʈ ����
-- /* + */ : ��Ƽ������(OPTIMAIZER) -> ����Ŭ ���� �̸�
--          '�ش� ������ ������ �� ��Ʈ�� �ִ� ��ɾ��� �������ּ���' 
SELECT /*+ INDEX_DESC(�ش� ���̺� �ε�����)*/
FROM DUAL;

-- <TODAY>
-- 01) �ε��� P.112
-- �迭�� ���� ���� : �����͸� ������ ���� ����.
-- �����͸� ã�� �� ���� �÷��� ã�´� -> �ϳ��� �÷����� ROW ������ ã��.
-- ���� �÷��� �����Ͱ� ������, ã�� ����� ����. 
-- �׷��� PK�� ����(NOT NULL �̱� ������)�ؼ� �ش� �÷����� �����͸� ã�� ��.
-- + �÷��� ã�Ƽ� �����͸� ã�� ������ SELECT�� �ϴ� ���� �����ͺ��̽��� ��Ģ
-- => �� ������ ���� ������� �ϱ� ���� PK�� �����Ͽ� �迭�� ���� ������ ã��
-- ��)�ε����� ����� ������ �Ϸù�ȣ�� ������ֱ� ������ �ӵ��� ���� ����.
-- ��)�ε����� �����ϴµ� �ð��� �ɸ��� ������ DML(INSERT/UPDATE/DELETE)�� ���� �Ͼ��
--   ������ ������ ���ϵǰ� �ӵ��� �� ��������.
-- �ε����� ��ü(OBJECT) : ������ �޸𸮿� �����.
-- (�׷��� �ڲ� �ٲٰ� ��ٰ� ����� ������ ����)

-- 02) �ε��� �����
-- �ε��� ���� �� ���ǻ��� : �ε����� �ݵ�� PK �Ǵ� NOT NULL �÷��� �����.
SELECT TABLE_NAME, INDEX_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME IN('EMP_KMK', 'DEPT_KMK', 'MAX_TABLE');

SELECT * FROM TAB;

CREATE TABLE EMP_INDEX
AS
SELECT EMPNO, ENAME, HIREDATE FROM EMP_KMK WHERE 1=0;

SELECT * FROM EMP_INDEX;

-- �̱� �ε���
CREATE INDEX EMP_INDEX_INDEX
ON EMP_INDEX (EMPNO);

-- EMP_INDEX, EMP_KMK, DEPT_KMK, MAX_TABLE ���̺� ������ �ε��� Ȯ���ϱ�
SELECT TABLE_NAME, INDEX_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME IN('EMP_INDEX', 'EMP_KMK', 'DEPT_KMK', 'MAX_TABLE');

-- ���� �ε���
-- ���ÿ� �÷� �� �� �̻��� �ε����� �ο��ϴ� ��
-- ���� ȸ�翡�� ������ 1)���� �ε����� �÷� MAX �� 4��.
--                  2)������ ���� �ε���(MAX 4��)�� ���� �÷����� 3�� ��
-- ���� : �����Ͱ� �߰��� ������ ������ -> �׷��Լ�, ��Ʈ ���� �� ���� -> ���� ����
CREATE INDEX EMP_EMPNO_HIREDATE
ON EMP_INDEX(EMPNO, HIREDATE);

-- 03) SYNONYM : ���Ǿ�
-- DB ��ü�� ���� �������� �ش� ��ü�� ������ ����ڿ��� �ֱ� ������ Ÿ���� ��ü�� �����ϱ� ����
-- �����ڷκ��� ���� ������ �ο��޾ƾ� �Ѵ�.
-- ��ü�� ��ȸ�� �� �����ڸ� �����ϴµ� �� �� ���Ǿ�� �����ϸ� ������ �̸����� ���� �����ϴ�.
-- ������ ���̺� ���� �ٸ� �̸����� ��ü ����O (��ü�� ���� �̸��� ���� �� �ִ�.)

SELECT * FROM SYSTEM.TEST_TABLE;

CREATE SYNONYM MYTEST 
FOR SYSTEM.TEST_TABLE;
-- ORA-01031: ������ ������մϴ�.
-- SYSTEM �������� ���� 
-- GRANT SELECT ON TEST_TABLE TO KMK00; �� ���� �Ѱ��ֱ�
SELECT * FROM SYSTEM.MYTEST;

SELECT * FROM PUBTEST_1;
-- PUBLIC SYNONYM PUBTEST_1

CREATE SYNONYM MYTEST_1 
FOR SYSTEM.TEST_TABLE;
-- GRANT CREATE SYNONYM TO KMK00; �� ������ �Ѱ��� (SYSTEM ��������)
SELECT * FROM KMK00.MYTEST_1;




