SET ECHO ON
SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR CONTINUE ROLLBACK

DECLARE

BEGIN

	BEGIN
		INSERT INTO ESB_ERROR_MAPPING(ID,ERROR_SOURCE,MODULE,SUB_MODULE,RAW_CODE,RAW_DESCRIPTION,CAN_ERR_ID,STATUS_ID,RCD_STATUS) values ( ESB_ERROR_MAPPING_SEQ.NEXTVAL,
																													( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW'),
																													'MessageManager', 
																													'checkIN',
																													'10',
																													'Transaction ONGOING',
																													( SELECT ID FROM ESB_CANONICAL_ERROR WHERE CODE = '10001' AND TYPE_ID = (SELECT ID FROM ESB_CANONICAL_ERROR_TYPE WHERE TYPE = 'FWNE')),
																													( SELECT ID FROM ESB_ERROR_STATUS_TYPE WHERE NAME = 'ERROR'),
																													'1');
	END;
		
	BEGIN
		INSERT INTO ESB_ERROR_MAPPING(ID,ERROR_SOURCE,MODULE,SUB_MODULE,RAW_CODE,RAW_DESCRIPTION,CAN_ERR_ID,STATUS_ID,RCD_STATUS) values ( ESB_ERROR_MAPPING_SEQ.NEXTVAL,
																													( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW'),
																													'MessageManager', 
																													'checkIN',
																													'25',
																													'Duplicate Message',
																													( SELECT ID FROM ESB_CANONICAL_ERROR WHERE CODE = '10005' AND TYPE_ID = (SELECT ID FROM ESB_CANONICAL_ERROR_TYPE WHERE TYPE = 'FWNE')),
																													( SELECT ID FROM ESB_ERROR_STATUS_TYPE WHERE NAME = 'ERROR'),
																													'1');
	END;	
		
	BEGIN	
		INSERT INTO ESB_ERROR_MAPPING(ID,ERROR_SOURCE,MODULE,SUB_MODULE,RAW_CODE,RAW_DESCRIPTION,CAN_ERR_ID,STATUS_ID,RCD_STATUS) values ( ESB_ERROR_MAPPING_SEQ.NEXTVAL,
																													( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW'),
																													'MessageManager', 
																													'checkIN',
																													'15',
																													'Transaction IDEMPOTENT',
																													( SELECT ID FROM ESB_CANONICAL_ERROR WHERE CODE = '10002' AND TYPE_ID = (SELECT ID FROM ESB_CANONICAL_ERROR_TYPE WHERE TYPE = 'FWNE')),
																													( SELECT ID FROM ESB_ERROR_STATUS_TYPE WHERE NAME = 'ERROR'),
																													'1');
	END;	
		
	BEGIN
		INSERT INTO ESB_ERROR_MAPPING(ID,ERROR_SOURCE,MODULE,SUB_MODULE,RAW_CODE,RAW_DESCRIPTION,CAN_ERR_ID,STATUS_ID,RCD_STATUS) values ( ESB_ERROR_MAPPING_SEQ.NEXTVAL,
																													( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW'),
																													'MessageManager', 
																													'checkIN',
																													'21',
																													'Duplicate Message - Result is an OK',
																													( SELECT ID FROM ESB_CANONICAL_ERROR WHERE CODE = '10004' AND TYPE_ID = (SELECT ID FROM ESB_CANONICAL_ERROR_TYPE WHERE TYPE = 'FWNE')),
																													( SELECT ID FROM ESB_ERROR_STATUS_TYPE WHERE NAME = 'ERROR'),
																													'1');
	END;	
		
	BEGIN	
		INSERT INTO ESB_ERROR_MAPPING(ID,ERROR_SOURCE,MODULE,SUB_MODULE,RAW_CODE,RAW_DESCRIPTION,CAN_ERR_ID,STATUS_ID,RCD_STATUS) values ( ESB_ERROR_MAPPING_SEQ.NEXTVAL,
																													( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW'),
																													'MessageManager', 
																													'checkIN',
																													'20',
																													'Duplicate Message - Result is an ERROR',
																													( SELECT ID FROM ESB_CANONICAL_ERROR WHERE CODE = '10003' AND TYPE_ID = (SELECT ID FROM ESB_CANONICAL_ERROR_TYPE WHERE TYPE = 'FWNE')),
																													( SELECT ID FROM ESB_ERROR_STATUS_TYPE WHERE NAME = 'ERROR'),
																													'1');
	END;

	BEGIN	
		INSERT INTO ESB_ERROR_MAPPING(ID,ERROR_SOURCE,MODULE,SUB_MODULE,RAW_CODE,RAW_DESCRIPTION,CAN_ERR_ID,STATUS_ID,RCD_STATUS) values ( ESB_ERROR_MAPPING_SEQ.NEXTVAL,
																													( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW'),
																													'PIF', 
																													'UnsupportedOperation',
																													'99',
																													'La operacion solicitada no se encuentra disponible para este servicio, segun el Consumer informado en el Header',
																													( SELECT ID FROM ESB_CANONICAL_ERROR WHERE CODE = '10007' AND TYPE_ID = (SELECT ID FROM ESB_CANONICAL_ERROR_TYPE WHERE TYPE = 'FWNE') AND DESCRIPTION = 'La operacion solicitada no se encuentra disponible para este servicio, segun el Consumer informado en el Header'),
																													( SELECT ID FROM ESB_ERROR_STATUS_TYPE WHERE NAME = 'ERROR'),
																													'1');
	END;

	BEGIN	
		INSERT INTO ESB_ERROR_MAPPING(ID,ERROR_SOURCE,MODULE,SUB_MODULE,RAW_CODE,RAW_DESCRIPTION,CAN_ERR_ID,STATUS_ID,RCD_STATUS) values ( ESB_ERROR_MAPPING_SEQ.NEXTVAL,
																													( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW'),
																													'MessageManager', 
																													'checkIN',
																													'100',
																													'Mensaje no soportado',
																													( SELECT ID FROM ESB_CANONICAL_ERROR WHERE CODE = '10013' AND TYPE_ID = (SELECT ID FROM ESB_CANONICAL_ERROR_TYPE WHERE TYPE = 'FWNE') AND DESCRIPTION = 'Unsupported Message'),
																													( SELECT ID FROM ESB_ERROR_STATUS_TYPE WHERE NAME = 'ERROR'),
																													'1');
	END;

	BEGIN	
		INSERT INTO ESB_ERROR_MAPPING(ID,ERROR_SOURCE,MODULE,SUB_MODULE,RAW_CODE,RAW_DESCRIPTION,CAN_ERR_ID,STATUS_ID,RCD_STATUS) values ( ESB_ERROR_MAPPING_SEQ.NEXTVAL,
																													( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW'),
																													'ConversationManager', 
																													'getInfo',
																													'-1',
																													'No se encontraron datos para la Conversacion enviada por parametro',
																													( SELECT ID FROM ESB_CANONICAL_ERROR WHERE CODE = '10014' AND TYPE_ID = (SELECT ID FROM ESB_CANONICAL_ERROR_TYPE WHERE TYPE = 'FWNE') AND DESCRIPTION = 'No se encontraron datos para la Conversacion enviada por parametro'),
																													( SELECT ID FROM ESB_ERROR_STATUS_TYPE WHERE NAME = 'ERROR'),
																													'1');
	END;

	BEGIN	
		INSERT INTO ESB_ERROR_MAPPING(ID,ERROR_SOURCE,MODULE,SUB_MODULE,RAW_CODE,RAW_DESCRIPTION,CAN_ERR_ID,STATUS_ID,RCD_STATUS) values ( ESB_ERROR_MAPPING_SEQ.NEXTVAL,
																													( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW'),
																													'ConversationManager', 
																													'getInfo',
																													'-2',
																													'El tipo de a Conversacion no se corresponde con ningun tipo de Transaction Owner definido',
																													( SELECT ID FROM ESB_CANONICAL_ERROR WHERE CODE = '50007' AND TYPE_ID = (SELECT ID FROM ESB_CANONICAL_ERROR_TYPE WHERE TYPE = 'FWCF') AND DESCRIPTION = 'El tipo de a Conversacion no se corresponde con ningun tipo de Transaction Owner definido'),
																													( SELECT ID FROM ESB_ERROR_STATUS_TYPE WHERE NAME = 'ERROR'),
																													'1');
	END;

	BEGIN	
		INSERT INTO ESB_ERROR_MAPPING(ID,ERROR_SOURCE,MODULE,SUB_MODULE,RAW_CODE,RAW_DESCRIPTION,CAN_ERR_ID,STATUS_ID,RCD_STATUS) values ( ESB_ERROR_MAPPING_SEQ.NEXTVAL,
																													( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW'),
																													'ConversationManager', 
																													'getInfo',
																													'-3',
																													'La Transacción asociada no se corresponde con ningun tipo de Transaction Instance definido',
																													( SELECT ID FROM ESB_CANONICAL_ERROR WHERE CODE = '50008' AND TYPE_ID = (SELECT ID FROM ESB_CANONICAL_ERROR_TYPE WHERE TYPE = 'FWCF') AND DESCRIPTION = 'La Transacción asociada no se corresponde con ningun tipo de Transaction Instance definido'),
																													( SELECT ID FROM ESB_ERROR_STATUS_TYPE WHERE NAME = 'ERROR'),
																													'1');
	END;

END;
/

COMMIT;
