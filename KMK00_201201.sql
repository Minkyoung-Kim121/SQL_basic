SELECT * FROM EMPTEST;
DESC EMPTEST;
DROP TABLE EMPTEST; 
CREATE TABLE EMPTEST(
     EMPNO   VARCHAR2(20)    PRIMARY KEY
    ,ENAME   VARCHAR2(20)
    ,JOB     VARCHAR2(20)
    ,DEPTNO  NUMBER(2)
    ,DELETEYN   VARCHAR2(1)
    ,INSERTDATE DATE
    ,UPDATEDATE DATE
    );
COMMIT;
