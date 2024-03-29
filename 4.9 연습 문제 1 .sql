SELECT * FROM GRPCOMMONS_TBL;
SELECT * FROM COMMONS_TBL;

SELECT * FROM STUDENTS_TBL;
SELECT * FROM SUBJECTS_TBL;
SELECT * FROM PROFESSORS_TBL;

SELECT * FROM STUDENTS_TIME_TBL;
SELECT * FROM SCORES_TBL;


-- 수강신청 안 한 학생  - 수강신청을 가장 많이 하지않은 학과 
SELECT * 
FROM STUDENTS_TBL T1, STUDENTS_TIME_TBL T2
WHERE T1.STU_ID = T2.STU_ID(+)
AND T2.STU_ID IS NULL;
	/*
	STU042	홍길동42	010-5555-4414	GRP001	COM0036	COM0002	GRP002	COM0021					
	STU062	홍길동62	010-5555-4414	GRP001	COM0046	COM0005	GRP002	COM0025					
	STU045	홍길동45	010-5555-4414	GRP001	COM0031	COM0002	GRP002	COM0016					
	STU072	홍길동72	010-5555-4414	GRP001	COM0044	COM0015	GRP002	COM0025					
	STU011	홍길동11	010-5555-4414	GRP001	COM0033	COM0002	GRP002	COM0024					
	STU063	홍길동63	010-5555-4414	GRP001	COM0046	COM0005	GRP002	COM0025					
	STU071	홍길동71	010-5555-4414	GRP001	COM0044	COM0015	GRP002	COM0025					
	*/

--단과 대학이름 , 학과명 ,수강신청 하지않은 학생 수, RANK




-- 학생리스트( 학생아이디, 학생이름, 단과대학, 소속학과, 주소  )
SELECT
	STU_ID,
	STU_NAME,
	STU_DEPT_GRP,
	STU_DEPT
FROM
	STUDENTS_TBL;

SELECT
	*
FROM
	COMMONS_TBL
WHERE
	GRP_ID = 'GRP002';

SELECT
	T1.STU_ID,
	T1.STU_NAME,
	T2.COM_ID,
	T2.COM_VAL,
	T3.COM_ID,
	T3.COM_VAL,
	T3.GRP_ID -- GRP_ID 가 있어야함
FROM
	STUDENTS_TBL T1,
	COMMONS_TBL  T2,
	COMMONS_TBL  T3
WHERE
	    T1.STU_DEPT_GRP = T2.GRP_ID
	AND T1.STU_DEPT = T2.COM_ID
	AND T2.PARENT_ID = T3.COM_ID
	AND T2.GRP_ID = T3.GRP_ID;
--  ^T3.COM_ID에는 GRP_ID에 관련해서 같이 걸어줘야함 그렇지 않으면 COM00N숫자가 반복되므로 계속출력됨


-- 교수테이블 -- 교수아이디, 교수명, 소속학과
SELECT PRO_ID, PRO_NAME, PRO_DEPT_GRP, PRO_DEPT
FROM PROFESSORS_TBL;

SELECT * FROM COMMONS_TBL
WHERE GRP_ID ='GRP002';

SELECT A.GRP_ID, A.COM_ID, A.COM_VAL, A.PARENT_ID, B.PRO_ID, B.PRO_NAME  FROM 
(
	SELECT * FROM COMMONS_TBL
	WHERE GRP_ID='GRP002'
)A, PROFESSORS_TBL B
WHERE A.GRP_ID = B.PRO_DEPT_GRP AND A.COM_ID = B.PRO_DEPT
;


SELECT A.GRP_ID, A.COM_ID, A.COM_VAL, A.PARENT_ID, B.PRO_ID, B.PRO_NAME, C.COM_ID, C.COM_VAL 
FROM COMMONS_TBL A, PROFESSORS_TBL B, COMMONS_TBL C
WHERE A.GRP_ID = B.PRO_DEPT_GRP AND A.COM_ID = B.PRO_DEPT
AND A.GRP_ID = C.GRP_ID AND A.PARENT_ID = C.COM_ID
AND A.GRP_ID = 'GRP002'
;



