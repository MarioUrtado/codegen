create or replace 
PACKAGE BODY ESB_CONVERSATION_MANAGER_PKG
AS

---------------------------------------------------------------------------------------------------
	PROCEDURE getConversationStatus(

		p_CONVERSATION_ID 		IN VARCHAR2,
		p_STATUS				OUT VARCHAR2,
		p_RSP_MSG 			    OUT CLOB,
		p_CAN_ERROR_ID 			OUT NUMBER) IS

			BEGIN
      
				p_STATUS := '';
				p_RSP_MSG := null;
				p_CAN_ERROR_ID := '';
     		
				SELECT CS.STATUS, CS.RSP_MSG, CS.CAN_ERR_ID INTO p_STATUS, p_RSP_MSG, p_CAN_ERROR_ID FROM ESB_CONVERSATION_STATUS CS
				WHERE CONVERSATION_ID = p_CONVERSATION_ID;
			
			EXCEPTION
				WHEN NO_DATA_FOUND THEN 
					p_STATUS := 'NO SE ENCONTRARON DATOS. '||SQLERRM;
				WHEN OTHERS THEN 
					p_STATUS := 'ERROR AL CONSULTAR EN TABLA ESB_CONVERSATION_STATUS. '||SQLERRM;						
				
	END getConversationStatus;

---------------------------------------------------------------------------------------------------
	PROCEDURE updateConversationStatus(

		p_CONVERSATION_ID 	  IN VARCHAR2, 
		p_STATUS 			      	IN VARCHAR2,
		p_RSP_MSG 			    	IN CLOB,
		p_CAN_ERROR_CODE  	 	IN NUMBER,
		p_CAN_ERROR_TYPE     	IN VARCHAR2,
		p_UPDATE_COMPONENT		IN VARCHAR2,
		p_UPDATE_OPERATION		IN VARCHAR2,
    
		p_RESULT_CODE			OUT VARCHAR2,
		p_RESULT_DESCRIPTION 	OUT VARCHAR2) IS
    
    status VARCHAR2(30);
    
		BEGIN
       
      SELECT CS.STATUS INTO status FROM ESB_CONVERSATION_STATUS CS
      WHERE CONVERSATION_ID = p_CONVERSATION_ID;
      
      IF NOT(status IS NULL) THEN 
          UPDATE esb_conversation_status CS SET cs.status = p_status, 
                              cs.rsp_msg = p_rsp_msg, 
                              cs.can_err_id = (select CE.ID from esb_canonical_error CE  INNER JOIN esb_canonical_error_type CET ON CET.ID = CE.TYPE_ID
                                       where CE.CODE = p_CAN_ERROR_CODE AND CET.TYPE = p_CAN_ERROR_TYPE),
                              cs.update_component = p_update_component, 
                              cs.update_operation = p_update_operation, 
                              cs.update_timestamp = TO_TIMESTAMP (SYSDATE, 'DD-Mon-RR HH24:MI:SS.FF') 
                             
                              WHERE cs.conversation_id = p_conversation_id
    
          RETURNING cs.conversation_id INTO p_RESULT_CODE;
          		
     END IF;
     
		EXCEPTION    
    
      WHEN NO_DATA_FOUND then
      
       insert into esb_conversation_status (CONVERSATION_ID, STATUS, RSP_MSG, CAN_ERR_ID, CREATION_TIMESTAMP, UPDATE_TIMESTAMP, UPDATE_COMPONENT, UPDATE_OPERATION)
       values (p_CONVERSATION_ID, p_STATUS, p_RSP_MSG, (select CE.ID from esb_canonical_error CE  INNER JOIN esb_canonical_error_type CET ON CET.ID = CE.TYPE_ID
                                       where CE.CODE = p_CAN_ERROR_CODE AND CET.TYPE = p_CAN_ERROR_TYPE), TO_TIMESTAMP (SYSDATE, 'DD-Mon-RR HH24:MI:SS.FF') ,
                                       TO_TIMESTAMP (SYSDATE, 'DD-Mon-RR HH24:MI:SS.FF') , p_UPDATE_COMPONENT, p_UPDATE_OPERATION );
                          
	  WHEN OTHERS THEN 
			p_RESULT_CODE := '-99';
			p_RESULT_DESCRIPTION := 'ERROR AL INSERTAR EN TABLA ESB_CONVERSATION_STATUS. '||SQLERRM;	
    
    END updateConversationStatus;
---------------------------------------------------------------------------------------------------    
PROCEDURE putConversationStatus(P_CONVERSATION_ID IN VARCHAR2, p_RESULT_CODE OUT VARCHAR2, p_RESULT_DESCRIPTION OUT VARCHAR2 )
IS

status VARCHAR2(30);
duplicate_transaction EXCEPTION;

BEGIN

   SELECT CS.STATUS INTO status FROM ESB_CONVERSATION_STATUS CS
   WHERE CONVERSATION_ID = p_CONVERSATION_ID;
   
   IF NOT(status IS NULL) THEN RAISE duplicate_transaction;
   END IF;

    
EXCEPTION 
  WHEN NO_DATA_FOUND THEN 
      INSERT INTO ESB_CONVERSATION_STATUS ( CONVERSATION_id, STATUS, CAN_ERR_ID, CREATION_TIMESTAMP,UPDATE_TIMESTAMP )
      VALUES ( P_CONVERSATION_ID,'PENDING',0,TO_TIMESTAMP (SYSDATE, 'DD-Mon-RR HH24:MI:SS.FF'),null) ;
      COMMIT;
	
  WHEN duplicate_transaction THEN
      p_RESULT_CODE := '-99';
      p_RESULT_DESCRIPTION := 'ERROR AL INSERTAR EN TABLA ESB_CONVERSATION_STATUS. ' ||SQLERRM; 
  WHEN OTHERS THEN 
			p_RESULT_CODE := '-99';
			p_RESULT_DESCRIPTION := 'ERROR AL INSERTAR EN TABLA ESB_CONVERSATION_STATUS. '||SQLERRM;		
	
END putConversationStatus;
---------------------------------------------------------------------------------------------------  
PROCEDURE getConsumerCallbackURL(
    p_SYSTEM_CODE 		    IN VARCHAR2, 
    p_COUNTRY_CODE        IN VARCHAR2,
    p_ENTERPRISE_CODE     IN VARCHAR2,
    p_SERVICE_CODE     IN VARCHAR2,
	p_CAPABILITY_NAME     IN VARCHAR2,
    p_TRANSPORT           OUT VARCHAR2,
    p_CALLBACK_URL        OUT VARCHAR2,
    p_SOAP_ACTION         OUT VARCHAR2,
		p_RESULT_CODE 			  OUT VARCHAR2,
		p_RESULT_DESCRIPTION 	OUT VARCHAR2) AS
       
    p_CONSUMER_ID NUMBER;
	p_CAPABILITY_CODE VARCHAR2(30);
    
    BEGIN
    
    
    existsConsumer(p_SYSTEM_CODE, p_COUNTRY_CODE, p_ENTERPRISE_CODE, p_CONSUMER_ID);
    
    IF (p_CONSUMER_ID != -1) THEN
    
      getCapabilityCode(p_SERVICE_CODE, p_CAPABILITY_NAME, p_CAPABILITY_CODE);
	  
	  IF (p_CAPABILITY_CODE != '-1') THEN 
        getConsumerCallbackURLWithCap(p_CONSUMER_ID, p_CAPABILITY_CODE, p_TRANSPORT, p_CALLBACK_URL, p_SOAP_ACTION, p_RESULT_CODE, p_RESULT_DESCRIPTION);
      ELSE
        getConsumerCallbackURLLessCap(p_CONSUMER_ID, p_TRANSPORT, p_CALLBACK_URL, p_RESULT_CODE, p_RESULT_DESCRIPTION);
      END IF;
    
    ELSE 
      
        p_RESULT_CODE := '-1';
        p_RESULT_DESCRIPTION := 'CONSUMIDOR NO REGISTRADO. '  || SQLERRM;
    
    END IF;
    
    END;
    
    
    
---------------------------------------------------------------------------------------------------

PROCEDURE getCapabilityCode(
	p_SERVICE_CODE		IN VARCHAR2, 
	p_CAPABILITY_NAME	IN VARCHAR2, 
	p_CAPABILITY_CODE	OUT VARCHAR2) AS
	
	BEGIN
	
		SELECT EC.CODE INTO p_CAPABILITY_CODE FROM ESB_CAPABILITY EC
		WHERE
			EC.SERVICE_ID = (SELECT ID FROM esb_service WHERE CODE = p_SERVICE_CODE)
		AND
			EC.NAME = p_CAPABILITY_NAME;
			
		EXCEPTION
		WHEN NO_DATA_FOUND THEN
			p_CAPABILITY_CODE := '-1';
	END;

---------------------------------------------------------------------------------------------------
  
PROCEDURE getConsumerCallbackURLWithCap(
    p_CONSUMER_ID         IN NUMBER,
    p_CAPABILITY_CODE     IN VARCHAR2,
    p_TRANSPORT           OUT VARCHAR2,
    p_CALLBACK_URL        OUT VARCHAR2,
    p_SOAP_ACTION         OUT VARCHAR2,
		p_RESULT_CODE 			  OUT VARCHAR2,
		p_RESULT_DESCRIPTION 	OUT VARCHAR2) AS
    
    BEGIN
    
        getSOAPAction(p_CAPABILITY_CODE, p_SOAP_ACTION);
    
        SELECT ECCD.DETAIL_CONTENT INTO p_TRANSPORT FROM ESB_CONSUMER_CAP_DETAILS ECCD
        WHERE
          ECCD.DETAIL_TYPE_ID = (SELECT ID FROM esb_consumer_cap_details_type WHERE NAME = 'TRANSPORT' )
        AND
          ECCD.consumer_id = p_CONSUMER_ID
        AND 
        ECCD.capability_id = (SELECT ID FROM esb_capability WHERE CODE = p_CAPABILITY_CODE );

        
        SELECT ECCD.DETAIL_CONTENT INTO p_CALLBACK_URL FROM ESB_CONSUMER_CAP_DETAILS ECCD
        WHERE
          ECCD.DETAIL_TYPE_ID = (SELECT ID FROM esb_consumer_cap_details_type WHERE NAME = 'CALLBACK_URL' )
        AND
          ECCD.consumer_id = p_CONSUMER_ID
        AND 
          ECCD.capability_id = (SELECT ID FROM esb_capability WHERE CODE = p_CAPABILITY_CODE);
        
      p_RESULT_CODE := '0';
      p_RESULT_DESCRIPTION := 'Ejecucion exitosa.';
      
      EXCEPTION
      WHEN NO_DATA_FOUND THEN
        getConsumerCallbackURLLessCap(p_CONSUMER_ID, p_TRANSPORT, p_CALLBACK_URL, p_RESULT_CODE, p_RESULT_DESCRIPTION);
        
       WHEN OTHERS THEN
        p_RESULT_CODE := '-98';
        p_RESULT_DESCRIPTION := 'SE HA PRODUCIDO UN ERROR EN LA BUSQUEDA DE LA URI. ' || SQLERRM;
    
    END;

---------------------------------------------------------------------------------------------------  
PROCEDURE getSOAPAction(
    p_CAPABILITY_CODE     IN VARCHAR2,
    p_SOAP_ACTION         OUT VARCHAR2) AS
    
    BEGIN
    
      SELECT DETAIL_CONTENT INTO p_SOAP_ACTION FROM ESB_CAPABILITY_DETAILS 
      WHERE
          CAPABILITY_ID = (SELECT ID FROM esb_capability WHERE CODE = p_CAPABILITY_CODE)
      AND
          DETAIL_TYPE_ID = (SELECT ID FROM ESB_CAPABILITY_DETAILS_TYPE WHERE DESCRIPTION = 'SOAP Action');
  
      EXCEPTION
      WHEN NO_DATA_FOUND THEN
        p_SOAP_ACTION := '-1';
        
    END;

    
---------------------------------------------------------------------------------------------------  
PROCEDURE getConsumerCallbackURLLessCap(
    p_CONSUMER_ID         IN NUMBER,
    p_TRANSPORT           OUT VARCHAR2,
    p_CALLBACK_URL        OUT VARCHAR2,
		p_RESULT_CODE 			  OUT VARCHAR2,
		p_RESULT_DESCRIPTION 	OUT VARCHAR2) AS
    
    BEGIN
    
        SELECT ECCD.DETAIL_CONTENT INTO p_TRANSPORT FROM ESB_CONSUMER_DETAILS ECCD
        WHERE
          ECCD.DETAIL_TYPE_ID = (SELECT ID FROM esb_consumer_details_type WHERE NAME = 'TRANSPORT' )
        AND
          ECCD.consumer_id = p_CONSUMER_ID;

        
        SELECT ECCD.DETAIL_CONTENT INTO p_CALLBACK_URL FROM ESB_CONSUMER_DETAILS ECCD
        WHERE
          ECCD.DETAIL_TYPE_ID = (SELECT ID FROM esb_consumer_details_type WHERE NAME = 'URL' )
        AND
          ECCD.consumer_id = p_CONSUMER_ID;
        
      p_RESULT_CODE := '0';
      p_RESULT_DESCRIPTION := 'Ejecucion exitosa.';
      
      EXCEPTION
      WHEN NO_DATA_FOUND THEN
        p_RESULT_CODE := '-99';
        p_RESULT_DESCRIPTION := 'NO SE HAN ENCONTRADO DATOS. '  || SQLERRM;
        
       WHEN OTHERS THEN
        p_RESULT_CODE := '-98';
        p_RESULT_DESCRIPTION := 'SE HA PRODUCIDO UN ERROR EN LA BUSQUEDA DE LA URI. ' || SQLERRM;
    
    END;

---------------------------------------------------------------------------------------------------

  PROCEDURE existsConsumer(
    p_SYSTEM_CODE 		    IN VARCHAR2, 
    p_COUNTRY_CODE        IN VARCHAR2,
    p_ENTERPRISE_CODE     IN VARCHAR2,
    p_CONSUMER_ID OUT NUMBER
  )AS
  
  BEGIN
          SELECT ID INTO p_CONSUMER_ID FROM esb_consumer WHERE ESB_CONSUMER.syscode = (SELECT ID FROM esb_system WHERE CODE = p_SYSTEM_CODE) 
                                        AND ESB_CONSUMER.country_id = (SELECT ID FROM esb_country WHERE CODE = p_COUNTRY_CODE)
                                        AND ESB_CONSUMER.ent_code = (SELECT ID FROM esb_enterprise WHERE CODE = p_ENTERPRISE_CODE);
          EXCEPTION
          WHEN NO_DATA_FOUND THEN
          p_CONSUMER_ID := -1;
          
  END;

---------------------------------------------------------------------------------------------------

    PROCEDURE getSequenceStatusConversation(
    p_CONVERSATION_ID 		 IN VARCHAR2,
    p_CONVERSATION_STATUS	 OUT VARCHAR2,
		p_SEQ_STATUS 				   OUT NUMBER)IS
    
	P_RSP_MSG CLOB;
	P_CAN_ERROR_ID NUMBER;
    
    BEGIN
      
      getConversationStatus(p_CONVERSATION_ID, p_CONVERSATION_STATUS, P_RSP_MSG, P_CAN_ERROR_ID);
      getSequenceStatus(p_CONVERSATION_ID, p_SEQ_STATUS);
        
    END;

---------------------------------------------------------------------------------------------------

PROCEDURE getSequenceStatus(
    p_CONVERSATION_ID 		 IN VARCHAR2,
    p_SEQ_STATUS	 OUT NUMBER) IS
    
    BEGIN
      
      SELECT SEQUENCE INTO p_SEQ_STATUS FROM ESB_CONVERSATION WHERE CONVERSATION_ID = p_CONVERSATION_ID;
      
      EXCEPTION
      WHEN NO_DATA_FOUND THEN
        p_SEQ_STATUS := -1;

    END;

---------------------------------------------------------------------------------------------------

PROCEDURE getInfo(
    p_CONVERSATION_ID IN VARCHAR2,
    p_CONV_TYPE 	  OUT VARCHAR2,
    p_CONV_SEQUENCE 	  OUT VARCHAR2,
    p_CONV_SERVICE	  OUT VARCHAR2,
    p_CONV_CAPABILITY 	  OUT VARCHAR2,
    p_CONV_STATUS 	  OUT VARCHAR2,
    p_CONV_TX_TYPE 	  OUT VARCHAR2,
    p_CONV_TX_SEQUENCE 	  OUT VARCHAR2,
    p_CONV_TX_EVENT_ID 	  OUT VARCHAR2,
    p_CONV_TX_PROCESS_ID 	  OUT VARCHAR2,
    p_CONV_TX_CORR_ID 	  OUT VARCHAR2,
    p_CONV_TX_STATUS 	  OUT VARCHAR2,
    p_RESULT_CODE OUT VARCHAR2,
    p_RESULT_DESC OUT VARCHAR2
    ) IS
    
    /*
    Este procedimiento tiene como objetivo retornar informacion asociada a la conversacion enviada por parametro.
    
    * v1.0 @ 13/7/2016 ~ Mario Mesaglio 
    
    Conceptos :
    
    Las Transacciones son definidas, logicamente, como la relacion entre un Consumidor, un Mensaje, y una Capacidad de Servicio. 
    Toda ejecucion de una capacidad de sericio, genera una Conversacion que representa univocamente esa instancia de ejecucion.
    
    Consumidor --Mensaje--> Capacidad (Servicio) ~ Conversacion
    
    Llamamos a esta Transaccion, como "Main Transaction". 
    Llamamos a esta capacidad como "Main Transaction Capability".
    Llamamos a esta Conversacion como "Main Transaction Owner". 
    
    Se denomina como "Main Transaciton Owner" debido a que, la conversacion, es el unico actor responsable de determinar el resultado
    funcional de la Main Transaction. Solo cuando la Main Transaction Owner se determina a si mismo como Exitosa, se puede considerar
    la Main Transaction asociada como FUNCIONALMENTE exitosa. Lo mismo aplica para casos donde no se haya considerado como exitosa.
    
    Ahora bien, el Framework permite la instanciacion de una Main Transaction, en forma de uno a varios registros correlativos 
    en la tabla ESB_MESSAGE_TRANSACTION.

    Las instancias de una misma transaccion comparten, al menos, la siguiente informacion: EVENT_ID y PROCESS_ID.
    
    Cada instancia de transaccion percibe de una SEQUENCE (campo en la tabla) distinta y determinada de manera incremental
    para cada una, comenzando siempre por el primer registro con SEQUENCE 0. Cada Instancia de Transaccion, a su vez, puede percibir
    de varias Conversaciones, tambien identificadas mediante un SEQUENCE (@ESB_CONVERSATION) comenzando siempre por el primer registro con
    SEQUENCE 0. Cada instancia de transaccion, percibe de un unico CORRELATION_ID. Dos instancias de Transaccion nunca van a tener un mismo valor
    para este campo.
    
    Llamamos a las instancias de transaccion como "Transaction Instance". La primer conversacion (SEQUENCE = 0 @ ESB_CONVERSATION) asociada a
    cada Transaction Instance, es siempre denominada "Transaction Instance Owner", y finalmente el resto de las conversaciones asociadas
    (SEQUENCE != 0 @ ESB_CONVERSATION) son siempre denominadas como "Transaciton Instance Member".
       
    Por ello, la primer Transaction Instance de una misma Main Transaction tiene siempre como SEQUENCE el valor 0, 
    y un CORRELATION_ID determinado por el Consumidor del Servicio. El CORRELATION_ID podría tambien ser omitido en este caso. 
     
    Entonces :  
    --> La Transaction Instance de SEQUENCE = 0  se denomina  como "Main Transaction Instance", al ser la que representa mas fehacientemente
        el estado original de la Main Transaciton asociada.
    --> La Transaction Instance Owner de la Main Transaction Instance se denomina como "Main Transaction Instance Owner", 
        al ser la que representa mas fehacientamente el estado original de la Main Transaction Owner.
    
    El resto de las Transaction Instance pueden ser sub-categorizadas en los siguientes tipos :
    
    1 - "Main Transaction Clone"
        
        Representa un re-proceso de la Main Transaction Instance.
        
        Este esenario puede ser dado por acciones del Framework (Ej.: Tratamiento de Reintentos), o bien por la re-emision de una 
        Main Transaction (Mismo EVENT_ID y PROCESS_ID, a la misma Capacidad) con CORRELATION_ID distinto por un Consumidor de Servicio.
        Una Main Transacion Clone percibe de cualidades propias de una Main Transaction Instance. 
        Ej.: Validaciones x Duplicidad, Tratamiento de Errores, Agrupacion de Logs, etc.
        
        Para generar una Main Transaction Clone, se debe ejecutar la misma Capacidad de Servicio involucrada originalmente en la 
        Main Transaction, con los mismos EVENT_ID y PROCESS ID; pero con un CORRELATION_ID diferente.
        
          --> De esta manera trabaja el tratamiento de reintentos, donde en cada reintento se envia un CORRELATION_ID distinto.
        
        Una Transaction Instance es una Main Transaction Clone, si solo si :
          
          A - Su SEQUENCE (@ ESB_MESSAGE_TRANSACTION) != 0.
          B - Su CORRELATION_ID =! al CORRELATION_ID de la Main Transaction Instance.
          C - Su Transaction Instance Owner, tiene la misma CAPABILITY_ID (@ESB_CONVERSATION) que la Main Transaction Instance Owner.
    
    ~~~~~~~~~~ RESUMEN :
    
    Tipos de Transaction Instance (@ESB_MESSAGE_TRANSACTION) :
    
    --> Main Transaction Instance
    --> Main Transaction Clone
    
    Tipos de Transaction Owner (@ESB_CONVERSATION) :
    
    --> Main Transaction Owner
    --> Main Transaction Member
    
    ~~~~~~~~~~ IMPORTANTE :

    --> Cualquier otra Transaction Instance cuyo tipo difiera de los antes mencionados, no es soportada por el FRW al dia de la fecha. 
    
    --> Cualquier otra Transaction Instance Owner cuyo tipo difiera de los antes mencionados, no es soportada por el FRW al dia de la fecha. 
    
    --> La creacion de Transaction Instance y Transaction Instance Owner de tipo diferente de los antes mencionados, puede causar comportamiento 
        inesperado por parte del FRW.
    
    -----------------------------------------------------------------------------------------------------------------------------  
    
    */

    p_CONV_CAP_ID  NUMBER; -- ID @ ESB_CAPABILITY (Capacidad Asociada) de la Conversacion enviada por parametro.
    
    p_CONV_TX_ID NUMBER; -- ID @ ESB_MESSAGE_TRANSACTION de la Transaction Instance asociada a la Conversacion enviada por parametro.

    p_MT_INST_OWN_CONV_CAP_ID  NUMBER; -- ID @ ESB_CONVERSATION de la Main Transaction Instance Owner
    p_MT_INST_TX_ID NUMBER; -- ID @ ESB_MESSAGE_TRANSACTION de la Main Transaction Instance
    p_MT_INST_TX_CORR_ID VARCHAR2(100); -- ID @ ESB_MESSAGE_TRANSACTION de la Main Transaction Instance
    
    BEGIN
      
      BEGIN
        ---------------------------------------------------------------------------------------------------------------------------------------------------
        -- Obtenemos informacion detallada de la conversacion, y Transaction Instance asociada.
        ---------------------------------------------------------------------------------------------------------------------------------------------------
        SELECT
          C.MESSAGE_TX_ID,
          C.SEQUENCE,
          C.CAPABILITY_ID
            INTO p_CONV_TX_ID,p_CONV_SEQUENCE,p_CONV_CAP_ID
        FROM ESB_CONVERSATION C 
        WHERE 
          C.CONVERSATION_ID = p_CONVERSATION_ID;
            
        SELECT 
         C.NAME,
         S.NAME
          INTO P_CONV_CAPABILITY,P_CONV_SERVICE
        FROM ESB_CAPABILITY C 
          INNER JOIN ESB_SERVICE S ON
            S.ID = C.SERVICE_ID
        WHERE C.ID = p_CONV_CAP_ID;
        
        SELECT
          C.STATUS
            INTO p_CONV_STATUS
        FROM ESB_CONVERSATION_STATUS C
        WHERE C.CONVERSATION_ID = p_CONVERSATION_ID;
            
        SELECT 
          M.SEQUENCE, 
          M.EVENT_ID,
          M.PROC_ID,
          M.CORRELATION_ID,
          M.STATUS
            INTO p_CONV_TX_SEQUENCE,p_CONV_TX_EVENT_ID,p_CONV_TX_PROCESS_ID,p_CONV_TX_CORR_ID,p_CONV_TX_STATUS
        FROM ESB_MESSAGE_TRANSACTION M
        WHERE 
          M.ID = p_CONV_TX_ID;
          
        ---------------------------------------------------------------------------------------------------------------------------------------------------
        
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
          p_CONV_TYPE := '';
          p_CONV_SEQUENCE := '';
          p_CONV_SERVICE := '';
          p_CONV_CAPABILITY := '';
          p_CONV_STATUS := '';
          p_CONV_TX_TYPE := '';
          p_CONV_TX_SEQUENCE := '';
          p_CONV_TX_EVENT_ID := '';
          p_CONV_TX_PROCESS_ID := '';
          p_CONV_TX_CORR_ID := '';
          p_CONV_TX_STATUS := '';
          
          p_RESULT_CODE := '-1';
          p_RESULT_DESC := 'No se encontraron datos para la Conversacion enviada por parametro';
          RETURN;
      END;
      
      ---------------------------------------------------------------------------------------------------------------------------------------------------
      -- Obtenemos la Main Transaction Instance y la Main Tranaction Instance Owner, para la Main Transaction identificada segun los EVENT_ID y PROCESS_ID
      ---------------------------------------------------------------------------------------------------------------------------------------------------
      BEGIN
        SELECT 
            M.ID,
            COALESCE(M.CORRELATION_ID,'./@')
              INTO p_MT_INST_TX_ID,p_MT_INST_TX_CORR_ID
          FROM ESB_MESSAGE_TRANSACTION M
          WHERE 
            M.EVENT_ID = p_CONV_TX_EVENT_ID AND
            M.PROC_ID = p_CONV_TX_PROCESS_ID AND
            M.SEQUENCE = 0;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          p_CONV_TYPE := '';
          p_CONV_SEQUENCE := '';
          p_CONV_SERVICE := '';
          p_CONV_CAPABILITY := '';
          p_CONV_STATUS := '';
          p_CONV_TX_TYPE := '';
          p_CONV_TX_SEQUENCE := '';
          p_CONV_TX_EVENT_ID := '';
          p_CONV_TX_PROCESS_ID := '';
          p_CONV_TX_CORR_ID := '';
          p_CONV_TX_STATUS := '';
          
          p_RESULT_CODE := '-1';
          p_RESULT_DESC := 'No se encontraron datos para la Conversacion enviada por parametro';
          RETURN;
          
        WHEN TOO_MANY_ROWS THEN
          p_CONV_TYPE := '';
          p_CONV_SEQUENCE := '';
          p_CONV_SERVICE := '';
          p_CONV_CAPABILITY := '';
          p_CONV_STATUS := '';
          p_CONV_TX_TYPE := '';
          p_CONV_TX_SEQUENCE := '';
          p_CONV_TX_EVENT_ID := '';
          p_CONV_TX_PROCESS_ID := '';
          p_CONV_TX_CORR_ID := '';
          p_CONV_TX_STATUS := '';
          
          p_RESULT_CODE := '-3';
          p_RESULT_DESC := 'La Transacción asociada no se corresponde con ningun tipo de Transaction Instance definido.';
          RETURN;
      END;
      
     BEGIN
        SELECT
            C.CAPABILITY_ID
              INTO p_MT_INST_OWN_CONV_CAP_ID
          FROM ESB_CONVERSATION C 
          WHERE 
            C.MESSAGE_TX_ID = p_MT_INST_TX_ID AND
            C.SEQUENCE = 0;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          p_CONV_TYPE := '';
          p_CONV_SEQUENCE := '';
          p_CONV_SERVICE := '';
          p_CONV_CAPABILITY := '';
          p_CONV_STATUS := '';
          p_CONV_TX_TYPE := '';
          p_CONV_TX_SEQUENCE := '';
          p_CONV_TX_EVENT_ID := '';
          p_CONV_TX_PROCESS_ID := '';
          p_CONV_TX_CORR_ID := '';
          p_CONV_TX_STATUS := '';
          
          p_RESULT_CODE := '-1';
          p_RESULT_DESC := 'No se encontraron datos para la Conversacion enviada por parametro';
          RETURN;
          
        WHEN TOO_MANY_ROWS THEN
          p_CONV_TYPE := '';
          p_CONV_SEQUENCE := '';
          p_CONV_SERVICE := '';
          p_CONV_CAPABILITY := '';
          p_CONV_STATUS := '';
          p_CONV_TX_TYPE := '';
          p_CONV_TX_SEQUENCE := '';
          p_CONV_TX_EVENT_ID := '';
          p_CONV_TX_PROCESS_ID := '';
          p_CONV_TX_CORR_ID := '';
          p_CONV_TX_STATUS := '';
          
          p_RESULT_CODE := '-2';
          p_RESULT_DESC := 'El tipo de a Conversacion no se corresponde con ningun tipo de Transaction Owner definido.';
          RETURN;
      END;
      ---------------------------------------------------------------------------------------------------------------------------------------------------
          
       ---------------------------------------------------------------------------------------------------------------------------------------------------
      -- Determinamos el Tipo de la Conversacion enviada por parametro
      ---------------------------------------------------------------------------------------------------------------------------------------------------
      IF (p_CONV_SEQUENCE = 0) THEN 
        p_CONV_TYPE := 'OWN'; -- Main Transaction Owner
      ELSE
        p_CONV_TYPE := 'MEM'; -- Main Transaction Member (Al 14/07/2016 no existen otros tipos)
      END IF;
      
      IF (p_CONV_TYPE IS NULL) THEN 
        p_CONV_TYPE := '';
        p_CONV_SEQUENCE := '';
        p_CONV_SERVICE := '';
        p_CONV_CAPABILITY := '';
        p_CONV_STATUS := '';
        p_CONV_TX_TYPE := '';
        p_CONV_TX_SEQUENCE := '';
        p_CONV_TX_EVENT_ID := '';
        p_CONV_TX_PROCESS_ID := '';
        p_CONV_TX_CORR_ID := '';
        p_CONV_TX_STATUS := '';
        
        p_RESULT_CODE := '-2';
        p_RESULT_DESC := 'El tipo de a Conversacion no se corresponde con ningun tipo de Transaction Owner definido.';
        RETURN;
        
      END IF;
      
      ---------------------------------------------------------------------------------------------------------------------------------------------------

      ---------------------------------------------------------------------------------------------------------------------------------------------------
      -- Determinamos el Tipo de Transaction Instance asociada.
      ---------------------------------------------------------------------------------------------------------------------------------------------------
      IF (p_CONV_TX_SEQUENCE = 0) THEN
           p_CONV_TX_TYPE := 'MTI'; -- Main Transaction Instance
      ELSE
        IF( 
          p_MT_INST_TX_CORR_ID <> p_CONV_TX_CORR_ID AND -- != CorrelationID
          p_CONV_CAP_ID = p_MT_INST_OWN_CONV_CAP_ID -- = Capacidad
            ) THEN
          p_CONV_TX_TYPE := 'MTC'; -- Main Transaction Clone
        END IF;
      END IF;
      
      IF (p_CONV_TX_TYPE IS NULL) THEN 
        p_CONV_TYPE := '';
        p_CONV_SEQUENCE := '';
        p_CONV_SERVICE := '';
        p_CONV_CAPABILITY := '';
        p_CONV_STATUS := '';
        p_CONV_TX_TYPE := '';
        p_CONV_TX_SEQUENCE := '';
        p_CONV_TX_EVENT_ID := '';
        p_CONV_TX_PROCESS_ID := '';
        p_CONV_TX_CORR_ID := '';
        p_CONV_TX_STATUS := '';
        
        p_RESULT_CODE := '-3';
        p_RESULT_DESC := 'La Transacción asociada no se corresponde con ningun tipo de Transaction Instance definido.';
        RETURN;
        
      END IF;
      
      ---------------------------------------------------------------------------------------------------------------------------------------------------
      
      p_RESULT_CODE := '0';
      p_RESULT_DESC := '';

    END;


END ESB_CONVERSATION_MANAGER_PKG;