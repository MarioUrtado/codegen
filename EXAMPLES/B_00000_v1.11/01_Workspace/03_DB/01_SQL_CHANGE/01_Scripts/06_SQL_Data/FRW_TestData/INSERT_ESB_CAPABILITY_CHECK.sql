SET ECHO ON
SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR CONTINUE ROLLBACK

DECLARE

BEGIN

	BEGIN
		INSERT INTO ESB_CAPABILITY_CHECK (ID,CAPABILITY_ID,CHECK_INDICATOR,RCD_STATUS) VALUES (ESB_CAPABILITY_CHECK_SEQ.NEXTVAL,( SELECT ID FROM ESB_CAPABILITY WHERE CODE = '103'),'1','1');
	END;
	
	BEGIN
		INSERT INTO ESB_CAPABILITY_CHECK (ID,CAPABILITY_ID,CHECK_INDICATOR,RCD_STATUS) VALUES (ESB_CAPABILITY_CHECK_SEQ.NEXTVAL,( SELECT ID FROM ESB_CAPABILITY WHERE CODE = '104'),'0','1');
	END;
	
	BEGIN
		INSERT INTO ESB_CAPABILITY_CHECK (ID,CAPABILITY_ID,CHECK_INDICATOR,RCD_STATUS) VALUES (ESB_CAPABILITY_CHECK_SEQ.NEXTVAL,( SELECT ID FROM ESB_CAPABILITY WHERE CODE = '101'),'0','1');
	END;
	
	BEGIN
		INSERT INTO ESB_CAPABILITY_CHECK (ID,CAPABILITY_ID,CHECK_INDICATOR,RCD_STATUS) VALUES (ESB_CAPABILITY_CHECK_SEQ.NEXTVAL,( SELECT ID FROM ESB_CAPABILITY WHERE CODE = '102'),'0','1');
	END;
	
END;
/

COMMIT;