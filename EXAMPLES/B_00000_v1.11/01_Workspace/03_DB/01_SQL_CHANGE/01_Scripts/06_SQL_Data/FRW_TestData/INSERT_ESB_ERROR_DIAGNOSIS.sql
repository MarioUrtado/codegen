SET ECHO ON
SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR CONTINUE ROLLBACK

DECLARE

BEGIN

	BEGIN
		INSERT INTO ESB_ERROR_DIAGNOSIS (ID,CAPABILITY_ID,F_CODE,T_CODE,TYPE,WEIGHT,THERAPY_ID,RCD_STATUS) VALUES (ESB_ERROR_DIAGNOSIS_SEQ.NEXTVAL,( SELECT ID FROM ESB_CAPABILITY WHERE CODE = '101'),'1','50','2','3',( SELECT ID FROM ESB_ERROR_THERAPY WHERE NAME = 'SALESFORCE'),'1');
	END;
	
	BEGIN
		INSERT INTO ESB_ERROR_DIAGNOSIS (ID,CAPABILITY_ID,F_CODE,T_CODE,TYPE,WEIGHT,THERAPY_ID,RCD_STATUS) VALUES (ESB_ERROR_DIAGNOSIS_SEQ.NEXTVAL,( SELECT ID FROM ESB_CAPABILITY WHERE CODE = '101'),'*','*','*','1',( SELECT ID FROM ESB_ERROR_THERAPY WHERE NAME = 'SALESFORCE'),'1');
	END;
	
	BEGIN
		INSERT INTO ESB_ERROR_DIAGNOSIS (ID,CAPABILITY_ID,F_CODE,T_CODE,TYPE,WEIGHT,THERAPY_ID,RCD_STATUS) VALUES (ESB_ERROR_DIAGNOSIS_SEQ.NEXTVAL,( SELECT ID FROM ESB_CAPABILITY WHERE CODE = '103'),'*','*','*','1',( SELECT ID FROM ESB_ERROR_THERAPY WHERE NAME = 'SALESFORCE'),'1');
	END;
	
	BEGIN
		INSERT INTO ESB_ERROR_DIAGNOSIS (ID,CAPABILITY_ID,F_CODE,T_CODE,TYPE,WEIGHT,THERAPY_ID,RCD_STATUS) VALUES (ESB_ERROR_DIAGNOSIS_SEQ.NEXTVAL,( SELECT ID FROM ESB_CAPABILITY WHERE CODE = '104'),'*','*','*','1',( SELECT ID FROM ESB_ERROR_THERAPY WHERE NAME = 'SALESFORCE'),'1');
	END;

	BEGIN
		INSERT INTO ESB_ERROR_DIAGNOSIS (ID,CAPABILITY_ID,THERAPY_ID,F_CODE,T_CODE,TYPE,WEIGHT,RCD_STATUS) VALUES ( ESB_ERROR_DIAGNOSIS_SEQ.NEXTVAL,(SELECT ID FROM ESB_CAPABILITY WHERE CODE = '101'),( SELECT ID FROM ESB_ERROR_THERAPY WHERE NAME = 'TERAPIA_1'),'*','*','*','1','1');
  	END;
	
END;
/

COMMIT;
