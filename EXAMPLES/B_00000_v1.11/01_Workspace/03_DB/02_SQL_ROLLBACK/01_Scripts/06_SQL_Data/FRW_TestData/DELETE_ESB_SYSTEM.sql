SET ECHO ON
SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR CONTINUE ROLLBACK

DECLARE

BEGIN

	BEGIN
		DELETE FROM  ESB_SYSTEM WHERE ID = (SELECT ID FROM ESB_SYSTEM WHERE CODE = 'CHL-SALESFORCE' AND NAME = 'SALESFORCE' AND DESCRIPTION = '....' AND RCD_STATUS = '1');
	END;
	
	BEGIN
		DELETE FROM  ESB_SYSTEM WHERE ID = (SELECT ID FROM ESB_SYSTEM WHERE CODE = 'INT-AS400' AND NAME = 'AS400' AND DESCRIPTION = '....' AND RCD_STATUS = '1');
	END;
	BEGIN
		DELETE FROM ESB_SYSTEM WHERE CODE = 'CR0002' AND NAME = 'CREDITS TEST' AND RCD_STATUS = '1';
	END;
END;
/

COMMIT;