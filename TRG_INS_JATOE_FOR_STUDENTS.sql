create or replace NONEDITIONABLE TRIGGER TRG_INS_JATOE_FOR_STUDENTS 
AFTER DELETE ON STUDENTS_TBL 
REFERENCING OLD AS OLD NEW AS NEW 
FOR EACH ROW
BEGIN
  INSERT INTO JATOE_TBL VALUES(:OLD.STU_ID, :OLD.STU_NAME);
END;