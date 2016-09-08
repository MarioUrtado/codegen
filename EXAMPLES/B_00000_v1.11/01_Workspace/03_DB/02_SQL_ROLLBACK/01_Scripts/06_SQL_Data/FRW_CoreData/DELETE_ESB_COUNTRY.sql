SET ECHO ON
SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR CONTINUE ROLLBACK

DECLARE

BEGIN

	BEGIN
		DELETE FROM ESB_COUNTRY WHERE ID = (SELECT ID FROM ESB_COUNTRY WHERE CODE = '0' AND NAME = 'UNK' AND DESCRIPTION = 'UNKNOWN' AND RCD_STATUS = '1');
	END;
	
	BEGIN
		DELETE FROM ESB_COUNTRY WHERE ID = (SELECT ID FROM ESB_COUNTRY WHERE CODE = 'CHL' AND NAME = 'CHL' AND DESCRIPTION = 'CHILE' AND RCD_STATUS = '1');
	END;
	
	BEGIN
		DELETE FROM ESB_COUNTRY WHERE ID = (SELECT ID FROM ESB_COUNTRY WHERE CODE = 'PER' AND NAME = 'PER' AND DESCRIPTION = 'PERU' AND RCD_STATUS = '1');
	END;
	
	
END;
/

COMMIT;
