-- 모든 지역 리스트 
SELECT
	SYS_CONNECT_BY_PATH (COM_VAL,'     ')
FROM 
(
	SELECT 
		* 
	FROM 
		COMMONS_TBL 
	WHERE 
		GRP_ID = 'GRP001'
)
START WITH 
	PARENT_ID = 'COM0000'
CONNECT BY NOCYCLE PRIOR 
	COM_ID = PARENT_ID
;

-- 모든 지역 리스트 + 학생 수
SELECT 
	A2.COM_ID, A2.LOCALS, A1.CNT1+A2.CNT2
FROM
(
SELECT
	COM_ID, LOCALS, COUNT(STU_ID) AS CNT1
FROM
		(
		SELECT
			COM_ID,SYS_CONNECT_BY_PATH (COM_VAL,'     ') AS LOCALS
		FROM 
				(
					SELECT 
						* 
					FROM 
						COMMONS_TBL 
					WHERE 
						GRP_ID = 'GRP001'
				)
		START WITH 
			PARENT_ID = 'COM0000'
		CONNECT BY NOCYCLE PRIOR 
			COM_ID = PARENT_ID
		)A, STUDENTS_TBL B
	WHERE 
				A.COM_ID = B.STU_ADDR(+)
	GROUP BY
			COM_ID, LOCALS
)A1,
(
SELECT
	COM_ID, LOCALS ,COUNT(STU_ID) AS CNT2
FROM
		(
		SELECT
			COM_ID,SYS_CONNECT_BY_PATH (COM_VAL,'  ') AS LOCALS
		FROM  
				(
					SELECT 
						* 
					FROM 
						COMMONS_TBL 
					WHERE 
						GRP_ID = 'GRP001'
				)
		START WITH 
			PARENT_ID = 'COM0000'
		CONNECT BY NOCYCLE PRIOR 
			COM_ID = PARENT_ID
		)A, STUDENTS_TBL B
	WHERE 
				A.COM_ID = B.STU_ADDR2(+)
	GROUP BY 
			COM_ID,LOCALS
)A2
WHERE 
A1.COM_ID = A2.COM_ID
ORDER BY A2.LOCALS
;



-- 모든 지역 리스트 + 학생 수
SELECT 
	STUCNT.COM_ID AS 지역아이디,
	STUCNT.LOCALS AS 지역명,
	STUCNT.CNT1 AS 학생수, 
	PROCNT.CNT1 AS 교수수
FROM
(
SELECT
	COM_ID, LOCALS, 
	COUNT(STU_ID) AS CNT1
FROM
		(
		SELECT
			COM_ID,SYS_CONNECT_BY_PATH (COM_VAL,'     ') AS LOCALS
		FROM 
				(
					SELECT 
						* 
					FROM 
						COMMONS_TBL 
					WHERE 
						GRP_ID = 'GRP001'
				)
		START WITH 
			PARENT_ID = 'COM0000'
		CONNECT BY NOCYCLE PRIOR 
			COM_ID = PARENT_ID
		)A, STUDENTS_TBL B
	WHERE 
				A.COM_ID = B.STU_ADDR(+)
	GROUP BY
			COM_ID, LOCALS
)STUCNT,
(
SELECT
	A.COM_ID, LOCALS, 
	COUNT(PRO_ID) AS CNT1
FROM
		(
		SELECT
			COM_ID,SYS_CONNECT_BY_PATH (COM_VAL,'     ') AS LOCALS
		FROM 
				(
					SELECT 
						* 
					FROM 
						COMMONS_TBL 
					WHERE 
						GRP_ID = 'GRP001'
				)
		START WITH 
			PARENT_ID = 'COM0000'
		CONNECT BY NOCYCLE PRIOR 
			COM_ID = PARENT_ID
		)A, PROFESSORS_TBL B
	WHERE 
				A.COM_ID = B.PRO_ADDR(+)
	GROUP BY
			COM_ID, LOCALS
)PROCNT
WHERE
	STUCNT.LOCALS = PROCNT.LOCALS
ORDER BY STUCNT.LOCALS
;