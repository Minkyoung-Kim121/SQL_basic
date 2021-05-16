-- DICTIONARY 
SELECT * FROM DICT;
SELECT * FROM DICTIONARY;

SELECT TABLE_NAME FROM USER_TABLES;
-- SELECT * FROM TAB;
SELECT OWNER, TABLE_NAME FROM ALL_TABLES;
-- SYS, SYSTEM 에서 하기 
SELECT * FROM DBA_USERS;
SELECT * FROM DBA_USERS WHERE USERNAME = 'SCOTT';

-- SCALAR SUBQUERY
SELECT EMPNO, ENAME, JOB, SAL
       ,(SELECT GRADE FROM SALGRADE WHERE A.SAL BETWEEN LOSAL AND HISAL) 
         AS SALGRADE
       ,DEPTNO
       ,(SELECT DNAME FROM DEPT B WHERE A.DEPTNO = b.DEPTNO) AS DNAME
FROM    EMP A;  


-- VIEW , WITH
SELECT  ROWNUM, A.*
FROM   (SELECT * FROM EMP B ORDER BY SAL DESC) A;

WITH A AS (SELECT B.* FROM EMP B ORDER BY B.SAL DESC)
SELECT ROWNUM, A.*
FROM   A;

SELECT  ROWNUM, A.*
FROM   (SELECT * FROM EMP B ORDER BY SAL DESC) A
WHERE  ROWNUM <= 3;

WITH A AS (SELECT B.* FROM EMP B ORDER BY B.SAL DESC)
SELECT ROWNUM, A.*
FROM   A
WHERE ROWNUM <= 3;

-- 그룹화 함수 
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM   EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB ;

-- ROLLUP
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM   EMP
GROUP BY ROLLUP (DEPTNO, JOB);

-- CUBE
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
FROM   EMP
GROUP BY CUBE (DEPTNO, JOB)
ORDER BY DEPTNO, JOB;

-- LISTAGG ~ WITHIN GROUP
-- 부서별 사원 이름을 나란히 나열하여 조회 하기 
SELECT DEPTNO
      ,LISTAGG(ENAME, ',') WITHIN GROUP(ORDER BY SAL DESC) AS ENAMES
FROM   EMP
GROUP BY DEPTNO;

-- PIVOT, UNPIVOT 
SELECT DEPTNO, JOB, MAX(SAL)
FROM   EMP
GROUP BY DEPTNO, JOB
ORDER BY DEPTNO, JOB;

SELECT * 
FROM    (SELECT DEPTNO, JOB, SAL FROM EMP)
         PIVOT(MAX(SAL) FOR DEPTNO IN (10, 20, 30))
ORDER BY JOB;   

SELECT * 
FROM    (SELECT JOB, DEPTNO, SAL FROM EMP)
         PIVOT(MAX(SAL) FOR JOB IN ('CLERK' AS CLERK,
                                     'SALSEMAN' AS SALSEMAN,
                                     'PRESIDENT' AS PRESIDENT,
                                     'MANAGER' AS MANAGER,
                                     'ANALYST' AS ANALYST))
ORDER BY DEPTNO;     

SELECT DEPTNO
      ,MAX(DECODE(JOB, 'CLERK', SAL)) AS "CLEAK"
      ,MAX(DECODE(JOB, 'SALSEMAN', SAL)) AS "SALSEMAN"
      ,MAX(DECODE(JOB, 'PRESIDENT', SAL)) AS "PRESIDENT"
      ,MAX(DECODE(JOB, 'MANAGER', SAL)) AS "MANAGER"
      ,MAX(DECODE(JOB, 'ANALYST', SAL)) AS "ANALYST"
FROM   EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;