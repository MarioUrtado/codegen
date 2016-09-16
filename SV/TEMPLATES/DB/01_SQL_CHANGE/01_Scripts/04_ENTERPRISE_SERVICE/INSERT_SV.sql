SET ECHO ON
SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR CONTINUE ROLLBACK
------------------------------------------------------------------------------------
-- The following commments can be deleted for each Release
------------------------------------------------------------------------------------
----------------------------------------------------------------
-- V_SERV_CODE @@ ServiceCode
-- V_SERV_NAME @@ ServiceName
-- V_CAP_OP_CODE @@ OperationCode
-- V_CAP_OP_NAME @@ OperationName
----------------------------------------------------------------

DECLARE
	 ELEMENT_CONT number;
	
	 V_SERV_CODE ESB_SERVICE.CODE%TYPE;
     V_SERV_NAME ESB_SERVICE.NAME%TYPE;
     V_CAP_OP_CODE ESB_CAPABILITY.CODE%TYPE;
     V_CAP_OP_NAME ESB_CAPABILITY.NAME%TYPE;

    PROCEDURE CREATE_CAPABILITY IS
	BEGIN
	-- ESB_CAPABILITY ----------------------------------------------------------------------------------------------------------------------------------------
		SELECT COUNT(*) INTO ELEMENT_CONT	FROM ESB_CAPABILITY	WHERE CODE=V_CAP_OP_CODE;		
		IF ELEMENT_CONT=0 THEN
			INSERT INTO ESB_CAPABILITY (ID,SERVICE_ID,CODE,NAME,RCD_STATUS)  VALUES (ESB_CAPABILITY_SEQ.NEXTVAL,( SELECT ID FROM ESB_SERVICE WHERE CODE = V_SERV_CODE),V_CAP_OP_CODE,V_CAP_OP_NAME,'1');
		ELSE
			DBMS_OUTPUT.PUT_LINE('ESB_CAPABILITY             '||V_CAP_OP_CODE||' ya existe');
		END IF;

	-- ESB_CAPABILITY_CHECK ----------------------------------------------------------------------------------------------------------------------------
		
		SELECT COUNT(*) INTO ELEMENT_CONT FROM ESB_CAPABILITY_CHECK WHERE CAPABILITY_ID=( SELECT ID FROM ESB_CAPABILITY WHERE CODE = V_CAP_OP_CODE);		
		IF ELEMENT_CONT=0 THEN
			INSERT INTO ESB_CAPABILITY_CHECK (ID,CAPABILITY_ID,CHECK_INDICATOR,RCD_STATUS) 
			VALUES (ESB_CAPABILITY_CHECK_SEQ.NEXTVAL,( SELECT ID FROM ESB_CAPABILITY WHERE CODE = V_CAP_OP_CODE),'0','1');
		ELSE
			DBMS_OUTPUT.PUT_LINE('ESB_CAPABILITY_CHECK       '||V_CAP_OP_CODE||' ya existe');
		END IF;

	-- ESB_PARAMETER  -------------------------------------------------------------------------------------------------------------------------------
		
		SELECT COUNT(*) INTO ELEMENT_CONT	FROM ESB_PARAMETER	WHERE KEY='Logger.error.IsEnabled.'||V_SERV_CODE||'.'||V_SERV_NAME||'.'||V_CAP_OP_NAME;		
		IF ELEMENT_CONT=0 THEN	
			INSERT INTO ESB_PARAMETER (KEY,VALUE,RCD_STATUS) VALUES ('Logger.error.IsEnabled.'||V_SERV_CODE||'.'||V_SERV_NAME||'.'||V_CAP_OP_NAME,'1','1');
		ELSE
			DBMS_OUTPUT.PUT_LINE('ESB_PARAMETER Logger.error '||V_CAP_OP_NAME||' ya existe');
		END IF;

		SELECT COUNT(*) INTO ELEMENT_CONT	FROM ESB_PARAMETER	WHERE KEY='Logger.log.IsEnabled.'||V_SERV_CODE||'.'||V_SERV_NAME||'.'||V_CAP_OP_NAME;		
		IF ELEMENT_CONT=0 THEN	
			INSERT INTO ESB_PARAMETER (KEY,VALUE,RCD_STATUS) VALUES ('Logger.log.IsEnabled.'||V_SERV_CODE||'.'||V_SERV_NAME||'.'||V_CAP_OP_NAME,'1','1');
		ELSE
			DBMS_OUTPUT.PUT_LINE('ESB_PARAMETER Logger.log   '||V_CAP_OP_NAME||' ya existe');
		END IF;

	END CREATE_CAPABILITY;

	PROCEDURE CREATE_SERVICE IS
	BEGIN
	-- ESB_SERVICE ----------------------------------------------------------------------------------------------------------------------------------
 		SELECT COUNT(*) INTO ELEMENT_CONT FROM ESB_SERVICE WHERE CODE=V_SERV_CODE;		
		IF ELEMENT_CONT=0 THEN
			INSERT INTO ESB_SERVICE (ID,CODE,NAME,RCD_STATUS) VALUES (ESB_SERVICE_SEQ.NEXTVAL,V_SERV_CODE,V_SERV_NAME,'1');
		ELSE
			DBMS_OUTPUT.PUT_LINE('ESB_SERVICE '||V_SERV_CODE||' ya existe');
		END IF;
	END CREATE_SERVICE;

BEGIN

-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-
-- ======================================================================================================================================================
-- == INCIO DE ZONA A MODIFICAR =========================================================================================================================
-- ======================================================================================================================================================

	 V_SERV_CODE :='%SERVICE_CODE%';
	 V_SERV_NAME :='%SERVICE_NAME%';
	 
	 CREATE_SERVICE;

----------------------------------------------------------------------------------------------------------------------------------------------------------
-- Repetir el bloque por capacidad del servicio a crear.
----------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------   INICIO BLOQUE   --------------------------------------------------------------------------------------------------------------
%CAPABILITY_QUERY%


---   Para casos particulares de nececidad de insertar informacion adicional como por ejemplo en la tabla 
--- ESB_PARAMETER, colocar dichos insert en este espacio reservado

-------------------------  FIN BLOQUE  ------------------------------------------------------------------------------------------------------------------
--
-- ======================================================================================================================================================
-- == FIN DE ZONA A MODIFICAR ===========================================================================================================================
-- ======================================================================================================================================================
-- *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-

END;
/
COMMIT;