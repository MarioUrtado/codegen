SET ECHO ON
SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR CONTINUE ROLLBACK

DECLARE

BEGIN

	BEGIN
		DELETE FROM  ESB_ERROR_THERAPY WHERE ID = (SELECT ID FROM ESB_ERROR_THERAPY WHERE NAME = 'SALESFORCE' AND RCD_STATUS = '1');
	END;

	BEGIN
		DELETE FROM ESB_ERROR_THERAPY WHERE NAME = 'TERAPIA_1';
	END;
	
END;
/

COMMIT;