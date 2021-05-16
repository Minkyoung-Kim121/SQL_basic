show user;
-- kmk00 계정입니다.

-- kmk00 계정에는 SESSION 권한만 부여된 상태
-- 테이블을 생성하려고 한다.
-- -> 운영계정 SYSTEM 에서 권한을 부여해 준 뒤,
-- 테이블 생성 권한을 가지고 다시 테이블을 생성하면
CREATE TABLE EMPTEST(
     EMPNO  NUMBER(4)
    ,ENAME  VARCHAR2(20)
    ,JOB    VARCHAR2(20)
    ,DEPTNO NUMBER(2)
);
-- 생성된다.
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

-- create table ~ as 구문으로 테이블 복사해오면 컬럼명과 데이터는 복사되지만,
-- 스키마(오브젝트)가 안 넘어와서 내가 넘겨야 한다.
-- 스키마(오브젝트) : PK, NOT NULL, FK 등은 
-- 옵션으로 직접 복사해야 한다.

ALTER TABLE DEPT_KMK
ADD CONSTRAINT PK_DEPTNO PRIMARY KEY (DEPTNO);


