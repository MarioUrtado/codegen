SET ECHO ON
SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR CONTINUE ROLLBACK

DECLARE

BEGIN

	BEGIN
		DELETE FROM ESB_ERROR_DERIVATION_CONF WHERE ID = (SELECT ID FROM ESB_ERROR_DERIVATION_CONF WHERE COUNT_PRIORITY_1 = '2' AND COUNT_PRIORITY_2 = '2' AND COUNT_PRIORITY_3 = '2' AND RUN_STATE = '1');
	END;

END;

/

COMMIT;

