-- view 는 만들어 놓고 읽고 쓰기가 가능하지만
-- 기능적으로 READ, READ ON 만 사용하는 것이 낫다(?)
-- 만약 VIEW 에서 물리적인 데이터를 업데이트 하기 시작한다면 컨트롤하기 어려워진다.

-- 01) VIEW 생성
COMMIT 
-- 기존 테이블에 컬럼명이 없으면 만들어 지지 않는다.
-- VIEW 에 생성되는 컬럼명은 항상 기본 테이블에서 조회된 컬럼명이 있어야 하며,
-- 기존테이블에 없는 컬럼명일 경우에는, 가상의 컬럼명을 만든 후
-- VIEW 를 만들어야 한다.

-- 단순 view 만들기 : 단순 뷰는 기본 테이블 하나로 만드는 view.
CREATE OR REPLACE VIEW VIEW_SAL
AS 
SELECT DEPTNO, SUM(SAL) AS SUMSAL, AVG(SAL) AS AVGSAL
FROM EMP_KMK
GROUP BY DEPTNO;
SELECT * FROM VIEW_SAL;

-- 02) VIEW 에 데이터 넣기
-- EMP 테이블에서 EMPNO, ENAME, SAL, DEPTNO 를 VIEW_EMP10 으로 만들어서
-- 인서트 해보기
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
COMMIT; -- VIEW 에서 INSERT 하면 COMMIT 하지 않아도 물리적으로 행 삽입 된다.
ROLLBACK; -- VIEW 에서 INSERT 하면 ROLLBACK 해도 행 안 없어짐.

-- *주의* 복합 VIEW 일 때는 INSERT 사용하면 안 된다.

-- 03) 단순 VIEW에 DML 명령어로 조작이 불가능한 경우
-- 오라클 자격증 준비에 참고
-- P.95
-- 1. VIEW 정의에 포함되지 않은 컬럼 중
--    기본테이블의 컬럼이 NOT NULL 제약 조건이 지정되어 있는 경우,
--    INSERT 문이 사용불가능.
-- 2. SAL*12화 같이 산술 표현식으로 정의된 가상 컬럼이 VIEW 에 정의되면
--    INSERT 나 UPDATE 가 불가능하다.
-- 3. DISTINCT 를 포함한 경우에도 DML(INSERT, UPDATE, DELETE) 명령을 사용X
-- 4. 그룹함수나 GROUP BY 절을 포함한 경우에도 DML 명령을 사용 X

-- 04) 
SELECT * FROM VIEW_SAL;
SELECT   DEPTNO
        ,SUM(SAL) AS SUMSAL
        ,AVG(SAL) AS AVGSAL
FROM EMP_KMK
GROUP BY DEPTNO;
SELECT * FROM EMP_KMK;
SELECT 1,2,3 FROM EMP_KMK;

-- 05) VIEW 삭제
-- 뷰는 가상테이블이기 때문에 뷰를 삭제하는 것은 데이터 딕셔너리에 저장된 뷰의 정의를
-- 삭제하는 것을 의미.
DROP VIEW 뷰이름;

-- 06) FORCE : 테이블 없이 VIEW를 생성하기 위해 사용
-- 디폴트는 NOFORCE
-- NOFORCE 는 컴파일 하고 나서 실행(생성)하려고 하는 것이고,
-- FORCE 는 컴파일 안 하고 실행(생성)하는 것
-- 기본 테이블이 존재하지 않더라도 뷰를 생성하려면 FORCE 옵션을 써야한다.

CREATE OR REPLACE NOFORCE VIEW VIEW_NOTABLE
AS
SELECT EMPNO, ENAME, DEPTNO
FROM EMP03
WHERE DEPTNO = 10;
-- 테이블 또는 뷰가 존재하지 않습니다

CREATE OR REPLACE FORCE VIEW VIEW_NOTABLE_1
AS
SELECT EMPNO, ENAME, DEPTNO
FROM EMP02
WHERE DEPTNO = 10;
-- 경고: 컴파일 오류와 함께 뷰가 생성되었습니다.

-- 07) WITH CHECK OPTION
-- WITH CHECK OPTION 을 사용하면 뷰 생성 시 조건으로 지정한 컬럼 값을
-- 변경하지 못하도록 한다.
CREATE OR REPLACE NOFORCE VIEW VIEW_CHKTEST
AS
SELECT EMPNO, ENAME, SAL, COMM, DEPTNO 
FROM EMP_KMK
WHERE DEPTNO = 20 WITH CHECK OPTION;
-- (SELECT EMPNO, ENAME, SAL, COMM, DEPTNO 
-- FROM EMP_KMK WHERE DEPTNO = 20)는 변경 X ( WITH CHECK OPTION )

SELECT * FROM VIEW_CHKTEST;

UPDATE VIEW_CHKTEST
SET DEPTNO = 10
WHERE SAL >= 3000;  -- 뷰의 WITH CHECK OPTION의 조건에 위배 됩니다
-- 변경 못하게 지정했기 때문에 UPDATE 안 됨.

-- 08) WITH READ ONLY
-- 뷰를 통해서는 기본테이블의 어떤 컬럼에 대해서도 내용을 절대 변경 못하게 하는 것
-- cf. WITH CHECT OPTION 은 조건에 사용한 컬럼의 값을 수정 못하게 하는 것
--        WHIT READ ONLY 는 기본테이블의 모든 데이터를 수정 못하게 하는 것
-- => 오라클에서는 복합 뷰로 WITH READ ONLY 를 잘 사용하면 된다. (다른건 필요X)
CREATE OR REPLACE VIEW VIEW_READ30
AS
SELECT EMPNO, ENAME, SAL, COMM, DEPTNO
FROM EMP_KMK
WHERE DEPTNO = 30 WITH READ ONLY;

SELECT * FROM VIEW_READ30;

UPDATE VIEW_READ30
SET COMM = 1000
WHERE ENAME = 'TURNER';
-- 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.

-- 09) 시퀀스 SEQUENCE
-- 오라클 시퀀스 : 자동 증가하도록 해주는 기능
-- * CACHE(캐쉬) n | NOCACHE
--         : 오라클 서버가 미리 지정하고 메모리에 유지할 값의 수로, 디폴트 값은 2 *
-- 시퀀스를 생성하면  KMK00 계정의 테이블 스페이스(딕셔너리 테이블)에 만들어진다.
-- 시퀀스를 생성하려면 해당 계정에 시퀀스를 만드는 권한이 있어야 하는데,
-- 이는 SYS, SYSTEM 계정에서 부여한다. (GRANT CREATE SEQUENCE TO KMK00;)
-- 시퀀스명은 항상 UNIQUE 해야한다. 
-- 시퀀스는 PRIMARY KEY 에서 만들어야 한다.
-- (PRIMARY KEY 는 넘어오지 않기 때문에 새로 생성하면 PK를 만들어야 한다.)

CREATE SEQUENCE EMP_SEQ
START WITH 1
INCREMENT BY 3
MAXVALUE 1000000;
-- START 값이 1이고, INCREAMENT BY 3 (3씩 증가), 최댓값이 100000이 되는 시퀀스 생성

CREATE TABLE EMP01
AS 
SELECT EMPNO, ENAME, HIREDATE
FROM EMP_KMK WHERE 1=0;
SELECT * FROM EMP01;
-- 시퀀스를 사용하기 위해 데이터 없이 비어있는 테이블 EMP01을 생성

DROP TABLE EMP01;

CREATE TABLE EMP01
AS
SELECT EMPNO, ENAME, HIREDATE
FROM EMP_KMK 
WHERE 1=0;
-- 생성된 시퀀스(EMP_SEQ)를 생성하기 위해 비어있는 테이블 EMP01를 새롭게 생성
-- Q)시퀀스 그 자체를 출력할 수 없고 빈테이블(?) 에 넣어야 사용가능??

INSERT INTO EMP01
VALUES(EMP_SEQ.NEXTVAL, 'JULIA', SYSDATE);
-- EMP_SEQ 시퀀스로부터 사원번호를 자동으로 할당받아서 데이터를 INSERT INTO 함
-- .NEXTVAL : 현재 시퀀스 값의 다음 값을 반환

SELECT * FROM EMP01;
-- 2	JULIA	20/11/16 12:44:15

SELECT EMP_SEQ.CURRVAL FROM DUAL; -- 2
-- .CURRVAL : 현재 시퀀스의 값을 반환
ROLLBACK; -- 시퀀스 삭제됨.
DROP SEQUENCE EMP_SEQ;
COMMIT;

-- 09-1) EMP04 테이블 생성, 컬럼 : EMPNO, ENAME, SAL
-- EMP04_SEQ 시퀀스 생성 : 1부터 1씩 증가 MAX 1000;
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

-- 시퀀스는 PK에서 만들어야, PK는 넘어오지 않기 때문에 새로 만들어야 한다.
ALTER TABLE EMP04
ADD CONSTRAINT PK_EMP04_EMPNO PRIMARY KEY (EMPNO);
-- PK_테이블명_컬럼명
DESC EMP04; -- EMPNO -> NOT NULL (PK 지정했기 때문)

INSERT INTO EMP04
VALUES (EMP04_SEQ.NEXTVAL, 'TEST', '3000');

SELECT * FROM EMP04;
SELECT EMP04_SEQ.CURRVAL FROM DUAL;
SELECT EMP04_SEQ.NEXTVAL FROM DUAL;

-- 10) 맥스 채번 MAX + 1 로직을 사용하는 경우도 있다.
-- 채번 로직 : 번호를 채집하는 로직
--          시퀀스는 실패도 카운트해서 다음 번호로 입력되므로 이를 보완하기 위해
--          로직을 새로 짜서 이용한다.
--          .NEXTVAL 을 잘못해도 시퀀스 번호가 제대로 입력이 안 된다.
SELECT 1 FROM DUAL; -- 1
SELECT MAX(1) FROM DUAL; -- 1
SELECT MAX(NULL) FROM DUAL; -- NULL
SELECT NVL(MAX(NULL), 0) FROM DUAL; -- 0
SELECT NVL(MAX(NULL), 100) FROM DUAL; -- 100
SELECT NVL(MAX(NULL), 1) +1 AS COMM FROM DUAL; -- 2

-- 10-1) 형식 만들기
SELECT LPAD(NVL(MAX(NULL), 0) +1, 4, '0') AS COMM FROM DUAL; -- 0001
SELECT LPAD(NVL(MAX(NULL), 0) +1, 5, '0') AS COMM FROM DUAL; -- 00001
SELECT LPAD(NVL(MAX(NULL), 0) +1, 7, '0') AS COMM FROM DUAL; -- 0000001
SELECT LPAD(NVL(MAX(NULL), 0) +1, 7, '$') AS COMM FROM DUAL; -- $$$$$$1
SELECT RPAD(NVL(MAX(NULL), 0) +1, 7, '$') AS COMM FROM DUAL; -- 1$$$$$$
-- NULL : 아무것도 없는 데이터. 연산을 허용하지 X
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

-- 10-2) MAX_TABLE 만들어서 채번 로직 확인하기
CREATE TABLE MAX_TABLE(
     MAXNUM VARCHAR2(20) PRIMARY KEY
    ,INSERTDATE DATE
    ,UPDATEDATE DATE);
-- 채번 로직은 숫자를 쓰지 않고 문자(VARCHAR2)를 쓴다.
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
-- + 칼럼명을 생략한 INSERT 구문
-- : 테이블에 행을 추가할때 몇몇 특정 컬럼이 아닌 모든 컬럼에 자료를 입력하는 경우에는,
--  굳이 컬럼목록을 기술하지 않아도 괜춘.
--  컬럼 목록이 생략되면 VALUES 절 다음의 값들이 테이블의 기본 컬럼 순서대로 입력됨.
-- Q) VALUES 를 생략한 이유?

SELECT NVL(MAX(MAXNUM), 0) +1 COMM FROM MAX_TABLE; -- 10
-- 행을 추가하면 값이 달라진다. MAX(MAXNUM)가 달라지기 때문.

-- 11) MAX_TABLE 만들어서 예제 확인해보기
DROP TABLE MAX_TABLE;
SELECT * FROM MAX_TABLE;
INSERT INTO MAX_TABLE VALUES('202011160001', SYSDATE, SYSDATE);
-- ROLLBACK;
COMMIT;
SELECT MAXNUM FROM MAX_TABLE;
-- 11-1) MAXNUM 컬럼에 있는 데이터 20201110001 쪼개서 넘버링하기
SELECT SUBSTR(MAXNUM, 9) FROM MAX_TABLE; -- 0001 (앞에서 부터 쪼개기)
SELECT SUBSTR(MAXNUM, -4) FROM MAX_TABLE; -- 0001 (뒤에서 부터 쪼개기)
SELECT SUBSTR(MAXNUM, -4) +1 FROM MAX_TABLE;  -- 2
SELECT MAX(SUBSTR(MAXNUM, -4)) +1 FROM MAX_TABLE; -- 2
SELECT NVL(MAX(SUBSTR(MAXNUM, -4)), 0) +1 FROM MAX_TABLE; -- 2
SELECT NVL(MAX(SUBSTR(MAXNUM, 9)), 0) +1 FROM MAX_TABLE; -- 2
-- 한번에 이해하려고 하지 말고, 순서대로 쿼리문을 짜면서 정확히 만들어내기
SELECT SUBSTR(MAXNUM, 5, 4) FROM MAX_TABLE; -- 1116
SELECT SUBSTR(MAXNUM, -8, 4) FROM MAX_TABLE; -- 1116
SELECT SUBSTR(MAXNUM, -8, 2) FROM MAX_TABLE; -- 11

-- 11-2) 다시 다시
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
FROM MAX_TABLE;    -- 0.002초

-- 오라클 힌트
SELECT /*+ INDEX_DESC(SYS_C0011088) */
        'M' || TO_CHAR(SYSDATE, 'YYYYMMDD') ||
        LPAD(NVL(MAX(SUBSTR(MAXNUM, -4)), 0) +1, 4, '0') COMM
FROM MAX_TABLE; -- M202011160002        -- 0초
-- /*+ INDEX_DESC(SYS_C0011088) */
-- : 이걸 쓰면 조회 빠르다.
-- 오라클 힌트 : MAX 채번 로직 사용할 때 반드시 작성해라! 
-- 오라클 : 옵티마이저(실행엔진) = 자바 : JVM(실행엔진)

-- 오라클 힌트에 C0011088 쓰는 이유:
SELECT A.INDEX_NAME FROM ALL_IND_COLUMNS A
WHERE A.TABLE_NAME = 'MAX_TABLE'; -- SYS_C0011088

-- => 앞으로 채번 로직 쓸 때 자바 연동된 아래의 쿼리문으로 사용해라
SELECT /*+ INDEX_DESC(SYS_C0011088) */
		NVL(MAX(SUBSTR(MAXNUM, -4)), 0) +1 COMM
FROM MAX_TABLE;
-- + JAVA 로 채번 로직 INSERT 하기 MaxTableTest.java

SELECT * FROM MAX_TABLE;
