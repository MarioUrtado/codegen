SET ECHO ON
SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR CONTINUE ROLLBACK

DECLARE

BEGIN

	BEGIN
		INSERT INTO ESB_CONSUMER (ID,SYSCODE,COUNTRY_ID,ENT_CODE,RCD_STATUS) VALUES (ESB_CONSUMER_SEQ.NEXTVAL,( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'CHL-SALESFORCE'),( SELECT ID FROM ESB_COUNTRY WHERE CODE = 'CHL'),( SELECT ID FROM ESB_ENTERPRISE WHERE CODE = 'ENTEL'),'0');
	END;
	
	BEGIN
		INSERT INTO ESB_CONSUMER (ID,SYSCODE,COUNTRY_ID,ENT_CODE,RCD_STATUS) VALUES (ESB_CONSUMER_SEQ.NEXTVAL,( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'CR0002'),( SELECT ID FROM ESB_COUNTRY WHERE CODE = 'CHL'),( SELECT ID FROM ESB_ENTERPRISE WHERE CODE = 'ENTEL'),'1');
	END;
END;
/

COMMIT;