-- <REVIEW>
-- 01) MAX() 채번 복습
SELECT 1 FROM DUAL;
SELECT NULL FROM DUAL;
SELECT NULL +1 FROM DUAL;
SELECT MAX(1) FROM DUAL;
-- 테이블이 처음 생성되면 컬럼에 데이터가 없는 상태가 되는데
-- 이 상태가 바로 NULL.
SELECT MAX(NULL) FROM DUAL;
SELECT MAX(NULL) +1 FROM DUAL; -- (null) : +1 이 안 됨.

SELECT NVL(MAX(NULL), 0) FROM DUAL; -- 0
SELECT NVL(MAX(NULL), 0) +1 FROM DUAL; -- 1 : NVL() 함수를 이용해 +1 이 가능하게 함.
SELECT NVL(MAX(NULL), 0) +1 AS COMMNO FROM DUAL; -- 
-- ^ 이후의 코드의 권한은 DBA 에게 있기 때문에 여기까지만 하고 나머지는 DBA에게 맡겨라 
-- 01-1) 자릿수 4개
-- LPAD() 함수
SELECT LPAD(NVL(MAX(NULL), 0) +1, 4, '0') AS COMMNO FROM DUAL; -- 0001

-- 02) 게시판 만들기
-- 공지사항, 업무게시판, 일반게시판 등이 있다.
-- 일반게시판 채번 만들기
SELECT  'B' ||
        LPAD(NVL(MAX(NULL), 0) +1, 4, '0') AS COMMNO
FROM    DUAL;
-- 공지사항 게시판 채번 만들기
SELECT  'N' ||
        LPAD(NVL(MAX(NULL), 0) +1, 4, '0') AS COMMNO
FROM    DUAL; -- N0001

SELECT  'N' || TO_CHAR(SYSDATE, 'YYYYMMDD') ||
        LPAD(NVL(MAX(NULL), 0) +1, 4, '0') AS COMMNO
FROM    DUAL; -- N202011170001

SELECT  'N' || TO_CHAR(SYSDATE, 'YYYY') ||
        LPAD(NVL(MAX(NULL), 0) +1, 4, '0') AS COMMNO
FROM    DUAL; -- N20200001

-- 02) 힌트 복습
-- /* + */ : 옵티마이저(OPTIMAIZER) -> 오라클 엔진 이름
--          '해당 쿼리를 실행할 때 힌트에 있는 명령어대로 실행해주세요' 
SELECT /*+ INDEX_DESC(해당 테이블 인덱스명)*/
FROM DUAL;

-- <TODAY>
-- 01) 인덱스 P.112
-- 배열을 쓰는 이유 : 데이터를 빠르게 쓰기 위해.
-- 데이터를 찾을 때 먼저 컬럼을 찾는다 -> 하나의 컬럼으로 ROW 데이터 찾음.
-- 만약 컬럼에 데이터가 없으면, 찾기 힘들어 진다. 
-- 그래서 PK를 지정(NOT NULL 이기 때문에)해서 해당 컬럼으로 데이터를 찾게 함.
-- + 컬럼을 찾아서 데이터를 찾아 빠르게 SELECT를 하는 것이 데이터베이스의 규칙
-- => 이 과정을 더욱 재빠르게 하기 위해 PK를 지정하여 배열로 만들어서 데이터 찾음
-- 장)인덱스를 만들면 가상의 일련번호를 만들어주기 때문에 속도가 빠른 것임.
-- 단)인덱스를 생성하는데 시간이 걸리기 때문에 DML(INSERT/UPDATE/DELETE)가 자주 일어나면
--   오히려 성능이 저하되고 속도가 더 떨어진다.
-- 인덱스는 객체(OBJECT) : 실제로 메모리에 생긴다.
-- (그래서 자꾸 바꾸고 썼다가 지우면 문제가 생김)

-- 02) 인덱스 만들기
-- 인덱스 만들 때 주의사항 : 인덱스는 반드시 PK 또는 NOT NULL 컬럼에 만든다.
SELECT TABLE_NAME, INDEX_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME IN('EMP_KMK', 'DEPT_KMK', 'MAX_TABLE');

SELECT * FROM TAB;

CREATE TABLE EMP_INDEX
AS
SELECT EMPNO, ENAME, HIREDATE FROM EMP_KMK WHERE 1=0;

SELECT * FROM EMP_INDEX;

-- 싱글 인덱스
CREATE INDEX EMP_INDEX_INDEX
ON EMP_INDEX (EMPNO);

-- EMP_INDEX, EMP_KMK, DEPT_KMK, MAX_TABLE 테이블에 설정된 인덱스 확인하기
SELECT TABLE_NAME, INDEX_NAME, COLUMN_NAME
FROM USER_IND_COLUMNS
WHERE TABLE_NAME IN('EMP_INDEX', 'EMP_KMK', 'DEPT_KMK', 'MAX_TABLE');

-- 결합 인덱스
-- 동시에 컬럼 한 개 이상의 인덱스를 부여하는 것
-- 보통 회사에서 제한함 1)결합 인덱스의 컬럼 MAX 는 4개.
--                  2)생성된 결합 인덱스(MAX 4개)에 들어가는 컬럼명은 3개 등
-- 이유 : 데이터가 중간에 없으면 난리남 -> 그룹함수, 힌트 등이 안 먹힘 -> 성능 저하
CREATE INDEX EMP_EMPNO_HIREDATE
ON EMP_INDEX(EMPNO, HIREDATE);

-- 03) SYNONYM : 동의어
-- DB 객체에 대한 소유권은 해당 객체를 생성한 사용자에게 있기 때문에 타인이 객체에 접근하기 위해
-- 소유자로부터 접근 권한을 부여받아야 한다.
-- 객체를 조회할 때 소유자를 지정하는데 이 때 동의어로 정의하면 간단한 이름으로 접근 가능하다.
-- 동일한 테이블에 대해 다른 이름으로 대체 가능O (객체의 원래 이름을 숨길 수 있다.)

SELECT * FROM SYSTEM.TEST_TABLE;

CREATE SYNONYM MYTEST 
FOR SYSTEM.TEST_TABLE;
-- ORA-01031: 권한이 불충분합니다.
-- SYSTEM 계정에서 생성 
-- GRANT SELECT ON TEST_TABLE TO KMK00; 로 권한 넘겨주기
SELECT * FROM SYSTEM.MYTEST;

SELECT * FROM PUBTEST_1;
-- PUBLIC SYNONYM PUBTEST_1

CREATE SYNONYM MYTEST_1 
FOR SYSTEM.TEST_TABLE;
-- GRANT CREATE SYNONYM TO KMK00; 로 권한을 넘겨줌 (SYSTEM 계정에서)
SELECT * FROM KMK00.MYTEST_1;




