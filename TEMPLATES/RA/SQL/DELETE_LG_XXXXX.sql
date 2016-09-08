SET ECHO ON
SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR CONTINUE ROLLBACK

DECLARE

BEGIN

------------------------------------------------------------------------------------
-- The following commments can be deleted for each Release
------------------------------------------------------------------------------------
-- XXXXX_CODE @@ Legacy System CODE
-- XXXXX_NAME @@ Legacy System NAME
-- XXXXX_DESC @@ Legacy System DESCRIPTION

-- One per-API --->

	-- XXXXX_API_CODE @@ Legacy System API CODE
	-- XXXXX_API_NAME @@ Legacy System API NAME
	-- XXXXX_API_DESC @@ Legacy System API DESCRIPTION
	
	-- One per-Operation --->
		-- XXXXX_API_OP_NAME @@ Legacy System API Operation NAME
		-- XXXXX_API_OP_VER @@ Legacy System API Operation VERSION
		-- XXXXX_API_OP_DESC @@ Legacy System API Operation DESCRIPTION
		-- XXXXX_API_OP_END_CONF @@ Legacy System API Operation Configuration Name
		-- XXXXX_API_OP_END_TRAN @@ Legacy System API Operation Transport Name
------------------------------------------------------------------------------------
	
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- ESB_SYSTEM_API @ XXXXX_CODE
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
		---------------------------------------------
		-- XXXXX_API_OP_NAME
		---------------------------------------------
		
		DELETE FROM  ESB_ENDPOINT WHERE 
									OPERATION_ID = (SELECT ID FROM ESB_SYSTEM_API_OPERATION WHERE NAME = 'XXXXX_API_OP_NAME' AND SYSTEM_API_ID = 
														(SELECT ID FROM ESB_SYSTEM_API WHERE CODE = 'XXXXX_API_CODE'))
									AND TRANSPORT_ID 	= (SELECT ID FROM ESB_ENDPOINT_TRANSPORT WHERE NAME = 'XXXXX_API_OP_END_TRAN')
									AND CONFIG_ID    	= (SELECT ID FROM ESB_CONFIG WHERE NAME = 'XXXXX_API_OP_END_CONF');

			-------------------
			-- ESB_CONFIG_LIST
			-------------------
			DELETE FROM ESB_CONFIG_LIST WHERE CONFIG_ID  = ( SELECT ID FROM ESB_CONFIG WHERE NAME = 'XXXXX_API_OP_END_CONF');
			
			DELETE FROM  ESB_CONFIG WHERE NAME        =  'XXXXX_API_OP_END_CONF'
									AND   RCD_STATUS  = '1';
			-------------------

		-- ESB_SYSTEM_API_OPERATION
		DELETE FROM  ESB_SYSTEM_API_OPERATION WHERE SYSTEM_API_ID = (SELECT ID FROM ESB_SYSTEM_API WHERE CODE = 'XXXXX_API_CODE')
											  AND   VERSION       = 'XXXXX_API_OP_VER'
											  AND  	NAME          = 'XXXXX_API_OP_NAME';
		---------------------------------------------         
			 
	DELETE FROM  ESB_SYSTEM_API WHERE SYSTEM_ID = (SELECT ID FROM ESB_SYSTEM WHERE CODE = 'XXXXX_CODE') AND CODE = 'XXXXX_API_CODE';
	-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	-- ESB_SYSTEM
	DELETE FROM  ESB_SYSTEM WHERE CODE = 'XXXXX_CODE';

END;

/
COMMIT;