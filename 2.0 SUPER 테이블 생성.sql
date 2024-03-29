--슈퍼를 운영

-- 도매상으로부터 상품을 받아온다
-- 고객이 상품을 구매한다

 -- 1. 도매상 목록
    CREATE TABLE WHOLESALE(
        WID         CHAR(3)                     NOT NULL    PRIMARY KEY,
        WNAME    VARCHAR2(30)           NOT NULL,
        WTEL        VARCHAR2(11)           NULL,
        WADDR    VARCHAR2(20)           NULL
);

INSERT INTO WHOLESALE VALUES('W01','서울식품', '01011112222', '서울');
INSERT INTO WHOLESALE VALUES('W02','옥션', '01015519562', '서울'); --입고하지않겠다.
INSERT INTO WHOLESALE VALUES('W03','쿠팡', '01044221153', '경기');
INSERT INTO WHOLESALE VALUES('W04','지마켓', '01044001103', '부산');

--상품리스트
CREATE TABLE PRODUCTS(
    PID                 CHAR(3)                  NOT NULL    PRIMARY KEY,
    PNAME           VARCHAR2(30)         NOT NULL,
    PWGT             NUMBER(4)              NULL
);

INSERT INTO PRODUCTS  VALUES ('P01', '콜라', 100);
INSERT INTO PRODUCTS  VALUES ('P02', '콜라', 300);
INSERT INTO PRODUCTS  VALUES ('P03', '젤리', 50);
INSERT INTO PRODUCTS  VALUES ('P04', '젤리', 80);
INSERT INTO PRODUCTS  VALUES ('P05', '새우깡', 200);
INSERT INTO PRODUCTS  VALUES ('P06', '새우깡', 500);
INSERT INTO PRODUCTS  VALUES ('P07', '새우깡', 1000);
INSERT INTO PRODUCTS  VALUES ('P08', '라면', 200);
INSERT INTO PRODUCTS  VALUES ('P09', '라면', 300);
INSERT INTO PRODUCTS  VALUES ('P10', '아이스크림', 100);

--고객 리스트
CREATE TABLE CUSTOMERS(
    CID             CHAR(3)                 NOT NULL        PRIMARY KEY,
    CNAME       VARCHAR2(30)        NOT NULL,
    CAGE          NUMBER(3)            NOT NULL,
    GENDER      CHAR(1)                  NOT NULL      --남자 M 여자 F
);

INSERT INTO CUSTOMERS VALUES ('C01', '홍길동',35,'M');
INSERT INTO CUSTOMERS VALUES ('C02', '홍길순',30,'F');
INSERT INTO CUSTOMERS VALUES ('C03', '전우치',41,'M');
INSERT INTO CUSTOMERS VALUES ('C04', '강철식',55,'M');
INSERT INTO CUSTOMERS VALUES ('C05', '김꽃분',35,'F');
INSERT INTO CUSTOMERS VALUES ('C06', '최순수',39,'M');
INSERT INTO CUSTOMERS VALUES ('C07', '박순이',47,'F');

SELECT * FROM WHOLESALE;
SELECT * FROM PRODUCTS;
SELECT * FROM CUSTOMERS;
-- 엔터티 생성 완료 --
--COMMIT;

-- 도매상에서 상품을 입고한다.
CREATE TABLE STORES(
    IDX         INT         NOT NULL        PRIMARY KEY,
    WID         CHAR(3)     NOT NULL,
    PID         CHAR(3)     NOT NULL,
    COST        NUMBER(8)   NOT NULL,
    QTY         NUMBER(5)       NOT NULL
);

INSERT INTO STORES VALUES(1,'W01','P01',330,10);
INSERT INTO STORES VALUES(2,'W03','P01',350,20);
INSERT INTO STORES VALUES(3,'W04','P03',220,30);
INSERT INTO STORES VALUES(4,'W04','P04',370,20);
INSERT INTO STORES VALUES(5,'W03','P05',500,20);
INSERT INTO STORES VALUES(6,'W03','P07',800,15);
INSERT INTO STORES VALUES(7,'W01','P05',520,22);
INSERT INTO STORES VALUES(8,'W01','P08',550,31);
INSERT INTO STORES VALUES(9,'W04','P08',570,17);
INSERT INTO STORES VALUES(10,'W03','P09',690,30);
INSERT INTO STORES VALUES(11,'W03','P09',640,13);
INSERT INTO STORES VALUES(12,'W01','P10',1240,20);
INSERT INTO STORES VALUES(13,'W03','P10',1290,30);
INSERT INTO STORES VALUES(14,'W04','P10',1310,8);
INSERT INTO STORES VALUES(15,'W04','P03',250,9);

-- 서울식품에서 입고리스트
SELECT * FROM STORES WHERE WID = 'W01';

--서울 식품에서 입고한 데이터를 순번 도매상 상품 총 금액
SELECT IDX, WID, PID, COST, QTY, COST * QTY FROM STORES WHERE WID ='W01';

-- 각 도매상 벼로 집계 > 집계함수 < 내장함수
-- 2: 합계 SUM()
SELECT * FROM STORES;
SELECT SUM(QTY) FROM STORES WHERE WID = 'W01';

--V 평균값
SELECT AVG(QTY) FROM STORES;

--옥션에서 입고한 평균 개수
SELECT AVG(QTY) FROM STORES WHERE WID='W03';

--지마켓에서 한 번 구매한 평균 금액
SELECT IDX, WID, PID, COST, QTY, COST*QTY FROM STORES WHERE WID='W04';

SELECT SUM(COST*QTY), AVG(COST*QTY) FROM STORES WHERE WID='W03';

--데이터 그룹을 형성
SELECT WID, COUNT(*) FROM STORES GROUP BY WID;

-- 각 도매상 별 입고 개수를 보여주는 리스트
SELECT WID, SUM(QTY), COUNT(*), AVG(QTY) FROM STORES GROUP BY WID;

SELECT (COST*QTY) FROM STORES;
SELECT * FROM STORES;

-- 상품별로 입고 총 금액, 입고 총 갯수, 평균 단가
SELECT PID,COUNT(*), SUM(COST*QTY), SUM(QTY), SUM(COST * QTY)/SUM(QTY) FROM STORES GROUP BY PID ORDER BY PID;

-- 남성회원 여성별 평균나이
SELECT GENDER, AVG(CAGE) FROM CUSTOMERS GROUP BY GENDER;

-- 상품별 평균 가격
SELECT PID, AVG(COST) FROM STORES GROUP BY PID;

-- 지역별 ㅎ도매상 현황 리스트 - 지역별로 몇 개인가
SELECT WADDR AS "지역", COUNT(WADDR) AS "지역별 갯수" FROM WHOLESALE GROUP BY WADDR;

SELECT * FROM STORES T1, WHOLESALE T2, PRODUCTS T3
WHERE T1.WID = T2.WID;

--COMMIT;












