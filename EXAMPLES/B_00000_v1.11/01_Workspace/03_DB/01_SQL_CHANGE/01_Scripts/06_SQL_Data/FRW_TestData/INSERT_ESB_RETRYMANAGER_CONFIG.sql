SET ECHO ON
SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR CONTINUE ROLLBACK

DECLARE

BEGIN

	BEGIN
		INSERT INTO ESB_RETRYMANAGER_CONFIG ( ID, CAPABILITY_ID, RETRY_MAX, INTERVAL_TIME, RETRY_ENABLED )
	    VALUES (ESB_RETRYMANAGER_CONFIG_SEQ.NEXTVAL,
	      (SELECT ESB_CAPABILITY.ID FROM ESB_SERVICE INNER JOIN ESB_CAPABILITY ON ESB_CAPABILITY.SERVICE_ID = ESB_SERVICE.ID WHERE ESB_SERVICE.NAME = 'Consumer' AND ESB_SERVICE.CODE = '100' AND ESB_CAPABILITY.CODE = '101' AND ESB_CAPABILITY.NAME = 'get'),
	      5,
	      300,
	      1
	      );
	END;
	
END;
/

COMMIT;
