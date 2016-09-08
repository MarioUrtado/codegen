create or replace 
trigger ESB_ERROR_CONV_STATUS 
  AFTER 
  UPDATE OF STATUS ON ESB_CONVERSATION_STATUS
  REFERENCING NEW AS NewRow OLD AS NewOld
  FOR EACH ROW
DECLARE 
  VAR_MESSAGE_TX_ID VARCHAR2(200);
  VAR_CAPTALITY VARCHAR2(200);
  MODE_DEBUG BOOLEAN ;
BEGIN
      MODE_DEBUG := FALSE;
    IF ( :NewRow.STATUS = 'ERROR' ) THEN
        
        SELECT MESSAGE_TX_ID,CAPABILITY_ID INTO VAR_MESSAGE_TX_ID, VAR_CAPTALITY  FROM ESB_CONVERSATION WHERE CONVERSATION_ID = :NewRow.CONVERSATION_ID AND SEQUENCE = 0;

        IF (VAR_MESSAGE_TX_ID <> 0)THEN
          INSERT INTO ESB_ERROR_CONVERSATION( ID, MESSAGE_TX_ID,CAPABILITY_ID ,CAN_ERR_ID , STATUS ) VALUES(  ESB_ERROR_CONVERSATION_SEQ.NEXTVAL ,VAR_MESSAGE_TX_ID,  VAR_CAPTALITY, :NewRow.CAN_ERR_ID, 'UNREAD' );
        END IF;

    END IF;    
    
    EXCEPTION 
      WHEN NO_DATA_FOUND THEN 
        RETURN;
END;