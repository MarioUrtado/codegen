SET ECHO ON
SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR CONTINUE ROLLBACK

DECLARE

BEGIN

	BEGIN
		Insert into ESB_ERROR_DERIVATION_CONF (ID,COUNT_PRIORITY_1,COUNT_PRIORITY_2,COUNT_PRIORITY_3,RUN_STATE) values (ESB_ERROR_DERIVATION_CONF_SEQ.NEXTVAL,'2','2','2','1');
	END;

END;

/

COMMIT;

