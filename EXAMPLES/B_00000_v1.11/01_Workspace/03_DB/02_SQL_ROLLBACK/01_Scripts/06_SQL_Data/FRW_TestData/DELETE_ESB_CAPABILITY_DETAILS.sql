SET ECHO ON
SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR CONTINUE ROLLBACK

DECLARE

BEGIN

	BEGIN
		DELETE FROM ESB_CAPABILITY_DETAILS
		WHERE CAPABILITY_ID = (SELECT ESB_CAPABILITY.ID FROM ESB_SERVICE INNER JOIN ESB_CAPABILITY ON ESB_CAPABILITY.SERVICE_ID = ESB_SERVICE.ID WHERE ESB_SERVICE.NAME = 'Consumer' AND ESB_SERVICE.CODE = '100' AND ESB_CAPABILITY.CODE = '101' AND ESB_CAPABILITY.NAME = 'get') AND
			DETAIL_TYPE_ID = (SELECT ID FROM ESB_CAPABILITY_DETAILS_TYPE WHERE NAME = 'Action' );
	END;
	
END;
/

COMMIT;

