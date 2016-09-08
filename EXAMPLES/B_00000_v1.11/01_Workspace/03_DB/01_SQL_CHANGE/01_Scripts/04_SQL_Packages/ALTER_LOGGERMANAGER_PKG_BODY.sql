create or replace PACKAGE BODY ESB_LOGGERMANAGER_PKG AS

  -- Este procedimiento no es utilizado por ahora. 
  PROCEDURE REGISTER_TRANSACTION_CHECK( p_MESSAGE_TX_ID IN NUMBER, p_CAPABILITY_ID IN NUMBER, p_CONVERSATION_ID IN VARCHAR2, TRANSACTION_CHECK_ID OUT NUMBER) IS
  BEGIN
  
    -- Revisamos si existe un registro para la dupla Servicio+Capacidad y y su ConversationID asignado 
    -- en la tabla ESB_TRANSACTION_CHECK, cuyo MESSAGE_TRANSACTION_ID sea el informado por parametro, 
    -- y de asi serlo que su MESSAGE_TX_ID exista en la tabla ESB_MESSAGE_TRANSACTION.
    SELECT 
      C.ID INTO TRANSACTION_CHECK_ID
    FROM 
      ESB_TRANSACTION_CHECK C 
      INNER JOIN 
        ESB_MESSAGE_TRANSACTION M ON M.ID = C.MESSAGE_TX_ID
    WHERE 
      C.CAPABILITY_ID = p_CAPABILITY_ID AND
      C.CONVERSATION_ID = p_CONVERSATION_ID AND
      M.ID = p_MESSAGE_TX_ID;
  
  EXCEPTION
    
    -- Aqui deberia llegarse si solo si el registro de la dupla Servicio+Capacidad y su ConversationID asignado
    -- no fue realizada por el MessageManager de manera Sync.
    WHEN NO_DATA_FOUND THEN
      INSERT INTO ESB_TRANSACTION_CHECK(
        ID, 
        MESSAGE_TX_ID, 
        CONVERSATION_ID, 
        CAPABILITY_ID, 
        RSP_MSG, 
        RESULT_CODE, 
        RESULT_DESC, 
        RCD_STATUS) 
      VALUES (
        ESB_TRANSACTION_CHECK_SEQ.NEXTVAL, 
        p_MESSAGE_TX_ID,
        p_CONVERSATION_ID,
        p_CAPABILITY_ID, 
        '',
        '',
        '',    
        1) 
      RETURNING "ID" INTO TRANSACTION_CHECK_ID;
      
  END REGISTER_TRANSACTION_CHECK;

  PROCEDURE REGISTER_MESSAGE_TRANSACTION
    (
      p_CAPABILITY_ID        IN NUMBER,
      p_PROC_ID              IN VARCHAR2,
      p_EVENT_ID             IN VARCHAR2,
      p_CLIENT_REQ_TIMESTAMP IN VARCHAR2,
      p_CORRELATION_ID IN VARCHAR2,
      MESSAGE_TRANSACTION_ID OUT NUMBER
    )
  IS
    CAPABILITY_ID_AUX NUMBER;
    V_TX_AMOUNT NUMBER;
    V_TX_AMOUNT_CAP NUMBER;
    V_RCD_STATUS NUMBER;
  BEGIN

    -- Se busca la Tx. asociada a la conversacion sobre la cual se solicita un Log. Para identificar dicha Tx. se dependen de los datos :
    -- PROCESS_ID, EVENT_ID. Si solo si los 2 datos (que siempre son enviados por el cliente y no modificados)
    -- existen en la tabla ESB_MESSAGE_TRANSACTION se considera la Tx. como la owner de la conversacion antes mencionada.
    --
    -- En caso de no encontrar una Tx. asociada, se la genera para evitar perder el LOG. Esto es una accion esperada, como el componente
    -- MessageManager solo registra manualmente (sincronicamente) la Tx. cuando las validaciones configuradas para la dupla
    -- Servicio + Capacidad dependan de informacion para la cual no puede esperarse el Logging Async del LoggerManager (Idempotencia x ejemplo).
    --
    -- Importante : Si un cliente envia estos 2 mismos datos iguales, para distintas Tx., y la dupla Servicio + Capacidad
    -- asociada a ellas no percibe de validaciones que impidan mensajes duplicados, nuevas conversaciones generadas en base
    -- a estos 2 datos van a verse relacionados con el ULTIMO registro de la tabla ESB_MESSAGE_TRANSACTION que sea vea asociado
    -- a ellos.

    --Debido a que la comparacion con un valor si es '', osea NULL, no se puede realizar con el comparador de igual = 
    --Se utiliza la funcion COALESCE para para no agregar conplejidad al evaluar de forma diferente cuando se trata con calor nulos
        SELECT M.ID INTO MESSAGE_TRANSACTION_ID
        FROM ESB_MESSAGE_TRANSACTION M
        WHERE M.PROC_ID = p_PROC_ID AND M.EVENT_ID  = p_EVENT_ID AND COALESCE(M.CORRELATION_ID, './*@*@') = COALESCE(p_CORRELATION_ID, './*@*@') AND
          -- Este OrderBY y ROWNUM se estabece por la (remota) posibilidad de que para una misma combinacion de :
          -- ProcessID+EventID se encuentren mas de un registro. Se debe asumir que el
          -- ProcessID+EventID no son modificados una vez son recibidos de un cliente externo.
          ROWNUM=1
        ORDER BY M.MSG_TIMESTAMP;
  EXCEPTION
    -- Aqui deberia llegarse si solo si el registro de la Tx. no fue realizada por el MessageManager de manera Sync.
  WHEN NO_DATA_FOUND THEN

    V_RCD_STATUS:= 1;
    --LLegando a este punto, se asegura que no existe una Transaccion con PROC_ID+EVENT_ID+CORRELATION_ID, y por ende, no pertenece a un tipo de mensaje
    --Member de una transaccion ( Ya sea, Main Transaction Instance Member, o Main Transaction Clone Member ).
    --Si para este Mensaje no existe un registro en ESB_TRANSACTION_CHECK con esta capacidad (tenderia a ser una Main Transaction Instance O Clone Owner)y, 
    --existe transacciones con mismo PROC_ID y EVENT_ID (Rechazando el concepto anterior de ser una Main Transaction Instance Owner, ), Se lo considera un Mensaje no soportado por el FRW, dejando el RCD_STATUS = 0, como TX invalida

    SELECT count(*) INTO V_TX_AMOUNT_CAP FROM ESB_MESSAGE_TRANSACTION MT INNER JOIN ESB_TRANSACTION_CHECK TC ON ( MT.ID = TC.MESSAGE_TX_ID ) 
    WHERE MT.PROC_ID = p_PROC_ID AND MT.EVENT_ID = p_EVENT_ID AND TC.CAPABILITY_ID = p_CAPABILITY_ID;

    SELECT count(*) INTO V_TX_AMOUNT FROM ESB_MESSAGE_TRANSACTION MT 
    WHERE MT.PROC_ID = p_PROC_ID AND MT.EVENT_ID = p_EVENT_ID;

    IF (V_TX_AMOUNT > 0 AND V_TX_AMOUNT_CAP = 0) THEN
      V_RCD_STATUS:= 0;
    END IF;

    INSERT INTO ESB_MESSAGE_TRANSACTION
      (
        ID,
        PROC_ID,
        EVENT_ID,
        CLIENT_REQ_TIMESTAMP,
        STATUS,
        MSG_TIMESTAMP,
        "SEQUENCE",
        CORRELATION_ID,
        RCD_STATUS
      )
      VALUES
      (
        ESB_MESSAGE_TRANSACTION_SEQ.NEXTVAL,
        p_PROC_ID,
        p_EVENT_ID,
        TO_TIMESTAMP_TZ(p_CLIENT_REQ_TIMESTAMP,'YYYY-MM-DD HH24:MI:SS:FF TZH:TZM'),
        0, -- Se asume que es la primera Tx, y que el MessageManager eligio no registrarla sincronicamente.
        CURRENT_TIMESTAMP,
        --Si no encuentra una transaccion a partir de PROC_ID + EVENT_ID + CORRELATION_ID, siendo un segmento e la TX, 
        --se genera una transacion con SEQUENCE + 1 del PROC_ID + EVENT_ID (Si no encuentra transaccion, va a generar la de SEQUENCE = 0)
        (SELECT count(*) FROM ESB_MESSAGE_TRANSACTION MT WHERE MT.PROC_ID = p_PROC_ID AND MT.EVENT_ID  = p_EVENT_ID ),
        p_CORRELATION_ID,
        V_RCD_STATUS
      )
    RETURNING "ID"
    INTO MESSAGE_TRANSACTION_ID;
  END REGISTER_MESSAGE_TRANSACTION; 
  
  PROCEDURE REGISTER_CAPABILITY(p_SERVICE_NAME IN VARCHAR2, p_SERVICE_OPERATION IN VARCHAR2, p_SERVICE_CODE IN VARCHAR2, CAPABILITY_ID OUT NUMBER) IS
    v_SERVICE_ID NUMBER;
  BEGIN
    
    SELECT C.ID INTO CAPABILITY_ID 
      FROM 
        ESB_CAPABILITY C 
          INNER JOIN ESB_SERVICE S ON C.SERVICE_ID = S.ID
      WHERE 
        C."NAME" = p_SERVICE_OPERATION AND
        S.CODE = p_SERVICE_CODE;
    
    EXCEPTION
    
    WHEN NO_DATA_FOUND THEN
      CAPABILITY_ID := -1;
        
    IF(CAPABILITY_ID IS NULL OR CAPABILITY_ID = -1) THEN
      
      --- Insertamos el Servicio no encontrado con RCD_STATUS en 0 (Invalido)
      INSERT INTO ESB_SERVICE (
        ID,
        CODE,
        NAME,
        RCD_STATUS) 
      VALUES(
        ESB_SERVICE_SEQ.NEXTVAL, 
        p_SERVICE_CODE, 
        p_SERVICE_NAME,
        0) 
      RETURNING "ID" INTO v_SERVICE_ID;
      
      --- Insertamos la Capacidad no encontrada con RCD_STATUS en 0 (Invalido)
      INSERT INTO ESB_CAPABILITY (
        ID, 
        SERVICE_ID, 
        CODE, 
        NAME, 
        RCD_STATUS) 
      VALUES(
        ESB_CAPABILITY_SEQ.NEXTVAL, 
        v_SERVICE_ID,
        99,
        p_SERVICE_OPERATION,
        0) 
      RETURNING "ID" INTO CAPABILITY_ID;
    END IF;  

  END REGISTER_CAPABILITY;

  PROCEDURE GET_COUNTRY(p_COUNTRY_CODE IN VARCHAR2, COUNTRY_ID OUT NUMBER) IS
  BEGIN
    SELECT ID INTO COUNTRY_ID FROM ESB_COUNTRY WHERE CODE = p_COUNTRY_CODE;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      SELECT ID INTO COUNTRY_ID FROM ESB_COUNTRY WHERE CODE = '0'; -- Country code UNKNOWN.
  END GET_COUNTRY;
  
  PROCEDURE GET_CHANNEL(p_CHANNEL_NAME IN VARCHAR2, CHANNEL_ID OUT NUMBER) IS
  BEGIN
    
    SELECT ID INTO CHANNEL_ID FROM ESB_CHANNEL WHERE NAME = COALESCE(p_CHANNEL_NAME, 'UNK');
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO ESB_CHANNEL(ID, CODE, NAME, RCD_STATUS) VALUES(ESB_CHANNEL_SEQ.NEXTVAL, '99', COALESCE(p_CHANNEL_NAME, 'UNK'), 0) RETURNING "ID" INTO CHANNEL_ID;
  END GET_CHANNEL;
  
  PROCEDURE GET_SYSTEM(p_SYSTEM_CODE IN VARCHAR2, SYSTEM_ID OUT NUMBER) IS
  BEGIN
    SELECT ID INTO SYSTEM_ID FROM ESB_SYSTEM WHERE CODE = p_SYSTEM_CODE;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO ESB_SYSTEM ("ID", CODE, "NAME", DESCRIPTION, RCD_STATUS) VALUES(ESB_SYSTEM_SEQ.NEXTVAL, p_SYSTEM_CODE, p_SYSTEM_CODE, 'Unknown System', 0) RETURNING "ID" INTO SYSTEM_ID;
  END GET_SYSTEM;

  PROCEDURE GET_ENTERPRISE(p_ENTERPRISE_CODE IN VARCHAR2, ENTERPRISE_ID OUT NUMBER) IS
  BEGIN
    SELECT ID INTO ENTERPRISE_ID FROM ESB_ENTERPRISE WHERE CODE = p_ENTERPRISE_CODE;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO ESB_ENTERPRISE ("ID", CODE, "NAME", RCD_STATUS) VALUES(ESB_ENTERPRISE_SEQ.NEXTVAL, p_ENTERPRISE_CODE, p_ENTERPRISE_CODE, 0) RETURNING "ID" INTO ENTERPRISE_ID;
  END GET_ENTERPRISE;
     
  PROCEDURE GET_CONSUMER(p_SYSTEM_CODE IN VARCHAR2, p_COUNTRY_ID IN NUMBER, p_ENTERPRISE_CODE IN VARCHAR2, CONSUMER_ID OUT NUMBER) IS
    v_SYSTEM_ID NUMBER;
    v_ENTERPRISE_ID NUMBER;
  BEGIN
    GET_SYSTEM(p_SYSTEM_CODE, v_SYSTEM_ID);
    GET_ENTERPRISE(p_ENTERPRISE_CODE, v_ENTERPRISE_ID);
    
    SELECT C.ID INTO CONSUMER_ID FROM ESB_CONSUMER C INNER JOIN ESB_SYSTEM S ON C.SYSCODE = S.ID
      INNER JOIN ESB_ENTERPRISE E ON C.ENT_CODE = E.ID
      WHERE S.CODE = p_SYSTEM_CODE AND C.COUNTRY_ID = p_COUNTRY_ID AND E.CODE = p_ENTERPRISE_CODE;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO ESB_CONSUMER(ID, SYSCODE, COUNTRY_ID, ENT_CODE, RCD_STATUS) VALUES(ESB_CONSUMER_SEQ.NEXTVAL, v_SYSTEM_ID, p_COUNTRY_ID, v_ENTERPRISE_ID, 0) RETURNING "ID" INTO CONSUMER_ID;
  END GET_CONSUMER;
  
  PROCEDURE REGISTRY_CONVERSATION(p_TRANSACTION_ID IN NUMBER, p_CONVERSATION_ID IN VARCHAR2, p_CORRELATION_ID IN VARCHAR2, p_CHANNEL_ID IN NUMBER, p_CONSUMER_ID IN NUMBER, p_COUNTRY_ID IN NUMBER, p_SEQUENCE_CONV IN NUMBER, p_CAPABILITY_ID IN NUMBER, v_CONVERSATION_ID OUT NUMBER) IS
  BEGIN
    
    SELECT 
      ID INTO v_CONVERSATION_ID 
    FROM 
      ESB_CONVERSATION 
    WHERE 
      CONVERSATION_ID = p_CONVERSATION_ID;
    
    EXCEPTION
    
    WHEN NO_DATA_FOUND THEN
      
      INSERT INTO 
        ESB_CONVERSATION(
          ID, 
          MESSAGE_TX_ID,
          CAPABILITY_ID,
          CONVERSATION_ID, 
          CORRELATION_ID, 
          CHANNEL_ID, 
          CONSUMER_ID, 
          COUNTRY_ID, 
          SEQUENCE,
          RCD_STATUS) 
      VALUES (
          ESB_CONVERSATION_SEQ.NEXTVAL, 
          p_TRANSACTION_ID,
          p_CAPABILITY_ID,
          p_CONVERSATION_ID,
          p_CORRELATION_ID, 
          p_CHANNEL_ID, 
          p_CONSUMER_ID, 
          p_COUNTRY_ID, 
          p_SEQUENCE_CONV,
          1) 
      RETURNING "ID" INTO v_CONVERSATION_ID;
  END REGISTRY_CONVERSATION;
   
  PROCEDURE REGISTERTRACE(REGISTERTIME IN TIMESTAMP DEFAULT NULL, AUDITREQ IN AUDIT_T DEFAULT NULL, LOGREQ IN LOG_T DEFAULT NULL, ERRORREQ IN ERROR_T DEFAULT NULL, TRACE_ID OUT NUMBER) IS
    --new
    v_PROC_ID VARCHAR2(50);
    v_EVENT_ID VARCHAR2(50);
    v_CLIENT_REQ_TIMESTAMP VARCHAR2(50);
    --old
    v_SERVICE_OPERATION_ext VARCHAR2(100);
    v_SERVICE_CODE_ext VARCHAR2(100);
    v_SERVICE_NAME_ext VARCHAR2(100);
    v_CAPABILITY_ID NUMBER;
    v_COUNTRY_ID NUMBER;
    v_CHANNEL_NAME VARCHAR2(20);
    v_CHANNEL_ID NUMBER;
    v_SEQUENCE_CONV NUMBER;
    v_SEQUENCE_TRACE NUMBER;
    v_COUNTRY_CODE_ext VARCHAR2(100);
    v_CHANNEL_NAME_ext VARCHAR2(100);
    v_TRANSACTION_ID NUMBER;
    v_CONSUMER_ID NUMBER;
    v_CONSUMER_SYSCODE_ext VARCHAR2(30);
    v_CONSUMER_ENTCODE_ext VARCHAR2(50);
    v_CONVERSATION_ID_ext VARCHAR2(50);
    v_CONV_ID NUMBER;
    v_CORRELATION_ID_ext VARCHAR2(50);
    v_LOGGER_COMPONENT_ext VARCHAR2(100);
    v_LOGGER_OPERATION_ext VARCHAR2(100);
    v_REGISTERTIME_ext TIMESTAMP WITH TIME ZONE;
  v_LOG_PLACEHOLDER_ext VARCHAR2(100);
    
  BEGIN
    v_REGISTERTIME_ext := REGISTERTIME;
    
    ---------- This is a deprecated capability -------
    --IF (AUDITREQ IS NOT NULL) THEN
      
     -- v_PROC_ID := AUDITREQ.HEADERTRACER_.HEADER_.TRACE_.PROCESSID_;
     -- v_EVENT_ID := AUDITREQ.HEADERTRACER_.HEADER_.TRACE_.EVENTID_;
     -- v_CLIENT_REQ_TIMESTAMP := AUDITREQ.HEADERTRACER_.HEADER_.TRACE_.CLIENTREQTIMESTAMP_;
      
     -- v_SERVICE_OPERATION_ext := AUDITREQ.HEADERTRACER_.HEADER_.TRACE_.SERVICE_.OPERATION_;
     --   v_SERVICE_CODE_ext := AUDITREQ.HEADERTRACER_.HEADER_.TRACE_.SERVICE_.CODE_;
     --   v_SERVICE_NAME_ext := AUDITREQ.HEADERTRACER_.HEADER_.TRACE_.SERVICE_.NAME_;
     -- v_COUNTRY_CODE_ext := AUDITREQ.HEADERTRACER_.HEADER_.CONSUMER_.COUNTRYCODE_;
     -- v_CHANNEL_NAME_ext := AUDITREQ.HEADERTRACER_.HEADER_.CHANNEL_.NAME_;
     -- v_CONVERSATION_ID_ext := AUDITREQ.HEADERTRACER_.HEADER_.TRACE_.CONVERSATIONID_;
     -- v_CORRELATION_ID_ext := AUDITREQ.HEADERTRACER_.HEADER_.TRACE_.CORRELATIONID_;
      
     -- v_LOGGER_COMPONENT_ext := AUDITREQ.HEADERTRACER_.COMPONENT_;
     -- v_LOGGER_OPERATION_ext := AUDITREQ.HEADERTRACER_.OPERATION_;
     -- v_LOG_PLACEHOLDER_ext := AUDITREQ.AUDITPLACEHOLDER_.PLACE_;
      
    --  v_CONSUMER_SYSCODE_ext := AUDITREQ.HEADERTRACER_.HEADER_.CONSUMER_.SYSCODE_;
    --  v_CONSUMER_ENTCODE_ext := AUDITREQ.HEADERTRACER_.HEADER_.CONSUMER_.ENTERPRISECODE_;
     
    --ELSIF (LOGREQ IS NOT NULL) THEN
    
    IF (LOGREQ IS NOT NULL) THEN
    
      -------- Tx. Details ----------
      v_PROC_ID := LOGREQ.HEADERTRACER_.HEADER_.TRACE_.PROCESSID_;
      v_EVENT_ID := LOGREQ.HEADERTRACER_.HEADER_.TRACE_.EVENTID_;
      v_CLIENT_REQ_TIMESTAMP := LOGREQ.HEADERTRACER_.HEADER_.TRACE_.CLIENTREQTIMESTAMP_;
      
      -------- Log Trace Details ----------
      v_SERVICE_OPERATION_ext := LOGREQ.HEADERTRACER_.HEADER_.TRACE_.SERVICE_.OPERATION_;
      v_SERVICE_CODE_ext := LOGREQ.HEADERTRACER_.HEADER_.TRACE_.SERVICE_.CODE_;
      v_SERVICE_NAME_ext := LOGREQ.HEADERTRACER_.HEADER_.TRACE_.SERVICE_.NAME_;
      v_COUNTRY_CODE_ext := LOGREQ.HEADERTRACER_.HEADER_.CONSUMER_.COUNTRYCODE_;
      v_CHANNEL_NAME_ext := LOGREQ.HEADERTRACER_.HEADER_.CHANNEL_.NAME_;
      v_CONVERSATION_ID_ext := LOGREQ.HEADERTRACER_.HEADER_.TRACE_.CONVERSATIONID_;
      v_CORRELATION_ID_ext := LOGREQ.HEADERTRACER_.HEADER_.TRACE_.CORRELATIONID_;
      
      -------- Log Trace Details ----------
      v_LOGGER_COMPONENT_ext := LOGREQ.HEADERTRACER_.COMPONENT_;
      v_LOGGER_OPERATION_ext := LOGREQ.HEADERTRACER_.OPERATION_;
      
      v_LOG_PLACEHOLDER_ext := LOGREQ.LOGPLACEHOLDER_.PLACE_;
      v_REGISTERTIME_ext := TO_TIMESTAMP_TZ(LOGREQ.LOGPLACEHOLDER_.TIME_,'YYYY-MM-DD HH24:MI:SS:FF TZH:TZM');
      
      ---------- Consumer Details ----------
      v_CONSUMER_SYSCODE_ext := LOGREQ.HEADERTRACER_.HEADER_.CONSUMER_.SYSCODE_;
      v_CONSUMER_ENTCODE_ext := LOGREQ.HEADERTRACER_.HEADER_.CONSUMER_.ENTERPRISECODE_;
    
    ------------------- La Fecha informada de LOG es la fecha Informada de LOG. -------------------
      --IF (LOGREQ.LOGMODE_.LOGTYPE_ = 'SREQ') THEN
        --v_REGISTERTIME_ext := TO_TIMESTAMP_TZ(LOGREQ.HEADERTRACER_.HEADER_.TRACE_.REQTIMESTAMP_,'YYYY-MM-DD HH24:MI:SS TZH:TZM');
      --ELSIF (LOGREQ.LOGMODE_.LOGTYPE_ = 'SRSP') THEN
        --v_REGISTERTIME_ext := TO_TIMESTAMP_TZ(LOGREQ.HEADERTRACER_.HEADER_.TRACE_.RSPTIMESTAMP_,'YYYY-MM-DD HH24:MI:SS TZH:TZM');
    --ELSE
    --v_REGISTERTIME_ext := TO_TIMESTAMP_TZ(LOGREQ.LOGPLACEHOLDER_.TIME_,'YYYY-MM-DD HH24:MI:SS TZH:TZM');
      --END IF;
    -------------------------------------------------------------------------------------------------
    
    ELSIF (ERRORREQ IS NOT NULL) THEN
      
      -------- Tx. Details ----------
      v_PROC_ID := ERRORREQ.HEADERTRACER_.HEADER_.TRACE_.PROCESSID_;
      v_EVENT_ID := ERRORREQ.HEADERTRACER_.HEADER_.TRACE_.EVENTID_;
      v_CLIENT_REQ_TIMESTAMP := ERRORREQ.HEADERTRACER_.HEADER_.TRACE_.CLIENTREQTIMESTAMP_;
      
      -------- Log Trace Details ----------
      v_SERVICE_OPERATION_ext := ERRORREQ.HEADERTRACER_.HEADER_.TRACE_.SERVICE_.OPERATION_;
      v_SERVICE_CODE_ext := ERRORREQ.HEADERTRACER_.HEADER_.TRACE_.SERVICE_.CODE_;
      v_SERVICE_NAME_ext := ERRORREQ.HEADERTRACER_.HEADER_.TRACE_.SERVICE_.NAME_;
      v_COUNTRY_CODE_ext := ERRORREQ.HEADERTRACER_.HEADER_.CONSUMER_.COUNTRYCODE_;
      v_CHANNEL_NAME_ext := ERRORREQ.HEADERTRACER_.HEADER_.CHANNEL_.NAME_;
      v_CONVERSATION_ID_ext := ERRORREQ.HEADERTRACER_.HEADER_.TRACE_.CONVERSATIONID_;
      v_CORRELATION_ID_ext := ERRORREQ.HEADERTRACER_.HEADER_.TRACE_.CORRELATIONID_;
      
      -------- Logger Metadata ----------
      v_LOGGER_COMPONENT_ext := ERRORREQ.HEADERTRACER_.COMPONENT_;
      v_LOGGER_OPERATION_ext := ERRORREQ.HEADERTRACER_.OPERATION_;
      
      -------- Log Metadata ----------
      v_LOG_PLACEHOLDER_ext := ERRORREQ.ERRORPLACEHOLDER_.PLACE_;
      v_REGISTERTIME_ext := TO_TIMESTAMP_TZ(ERRORREQ.ERRORPLACEHOLDER_.TIME_,'YYYY-MM-DD HH24:MI:SS:FF TZH:TZM');
      
      ---------- Consumer Details ----------
      v_CONSUMER_SYSCODE_ext := ERRORREQ.HEADERTRACER_.HEADER_.CONSUMER_.SYSCODE_;
      v_CONSUMER_ENTCODE_ext := ERRORREQ.HEADERTRACER_.HEADER_.CONSUMER_.ENTERPRISECODE_;
    
    END IF;
  
    -- Retorna el CAPABILITY_ID segÃºn el ServiceName y ServiceOperation informado. Si no existe la capacidad configurada
    -- en el modelo del Framework, genera un registro "defacto" para no impedir el LOG solicitado.
    REGISTER_CAPABILITY(v_SERVICE_NAME_ext, v_SERVICE_OPERATION_ext, v_SERVICE_CODE_ext, v_CAPABILITY_ID);

    -- Este procedimiento retorna la Tx. asociada a los datos enviados por parametro v_PROC_ID y v_EVENT_ID.
    REGISTER_MESSAGE_TRANSACTION(v_CAPABILITY_ID, v_PROC_ID, v_EVENT_ID, v_CLIENT_REQ_TIMESTAMP,v_CORRELATION_ID_ext, v_TRANSACTION_ID);
    
    -- Estos 3 Procedimientos se aseguran de que exista un PaÃ­s, un Canal y un Consumidor configurados en el FW segÃºn los datos
    -- enviados. De no existir, se generan nuevos registros "defacto" para impedir el no-registro de traza segun sea solicitado.
    -- De suceder esto ultimo, dichos registros quedaran con RCD_STATUS = 0 (Invalido).
    GET_COUNTRY(v_COUNTRY_CODE_ext, v_COUNTRY_ID);
    GET_CHANNEL(v_CHANNEL_NAME_ext, v_CHANNEL_ID);
    GET_CONSUMER(v_CONSUMER_SYSCODE_ext, v_COUNTRY_ID, v_CONSUMER_ENTCODE_ext, v_CONSUMER_ID);
    
    -- Se obtienen as secuencias existentes para las tablas de ESB_CONVERSATION (1 registro x conversacion) Y ESB TRACE 
    -- (N registros por Conversacion, donde N es la cantidad de operaciones de log/error que se solicitaron al LoggerManager)
    -- Al no encontrar registro el count da "0", que en cada tabla significa (Secuencia 0) que es el primer registro.
    -- Este primer registro tiene connotaciones importantes para otros componentes que dependen de esta informacion, como el 
    -- ErrorHospital@ErrorManager.
    SELECT 
      COUNT(*) INTO v_SEQUENCE_CONV 
    FROM ESB_CONVERSATION C 
      INNER JOIN ESB_MESSAGE_TRANSACTION M
        ON M.ID = C.MESSAGE_TX_ID 
    WHERE M.ID = v_TRANSACTION_ID;
    
    SELECT 
      COUNT(T.ID) INTO v_SEQUENCE_TRACE 
    FROM ESB_TRACE T 
      INNER JOIN ESB_CONVERSATION C 
          ON T.CONV_ID = C.ID
    WHERE C.CONVERSATION_ID = v_CONVERSATION_ID_ext;

    -- Este procedimiento se asegura que exista un registro apropiado en la ESB_CONVERSATION. De existirlo se retorna el 
    -- ConversationID asociado en v_CONVERSATION_ID. De no exitirse, se genera un registro nuevo y se retorna su 
    -- v_CONVERSATION_ID asignado.
    REGISTRY_CONVERSATION(v_TRANSACTION_ID, v_CONVERSATION_ID_ext, v_CORRELATION_ID_ext, v_CHANNEL_ID, v_CONSUMER_ID, v_COUNTRY_ID, v_SEQUENCE_CONV, v_CAPABILITY_ID, v_CONV_ID);
    
    INSERT INTO 
      ESB_TRACE(
        ID, 
        CONV_ID, 
        SEQUENCE,
        COMPONENT, 
        OPERATION, 
        LOG_TIMESTAMP, 
        LOG_PLACEHOLDER, 
        RCD_STATUS) 
      VALUES (
        ESB_TRACE_SEQ.NEXTVAL,
        v_CONV_ID,
        v_SEQUENCE_TRACE,
        v_LOGGER_COMPONENT_ext,
        v_LOGGER_OPERATION_ext,
        v_REGISTERTIME_ext,
        v_LOG_PLACEHOLDER_ext,
        1
      )
      RETURNING ID INTO TRACE_ID
      ;
   
  END REGISTERTRACE;
  
  PROCEDURE GET_SEVERITY(p_LOGSEVERITY IN VARCHAR2, v_SEVERITY_ID OUT NUMBER) IS
  BEGIN
    SELECT ID INTO v_SEVERITY_ID FROM ESB_SEVERITY WHERE "LEVEL" = UPPER(p_LOGSEVERITY);
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO ESB_SEVERITY(ID, "LEVEL", DESCRIPTION, "ORDER", RCD_STATUS) VALUES(ESB_SEVERITY_SEQ.NEXTVAL, UPPER(p_LOGSEVERITY), 'Unknown Level', 100, 0) RETURNING "ID" INTO v_SEVERITY_ID;
  END GET_SEVERITY;

  PROCEDURE GET_LOGTYPE(p_LOGTYPE IN VARCHAR2, v_LOGTYPE_ID OUT NUMBER) IS
  BEGIN
    SELECT ID INTO v_LOGTYPE_ID FROM ESB_LOG_TYPE WHERE "NAME" = UPPER(p_LOGTYPE);
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
      INSERT INTO ESB_LOG_TYPE(ID, "NAME", DESCRIPTION, RCD_STATUS) VALUES(ESB_LOG_TYPE_SEQ.NEXTVAL, UPPER(p_LOGTYPE), 'Unknown Type', 0) RETURNING "ID" INTO v_LOGTYPE_ID;
  END GET_LOGTYPE;
  
  PROCEDURE LOG(LOGREQ IN LOG_T, REGISTERTIME IN TIMESTAMP DEFAULT NULL) IS
   v_SEVERITY_ID NUMBER;
   v_TYPE_ID NUMBER;
   v_TRACE_ID NUMBER;
   v_TRANSACTION_ID NUMBER;
  BEGIN
    IF (LOGREQ.LOGMODE_.LOGTYPE_ = 'LOG') THEN
      REGISTERTRACE(REGISTERTIME, NULL, LOGREQ, NULL, v_TRACE_ID);
    ELSE
      REGISTERTRACE(NULL, NULL, LOGREQ, NULL, v_TRACE_ID);
    END IF;
  
    GET_SEVERITY(LOGREQ.LOGMODE_.LOGSEVERITY_, v_SEVERITY_ID);
    GET_LOGTYPE(LOGREQ.LOGMODE_.LOGTYPE_, v_TYPE_ID);
  
    INSERT INTO ESB_LOG(
      ID, 
      TRACE_ID, 
      MESSAGE, TYPE_ID, 
      SEVERITY_ID, 
      DESCRIPTION
      ) 
    VALUES(
      ESB_LOG_SEQ.NEXTVAL, 
      v_TRACE_ID, 
      LOGREQ.MESSAGE_, 
      v_TYPE_ID,
      v_SEVERITY_ID , 
      LOGREQ.DESCRIPTION_
    );
      
    -----------------------------------------------------------------------------------------------------------------------
    -- Los siguientes statement tienen como proposito actualizar el estado de la transaccion en ESB_MESSAGE_TRANSACTION, 
    -- en casos donde la dupla Servicio+Capacidad no sea configurada para aplicar validaciones sobre sus mensajes por el 
    -- message manager. En estos casos, para optimizar el MessageManager, no se realizan tareas Sync para con las tablas
    -- de traza.
    --
    -- El LoggerManager esta preparado para este comportamiento y genera el registro en ESB_MESSAGE_TRANSACTION si no lo existe.
    --
    -- Ahora bien, para mantener la integridad de los registros existentes en dicha tabla, se debe tambien actualizar el estado
    -- cuando se informe la finalizacion de la Tx. la Tx. se considera finalizada para el cliente cuando la capacidad de 
    -- secuencia "0" retorna un mensaje. Dicha capacidad se considera comola "Owner" de la transaccion al ser la que representa
    -- su ejecucion desde el punto del vista del cliente.
    --
    -- Por ello lo primero que hacemos en verificar que la operacion solicitada al LoggerManager sea LOG, y el tipo sea SRSP, 
    -- indicando que se informa la respuesta de un Servicio (Capacidad). Luego verificamos si la capacidad que se esta tratando
    -- es la de sencuencia 0, y el estado de la Tx. sigue siendo "0" (Pending. De aqui asumimos la no participacion del 
    -- MessageManager).
    -----------------------------------------------------------------------------------------------------------------------

    IF (LOGREQ.LOGMODE_.LOGTYPE_ = 'SRSP') THEN
      BEGIN    
        
        SELECT 
          T.ID INTO v_TRANSACTION_ID
        FROM 
          ESB_CONVERSATION C 
          INNER JOIN ESB_MESSAGE_TRANSACTION T
            ON C.MESSAGE_TX_ID = T.ID
          INNER JOIN ESB_TRACE TR
            ON TR.CONV_ID = C.ID
        WHERE 
          TR.ID = v_TRACE_ID AND
          T.STATUS = '0' AND
          C.SEQUENCE='0';
        
        -- Si no salio por NO_DATA_FOUND, la capacidad es efectivamente la de secuencia 0, y la Tx. no fue actualizada por el 
        -- MessageManager.
        --
        -- Subsiguientemente, actualizamos el estado de la Tx. a "1" ~ Finalizada.
          
        UPDATE 
            ESB_MESSAGE_TRANSACTION T
        SET  
            T.STATUS = '1'
        WHERE
          T.ID = v_TRANSACTION_ID;
        
      EXCEPTION 
      
        WHEN NO_DATA_FOUND THEN
          RETURN;
      END;
    END IF;
    --------------------------------------------------
      
  END LOG;
  
  PROCEDURE GET_ERROR_STATUS(p_STATUS IN VARCHAR2, v_STATUS_ID OUT NUMBER) IS
  
  BEGIN
    SELECT 
      ID INTO v_STATUS_ID 
    FROM 
      ESB_ERROR_STATUS_TYPE 
    WHERE 
      "NAME" = UPPER(p_STATUS);
    
    IF(v_STATUS_ID IS NULL) THEN
      INSERT INTO ESB_ERROR_STATUS_TYPE(
        ID,
        "NAME",
        DESCRIPTION,
        RCD_STATUS) 
      VALUES(
        ESB_ERROR_STATUS_TYPE_SEQ.NEXTVAL,
        UPPER(p_STATUS),
        'Unknown Status Type',
        0
        ) 
      RETURNING "ID" INTO v_STATUS_ID;
    END IF;
    
    
  END GET_ERROR_STATUS;
  
  PROCEDURE ERROR(ERRORREQ IN ERROR_T, REGISTERTIME IN TIMESTAMP) IS
   v_STATUS_ID NUMBER;
   v_ERROR_CANONICAL_ID NUMBER;
   v_TRACE_ID NUMBER;
   v_TRANSACTION_ID NUMBER;
  BEGIN
    REGISTERTRACE(REGISTERTIME, NULL, NULL, ERRORREQ, v_TRACE_ID);
    GET_ERROR_STATUS(ERRORREQ.RESULT_.STATUS_, v_STATUS_ID);

    BEGIN
    SELECT 
      C.ID INTO v_ERROR_CANONICAL_ID 
    FROM ESB_CANONICAL_ERROR C 
      INNER JOIN ESB_CANONICAL_ERROR_TYPE CT 
        ON C.TYPE_ID = CT.ID 
    WHERE 
      C."CODE" = ERRORREQ.RESULT_.CANONICALERROR_.CODE_ AND
      CT."TYPE" = ERRORREQ.RESULT_.CANONICALERROR_.TYPE_;
    
    EXCEPTION
    
    WHEN NO_DATA_FOUND THEN
    
    SELECT 
      C.ID INTO v_ERROR_CANONICAL_ID 
    FROM ESB_CANONICAL_ERROR C 
    INNER JOIN 
      ESB_CANONICAL_ERROR_TYPE CT 
        ON C.TYPE_ID = CT.ID 
    WHERE 
      C."CODE" = '50006' AND 
      CT."TYPE" = 'FWCF';
    END;
    
    INSERT INTO ESB_ERROR(
      ID, 
      TRACE_ID, 
      STATUS_ID, 
      DESCRIPTION, 
      CAN_ERR_ID, 
      RAW_FAULT, 
      RAW_CODE, 
      RAW_DESCRIPTION, 
      ERROR_SOURCE, 
      ERROR_SOURCE_DETAILS, 
      MODULE, 
      SUB_MODULE, 
      RCD_STATUS
    )
      
      VALUES(
            ESB_ERROR_SEQ.NEXTVAL, 
            v_TRACE_ID, 
            v_STATUS_ID, 
            ERRORREQ.RESULT_.DESCRIPTION_, 
            v_ERROR_CANONICAL_ID, 
            ERRORREQ.RESULT_.SOURCEERROR_.SOURCEFAULT_, 
            ERRORREQ.RESULT_.SOURCEERROR_.CODE_, 
            ERRORREQ.RESULT_.SOURCEERROR_.DESCRIPTION_, 
            (SELECT ID FROM ESB_SYSTEM WHERE CODE = ERRORREQ.RESULT_.SOURCEERROR_.ERRORSOURCEDETAILS_.SOURCE_ AND ROWNUM=1), 
            ERRORREQ.RESULT_.SOURCEERROR_.ERRORSOURCEDETAILS_.DETAILS,
            ERRORREQ.ERRORINDEX_.MODULE_, 
            ERRORREQ.ERRORINDEX_.SUBMODULE_, 
            1
    );
  END ERROR;  
END ESB_LOGGERMANAGER_PKG;