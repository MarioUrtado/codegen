create or replace TRIGGER ESB_ERROR_CONV_STATUS AFTER
  UPDATE OF STATUS ON ESB_CONVERSATION_STATUS REFERENCING NEW AS NewRow OLD AS NewOld FOR EACH ROW 
  DECLARE 
  V_MESSAGE_TX_ID VARCHAR2(200);
  V_CAPABILITY_ID NUMBER;
  V_TRANSACTION_CHECK_ID NUMBER;
  BEGIN
    IF ( :NewRow.STATUS = 'ERROR' ) THEN
      --Procesamiento NORMAL de un ERROR, Si una conversacion de SEQUENCE = 0 termina en este estado
      --Es insertada en ESB_ERROR_CONVERSATION que da inicio a su procesamiento por parte del ErrorHospital
      SELECT MESSAGE_TX_ID,
        CAPABILITY_ID
      INTO V_MESSAGE_TX_ID,
        V_CAPABILITY_ID
      FROM ESB_CONVERSATION
      WHERE CONVERSATION_ID  = :NewRow.CONVERSATION_ID
      AND SEQUENCE           = 0;
      IF (V_MESSAGE_TX_ID <> 0)THEN
        INSERT
        INTO ESB_ERROR_CONVERSATION
          (
            ID,
            MESSAGE_TX_ID,
            CAPABILITY_ID ,
            CAN_ERR_ID ,
            STATUS
          )
          VALUES
          (
            ESB_ERROR_CONVERSATION_SEQ.NEXTVAL ,
            V_MESSAGE_TX_ID,
            V_CAPABILITY_ID,
            :NewRow.CAN_ERR_ID,
            'UNREAD'
          );
      END IF;
    ELSE IF ( :NewRow.STATUS = 'OK' ) THEN
        BEGIN
            --En caso de que la conversacion cno sequence = 0 no haya terminado en ERROR (OK)
            --Se evalua si esta pertenece a un reintento, para notificar al RetryManager
            --Para que esta entre de igual manera alErrorManager, y llegue al RetryManager para que esta sea evaluada.
            SELECT ESB_TRANSACTION_CHECK.ID INTO V_TRANSACTION_CHECK_ID
            FROM ESB_TRANSACTION_CHECK
            WHERE ESB_TRANSACTION_CHECK.CONVERSATION_ID = :NewRow.CONVERSATION_ID AND
                  ESB_TRANSACTION_CHECK.MESSAGE_TX_ID = ( SELECT ID FROM ESB_MESSAGE_TRANSACTION
                                                          WHERE ESB_MESSAGE_TRANSACTION.CORRELATION_ID IS NOT NULL AND 
                                                          ESB_TRANSACTION_CHECK.MESSAGE_TX_ID = ESB_MESSAGE_TRANSACTION.ID AND 
                                                          SUBSTR(ESB_MESSAGE_TRANSACTION.CORRELATION_ID , 1 , 3) = '|RT' AND 
                                                          SUBSTR(ESB_MESSAGE_TRANSACTION.CORRELATION_ID , 5 , 1) = '@'
                  );
            INSERT INTO ESB_RETRY_NOTIFICATION( ID, TRANSACTION_CHECK_ID) 
            VALUES (ESB_RETRY_NOTIFICATION_SEQ.NEXTVAL, V_TRANSACTION_CHECK_ID);

            END;
        END IF;
    END IF;
  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN;
END;