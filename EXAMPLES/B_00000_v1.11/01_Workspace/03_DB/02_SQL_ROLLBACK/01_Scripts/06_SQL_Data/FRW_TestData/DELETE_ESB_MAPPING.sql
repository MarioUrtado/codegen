SET ECHO ON
SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR CONTINUE ROLLBACK

DECLARE

BEGIN

	BEGIN
		DELETE FROM  ESB_MAPPING WHERE ID = (SELECT ID FROM ESB_MAPPING WHERE SOURCE_SYSTEM = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'CHL-SALESFORCE') AND SOURCE_CODE = '0' AND DESTINATION_SYSTEM = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW') AND CONTEXT = '100@get' AND DESTINATION_CODE = 'Inactive' AND RCD_STATUS= '1' AND FIELD_ID = (SELECT F.ID FROM ESB_CDM_FIELD F INNER JOIN ESB_CDM_ENTITY E ON F.ENTITY_ID = E.ID WHERE E.NAME = 'Client' AND F.NAME = 'Status'));
	END;
	
	BEGIN
		DELETE FROM  ESB_MAPPING WHERE ID = (SELECT ID FROM ESB_MAPPING WHERE SOURCE_SYSTEM = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW') AND DESTINATION_SYSTEM = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'CHL-SALESFORCE') AND CONTEXT = '100@del'AND DESTINATION_CODE = 'NAT' AND RCD_STATUS= '1' AND FIELD_ID = (SELECT F.ID FROM ESB_CDM_FIELD F INNER JOIN ESB_CDM_ENTITY E ON F.ENTITY_ID = E.ID WHERE E.NAME = 'Client' AND F.NAME = 'Type'));
	END;
	
	BEGIN
		DELETE FROM  ESB_MAPPING WHERE ID = (SELECT ID FROM ESB_MAPPING WHERE SOURCE_SYSTEM = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW') AND SOURCE_CODE = 'National' AND DESTINATION_SYSTEM = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'CHL-SALESFORCE') AND CONTEXT = 'SET' AND DESTINATION_CODE = 'NAT_SET' AND RCD_STATUS= '1' AND FIELD_ID = (SELECT F.ID FROM ESB_CDM_FIELD F INNER JOIN ESB_CDM_ENTITY E ON F.ENTITY_ID = E.ID WHERE E.NAME = 'Client' AND F.NAME = 'Type')); 
	END;
	
	BEGIN
		DELETE FROM  ESB_MAPPING WHERE ID = (SELECT ID FROM ESB_MAPPING WHERE SOURCE_SYSTEM = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW') AND SOURCE_CODE = 'National' AND DESTINATION_SYSTEM = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'CHL-SALESFORCE') AND CONTEXT = '100@get' AND DESTINATION_CODE = 'NAT_GET' AND RCD_STATUS= '1' AND FIELD_ID = (SELECT F.ID FROM ESB_CDM_FIELD F INNER JOIN ESB_CDM_ENTITY E ON F.ENTITY_ID = E.ID WHERE E.NAME = 'Client' AND F.NAME = 'Type'));
	END;	
	
	BEGIN
		DELETE FROM ESB_MAPPING WHERE SOURCE_SYSTEM = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW') AND SOURCE_CODE = 'National'AND DESTINATION_SYSTEM = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'INT-AS400') AND CONTEXT = '100@del' AND DESTINATION_CODE = 'NAT' AND RCD_STATUS= '1' AND FIELD_ID = (SELECT F.ID FROM ESB_CDM_FIELD F INNER JOIN ESB_CDM_ENTITY E ON F.ENTITY_ID = E.ID WHERE E.NAME = 'Client' AND F.NAME = 'Type');
	END;
	
	BEGIN	
		DELETE FROM  ESB_MAPPING WHERE ID = (SELECT ID FROM ESB_MAPPING WHERE SOURCE_SYSTEM = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW') AND SOURCE_CODE = '1' AND DESTINATION_SYSTEM = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'CHL-SALESFORCE') AND RCD_STATUS = '1'AND FIELD_ID = (SELECT F.ID FROM ESB_CDM_FIELD F INNER JOIN ESB_CDM_ENTITY E ON F.ENTITY_ID = E.ID WHERE E.NAME = 'Client' AND F.NAME = 'Type'));
	END;
		
	BEGIN	
		DELETE FROM  ESB_MAPPING WHERE ID = (SELECT ID FROM ESB_MAPPING WHERE SOURCE_SYSTEM = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW') AND SOURCE_CODE = 'unassigned' AND DESTINATION_SYSTEM = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'CHL-SALESFORCE') AND CONTEXT = 'SET' AND RCD_STATUS = '1' AND FIELD_ID = (SELECT F.ID FROM ESB_CDM_FIELD F INNER JOIN ESB_CDM_ENTITY E ON F.ENTITY_ID = E.ID WHERE E.NAME = 'Client' AND F.NAME = 'Type'));
	END;	

	BEGIN
		DELETE FROM  ESB_MAPPING WHERE ID = (SELECT ID FROM ESB_MAPPING WHERE SOURCE_SYSTEM = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW') AND SOURCE_CODE = '0' AND DESTINATION_SYSTEM = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'CR0002') AND CONTEXT = 'CR0002@del' AND DESTINATION_CODE = '00' AND RCD_STATUS= '1' AND FIELD_ID = (SELECT F.ID FROM ESB_CDM_FIELD F INNER JOIN ESB_CDM_ENTITY E ON F.ENTITY_ID = E.ID WHERE E.NAME = 'CanonicalError' AND F.NAME = 'code'));
	END;

	BEGIN
		DELETE FROM  ESB_MAPPING WHERE ID = (SELECT ID FROM ESB_MAPPING WHERE SOURCE_SYSTEM = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW') AND SOURCE_CODE = '-1' AND DESTINATION_SYSTEM = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'CR0002') AND CONTEXT = 'CR0002@del' AND DESTINATION_CODE = '999' AND RCD_STATUS= '1' AND FIELD_ID = (SELECT F.ID FROM ESB_CDM_FIELD F INNER JOIN ESB_CDM_ENTITY E ON F.ENTITY_ID = E.ID WHERE E.NAME = 'CanonicalError' AND F.NAME = 'code'));
	END;

	BEGIN
		DELETE FROM  ESB_MAPPING WHERE ID = (SELECT ID FROM ESB_MAPPING WHERE SOURCE_SYSTEM = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW') AND SOURCE_CODE = '161' AND DESTINATION_SYSTEM = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'CR0002') AND CONTEXT = 'CR0002@del' AND DESTINATION_CODE = '9161' AND RCD_STATUS= '1' AND FIELD_ID = (SELECT F.ID FROM ESB_CDM_FIELD F INNER JOIN ESB_CDM_ENTITY E ON F.ENTITY_ID = E.ID WHERE E.NAME = 'CanonicalError' AND F.NAME = 'code'));
	END;
END;
/

COMMIT;