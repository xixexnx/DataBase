create or replace NONEDITIONABLE PACKAGE PKG_STUDENTS AS

	-- CRUD 
	
	-- 1.입력 INSERT
	PROCEDURE PROC_INS_STUDENTS
	(
		  IN_STU_NAME		IN VARCHAR2
		, IN_STU_TEL		IN VARCHAR2
		, IN_STU_ADDR_GRP	IN VARCHAR2
		, IN_STU_ADDR		IN VARCHAR2
		, IN_STU_DEPT_GRP	IN VARCHAR2
		, IN_STU_DEPT		IN VARCHAR2
		, IN_STU_ADDR2		IN VARCHAR2
	);


	-- 2. 조회 SELECT
	PROCEDURE PROC_SEL_STUDENTS
	(
		  IN_STU_ID			IN	 VARCHAR2
		, IN_STU_NAME		IN 	 VARCHAR2
		, O_CURSOR			OUT	 SYS_REFCURSOR
	);
	
	-- 3. 수정 UPDATE
	PROCEDURE PROC_UP_STUDENTS
	(
		  IN_STU_ID			IN VARCHAR2
		, IN_STU_NAME		IN VARCHAR2
		, IN_STU_TEL		IN VARCHAR2
		, IN_STU_ADDR_GRP	IN VARCHAR2
		, IN_STU_ADDR		IN VARCHAR2
		, IN_STU_DEPT_GRP	IN VARCHAR2
		, IN_STU_DEPT		IN VARCHAR2
		, IN_STU_ADDR2		IN VARCHAR2
		, IN_STU_PASS		IN VARCHAR2
	);
	
	--4. 삭제 DELETE
	PROCEDURE PROC_DEL_STUDENTS
	(
		  IN_STU_ID			IN VARCHAR2
		  ,O_ERRCODE		OUT	VARCHAR2
		  ,O_ERRMSG			OUT	VARCHAR2
	);
END PKG_STUDENTS;
