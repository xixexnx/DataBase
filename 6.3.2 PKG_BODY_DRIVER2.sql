CREATE OR REPLACE
PACKAGE BODY PKG_DRIVER2 AS

  PROCEDURE PROC_INS_DRIVER(
		IN_DR_NAME		IN		VARCHAR2
		,IN_DR_TEL		IN		VARCHAR2
		,IN_DR_GENDER	IN		VARCHAR2
		,O_ERRCODE		OUT		VARCHAR2
		,O_ERRMSG		OUT		VARCHAR2
  ) AS
  
		V_NEW_ID		CHAR(5);
  
  BEGIN
  
		SELECT 'DR' || TO_CHAR(NVL(SUBSTR(MAX(DR_ID), 3, 3), 0) +1, 'FM000')
		INTO V_NEW_ID
		FROM DRIVERS_TBL
		;
    
		INSERT INTO DRIVERS_TBL (DR_ID, DR_NAME, DR_TEL, DR_GENDER)
		VALUES (V_NEW_ID, IN_DR_NAME, IN_DR_TEL, IN_DR_GENDER)
		;
		
		EXCEPTION
		WHEN OTHERS THEN
		O_ERRCODE := SQLCODE;
		O_ERRMSG := SQLERRM;
	
  END PROC_INS_DRIVER;

  PROCEDURE PROC_SEL_DRIVER(
		O_CURSOR		OUT 	SYS_REFCURSOR
		,O_ERRCODE		OUT		VARCHAR2
		,O_ERRMSG		OUT		VARCHAR2
  ) AS
  BEGIN
	
		OPEN O_CURSOR FOR
		SELECT DR_ID, DR_NAME, DR_TEL, DR_GENDER
		FROM DRIVERS_TBL
		ORDER BY DR_ID
		;

		EXCEPTION
		WHEN OTHERS THEN
		O_ERRCODE := SQLCODE;
		O_ERRMSG := SQLERRM;
		
  END PROC_SEL_DRIVER;

  PROCEDURE PROC_UP_DRIVER(
		IN_DR_ID		IN		VARCHAR2
		,IN_DR_NAME		IN		VARCHAR2
		,IN_DR_TEL		IN		VARCHAR2
		,IN_DR_GENDER	IN		VARCHAR2
		,O_ERRCODE		OUT		VARCHAR2
		,O_ERRMSG		OUT		VARCHAR2
  ) AS
	  
		CNT_DR_ID			NUMBER(1);
  
		DR_ID_EXCEPTION		EXCEPTION;
		
  BEGIN
		-- DR_ID는 변경될 수 없음. DR_ID로 식별
		SELECT COUNT(DR_ID)
		INTO CNT_DR_ID
		FROM DRIVERS_TBL
		WHERE DR_ID = IN_DR_ID
		;
		
		IF (CNT_DR_ID = 0) THEN
			RAISE DR_ID_EXCEPTION;
		
		ELSE
			UPDATE DRIVERS_TBL
			SET DR_NAME = IN_DR_NAME, DR_TEL = IN_DR_TEL, DR_GENDER = IN_DR_GENDER
			WHERE DR_ID = IN_DR_ID
			;
			
		END IF;
		
		EXCEPTION
		WHEN DR_ID_EXCEPTION THEN
		O_ERRCODE := 'ERROR-001';
		O_ERRMSG := '회원아이디가 존재하지 않습니다.';
		
		WHEN OTHERS THEN
		O_ERRCODE := SQLCODE;
		O_ERRMSG := SQLERRM;
		
  END PROC_UP_DRIVER;

  PROCEDURE PROC_DEL_DRIVER(
		IN_DR_ID		IN		VARCHAR2
		,O_ERRCODE		OUT		VARCHAR2
		,O_ERRMSG		OUT		VARCHAR2
  ) AS
  
		CNT_DR_ID			NUMBER(1);
	
		DR_ID_EXCEPTION		EXCEPTION;
		
  BEGIN
		
		SELECT COUNT(DR_ID)
		INTO CNT_DR_ID
		FROM DRIVERS_TBL
		WHERE DR_ID = IN_DR_ID
		;
		
		IF CNT_DR_ID = 0 THEN
			RAISE DR_ID_EXCEPTION;
			
		ELSE
			DELETE 
			FROM DRIVERS_TBL
			WHERE DR_ID = IN_DR_ID
			;
			
		END IF;
		
		EXCEPTION
		WHEN DR_ID_EXCEPTION THEN
		O_ERRCODE := 'ERROR-001';
		O_ERRMSG := '회원아이디가 존재하지 않습니다.';
		
		WHEN OTHERS THEN
		O_ERRCODE := SQLCODE;
		O_ERRMSG := SQLERRM;
		    
  END PROC_DEL_DRIVER;

  PROCEDURE PROC_INS_MEMBER(
		IN_R_TEL		IN		VARCHAR2
		,O_ERRCODE		OUT		VARCHAR2
		,O_ERRMSG		OUT		VARCHAR2
  ) AS
  
		CNT_R_TEL			NUMBER(1);
		
		R_TEL_EXCEPTION		EXCEPTION;
		
  BEGIN
    
		SELECT COUNT(R_TEL)
		INTO CNT_R_TEL
		FROM DR_MEMBER_TBL
		WHERE R_TEL = IN_R_TEL
		;
		
		IF CNT_R_TEL = 1 THEN
			RAISE R_TEL_EXCEPTION;
		
		ELSE
			INSERT INTO DR_MEMBER_TBL(R_TEL, MEM_POINT)
			VALUES(IN_R_TEL, 0)
			;
			
		END IF;
	
		EXCEPTION
		WHEN R_TEL_EXCEPTION THEN 
		O_ERRCODE := 'ERROR-001';
		O_ERRMSG := '회원이 이미 존재합니다.';
		
		WHEN OTHERS THEN
		O_ERRCODE := SQLCODE;
		O_ERRMSG := SQLERRM;
		
  END PROC_INS_MEMBER;

  PROCEDURE PROC_UP_MEMBER(
		IN_R_TEL		IN		VARCHAR2
		,IN_NEW_TEL		IN		VARCHAR2
		,O_ERRCODE		OUT		VARCHAR2
		,O_ERRMSG		OUT		VARCHAR2
  ) AS
  
		CNT_R_TEL			NUMBER(1);
		CNT_NEW_TEL			NUMBER(1);
		
		R_TEL_EXCEPTION		EXCEPTION;
		NEW_TEL_EXCEPTION	EXCEPTION;
		SAME_TEL_EXCEPTION	EXCEPTION;
		
  BEGIN
  
		SELECT COUNT(R_TEL)
		INTO CNT_R_TEL
		FROM DR_MEMBER_TBL
		WHERE R_TEL = IN_R_TEL
		;
		
		SELECT COUNT(R_TEL)
		INTO CNT_NEW_TEL
		FROM DR_MEMBER_TBL
		WHERE R_TEL = IN_NEW_TEL
		;
		
		IF CNT_R_TEL = 0 THEN 
			RAISE R_TEL_EXCEPTION;
			
		ELSIF IN_R_TEL = IN_NEW_TEL THEN
			RAISE SAME_TEL_EXCEPTION;
			
		ELSIF CNT_NEW_TEL = 1 THEN
			RAISE NEW_TEL_EXCEPTION;
			
		ELSE
			UPDATE DR_MEMBER_TBL
			SET R_TEL = IN_NEW_TEL
			WHERE R_TEL = IN_R_TEL
			;
		END IF;
		
		EXCEPTION
		WHEN R_TEL_EXCEPTION THEN
		O_ERRCODE := 'ERROR-001';
		O_ERRMSG := '회원이 존재하지 않습니다.';
		
		WHEN NEW_TEL_EXCEPTION THEN 
		O_ERRCODE := 'ERROR-002';
		O_ERRMSG := '이미 존재하는 번호입니다.';
		
		WHEN SAME_TEL_EXCEPTION THEN
		O_ERRCODE := 'ERROR-003';
		O_ERRMSG := '현재 번호와 바꾸려는 번호가 동일합니다.';
		
		WHEN OTHERS THEN 
		O_ERRCODE := SQLCODE;
		O_ERRMSG := SQLERRM;
		
		END PROC_UP_MEMBER;

  PROCEDURE PROC_SEL_MEMBER(
		O_CURSOR		OUT		SYS_REFCURSOR
		,O_ERRCODE		OUT		VARCHAR2
		,O_ERRMSG		OUT		VARCHAR2
  ) AS
  BEGIN
   
		OPEN O_CURSOR FOR
		SELECT R_TEL, MEM_POINT
		FROM DR_MEMBER_TBL
		ORDER BY R_TEL
		;
		
		EXCEPTION
		WHEN OTHERS THEN
		O_ERRCODE := SQLCODE;
		O_ERRMSG := SQLERRM;
		
  END PROC_SEL_MEMBER;

  PROCEDURE PROC_DEL_MEMBER(
		IN_R_TEL		IN		VARCHAR2
		,O_ERRCODE		OUT		VARCHAR2
		,O_ERRMSG		OUT		VARCHAR2
  ) AS
  
		CNT_R_TEL			NUMBER(1);
		R_TEL_EXCEPTION		EXCEPTION;
  BEGIN
		
		SELECT COUNT(R_TEL)
		INTO CNT_R_TEL
		FROM DR_MEMBER_TBL
		WHERE R_TEL = IN_R_TEL
		;
		
		IF CNT_R_TEL = 0 THEN
			RAISE R_TEL_EXCEPTION;
		
		ELSE
			DELETE FROM DR_MEMBER_TBL 
			WHERE R_TEL = IN_R_TEL
			;
		END IF;
		
		EXCEPTION
		WHEN R_TEL_EXCEPTION THEN
		O_ERRCODE := 'ERROR-001';
		O_ERRMSG := '회원이 존재하지 않습니다.';
		
		WHEN OTHERS THEN
		O_ERRCODE := SQLCODE;
		O_ERRMSG := SQLERRM;
			
  END PROC_DEL_MEMBER;

END PKG_DRIVER2;