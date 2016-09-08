SET ECHO ON
SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR CONTINUE ROLLBACK

DECLARE

BEGIN

	BEGIN
		DELETE FROM  ESB_ENDPOINT WHERE OPERATION_ID = (SELECT O.ID FROM ESB_SYSTEM_API_OPERATION O INNER JOIN ESB_SYSTEM_API A ON O.SYSTEM_API_ID = A.ID WHERE O.NAME = 'ClientDelete' AND A.CODE = 'CHL-SALESFORCE-CRM') AND TRANSPORT_ID = ( SELECT ID FROM ESB_ENDPOINT_TRANSPORT WHERE NAME = 'HTTPSOAP12') AND RCD_STATUS = '1';
	END;
	
	BEGIN
		DELETE FROM  ESB_ENDPOINT WHERE OPERATION_ID = (SELECT O.ID FROM ESB_SYSTEM_API_OPERATION O INNER JOIN ESB_SYSTEM_API A ON O.SYSTEM_API_ID = A.ID WHERE O.NAME = 'ClientObtain' AND A.CODE = 'CHL-SALESFORCE-CRM') AND TRANSPORT_ID = ( SELECT ID FROM ESB_ENDPOINT_TRANSPORT WHERE NAME = 'HTTPSOAP12') AND RCD_STATUS = '1';
	END;
	
	BEGIN
		DELETE FROM  ESB_ENDPOINT WHERE OPERATION_ID = (SELECT O.ID FROM ESB_SYSTEM_API_OPERATION O INNER JOIN ESB_SYSTEM_API A ON O.SYSTEM_API_ID = A.ID WHERE O.NAME = 'UPD-CLI-DATA' AND A.CODE = 'CHL-SALESFORCE-CRM') AND TRANSPORT_ID = ( SELECT ID FROM ESB_ENDPOINT_TRANSPORT WHERE NAME = 'JMS') AND RCD_STATUS = '1'; 
	END;
	
	BEGIN
		DELETE FROM  ESB_ENDPOINT WHERE OPERATION_ID = (SELECT O.ID FROM ESB_SYSTEM_API_OPERATION O INNER JOIN ESB_SYSTEM_API A ON O.SYSTEM_API_ID = A.ID WHERE O.NAME = 'ClientDelete' AND A.CODE = 'INT-AS400-CLI') AND TRANSPORT_ID = ( SELECT ID FROM ESB_ENDPOINT_TRANSPORT WHERE NAME = 'HTTPSOAP11') AND RCD_STATUS = '1';
	END;
	
END;
/

COMMIT;