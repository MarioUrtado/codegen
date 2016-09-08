SET ECHO ON
SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR CONTINUE ROLLBACK

DECLARE

BEGIN

	BEGIN
		DELETE FROM ESB_ERROR_MAPPING WHERE ERROR_SOURCE = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW') AND
																													MODULE = 'MessageManager' AND
																													SUB_MODULE = 'checkIN' AND
																													RAW_CODE = '10' AND
																													RAW_DESCRIPTION = 'Transaction ONGOING' AND
																													CAN_ERR_ID = ( SELECT ID FROM ESB_CANONICAL_ERROR WHERE CODE = '10001' AND TYPE_ID = (SELECT ID FROM ESB_CANONICAL_ERROR_TYPE WHERE TYPE = 'FWNE')) AND
																													STATUS_ID = ( SELECT ID FROM ESB_ERROR_STATUS_TYPE WHERE NAME = 'ERROR') AND
																													RCD_STATUS = '1';
	END;
		
	BEGIN
		DELETE FROM ESB_ERROR_MAPPING WHERE ERROR_SOURCE = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW') AND
																													MODULE = 'MessageManager' AND
																													SUB_MODULE = 'checkIN' AND
																													RAW_CODE = '25' AND
																													RAW_DESCRIPTION = 'Duplicate Message' AND
																													CAN_ERR_ID = ( SELECT ID FROM ESB_CANONICAL_ERROR WHERE CODE = '10005' AND TYPE_ID = (SELECT ID FROM ESB_CANONICAL_ERROR_TYPE WHERE TYPE = 'FWNE')) AND
																													STATUS_ID = ( SELECT ID FROM ESB_ERROR_STATUS_TYPE WHERE NAME = 'ERROR') AND
																													RCD_STATUS = '1';
	END;	
		
	BEGIN
		DELETE FROM ESB_ERROR_MAPPING WHERE ERROR_SOURCE = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW') AND
																													MODULE = 'MessageManager' AND
																													SUB_MODULE = 'checkIN' AND
																													RAW_CODE = '15' AND
																													RAW_DESCRIPTION = 'Transaction IDEMPOTENT' AND
																													CAN_ERR_ID = ( SELECT ID FROM ESB_CANONICAL_ERROR WHERE CODE = '10002' AND TYPE_ID = (SELECT ID FROM ESB_CANONICAL_ERROR_TYPE WHERE TYPE = 'FWNE')) AND
																													STATUS_ID = ( SELECT ID FROM ESB_ERROR_STATUS_TYPE WHERE NAME = 'ERROR') AND
																													RCD_STATUS = '1';
	END;	
		
	BEGIN
		DELETE FROM ESB_ERROR_MAPPING WHERE ERROR_SOURCE = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW') AND
																													MODULE = 'MessageManager' AND
																													SUB_MODULE = 'checkIN' AND
																													RAW_CODE = '21' AND
																													RAW_DESCRIPTION = 'Duplicate Message - Result is an OK' AND
																													CAN_ERR_ID = ( SELECT ID FROM ESB_CANONICAL_ERROR WHERE CODE = '10004' AND TYPE_ID = (SELECT ID FROM ESB_CANONICAL_ERROR_TYPE WHERE TYPE = 'FWNE')) AND
																													STATUS_ID = ( SELECT ID FROM ESB_ERROR_STATUS_TYPE WHERE NAME = 'ERROR') AND
																													RCD_STATUS = '1';
	END;	
		
	BEGIN
		DELETE FROM ESB_ERROR_MAPPING WHERE ERROR_SOURCE = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW') AND
																													MODULE = 'MessageManager' AND
																													SUB_MODULE = 'checkIN' AND
																													RAW_CODE = '20' AND
																													RAW_DESCRIPTION = 'Duplicate Message - Result is an ERROR' AND
																													CAN_ERR_ID = ( SELECT ID FROM ESB_CANONICAL_ERROR WHERE CODE = '10003' AND TYPE_ID = (SELECT ID FROM ESB_CANONICAL_ERROR_TYPE WHERE TYPE = 'FWNE')) AND
																													STATUS_ID = ( SELECT ID FROM ESB_ERROR_STATUS_TYPE WHERE NAME = 'ERROR') AND
																													RCD_STATUS = '1';
	END;

	BEGIN
		DELETE FROM ESB_ERROR_MAPPING WHERE ERROR_SOURCE = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW') AND
																													MODULE = 'PIF' AND
																													SUB_MODULE = 'UnsupportedOperation' AND
																													RAW_CODE = '99' AND
																													CAN_ERR_ID = ( SELECT ID FROM ESB_CANONICAL_ERROR WHERE CODE = '10007' AND TYPE_ID = (SELECT ID FROM ESB_CANONICAL_ERROR_TYPE WHERE TYPE = 'FWNE') AND DESCRIPTION = 'La operacion solicitada no se encuentra disponible para este servicio, segun el Consumer informado en el Header') AND
																													STATUS_ID = ( SELECT ID FROM ESB_ERROR_STATUS_TYPE WHERE NAME = 'ERROR') AND
																													RCD_STATUS = '1';
	END;

	BEGIN
		DELETE FROM ESB_ERROR_MAPPING WHERE ERROR_SOURCE = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW') AND
																													MODULE = 'ConversationManager' AND
																													SUB_MODULE = 'getInfo' AND
																													RAW_CODE = '-1' AND
																													CAN_ERR_ID = ( SELECT ID FROM ESB_CANONICAL_ERROR WHERE CODE = '10014' AND TYPE_ID = (SELECT ID FROM ESB_CANONICAL_ERROR_TYPE WHERE TYPE = 'FWNE') AND DESCRIPTION = 'No se encontraron datos para la Conversacion enviada por parametro') AND
																													STATUS_ID = ( SELECT ID FROM ESB_ERROR_STATUS_TYPE WHERE NAME = 'ERROR') AND
																													RCD_STATUS = '1';
	END;

	BEGIN
		DELETE FROM ESB_ERROR_MAPPING WHERE ERROR_SOURCE = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW') AND
																													MODULE = 'ConversationManager' AND
																													SUB_MODULE = 'getInfo' AND
																													RAW_CODE = '-2' AND
																													CAN_ERR_ID = ( SELECT ID FROM ESB_CANONICAL_ERROR WHERE CODE = '50007' AND TYPE_ID = (SELECT ID FROM ESB_CANONICAL_ERROR_TYPE WHERE TYPE = 'FWCF') AND DESCRIPTION = 'El tipo de a Conversacion no se corresponde con ningun tipo de Transaction Owner definido') AND
																													STATUS_ID = ( SELECT ID FROM ESB_ERROR_STATUS_TYPE WHERE NAME = 'ERROR') AND
																													RCD_STATUS = '1';
	END;

	BEGIN
		DELETE FROM ESB_ERROR_MAPPING WHERE ERROR_SOURCE = ( SELECT ID FROM ESB_SYSTEM WHERE CODE = 'FRW') AND
																													MODULE = 'ConversationManager' AND
																													SUB_MODULE = 'getInfo' AND
																													RAW_CODE = '-3' AND
																													CAN_ERR_ID = ( SELECT ID FROM ESB_CANONICAL_ERROR WHERE CODE = '50008' AND TYPE_ID = (SELECT ID FROM ESB_CANONICAL_ERROR_TYPE WHERE TYPE = 'FWCF') AND DESCRIPTION = 'La Transacción asociada no se corresponde con ningun tipo de Transaction Instance definido') AND
																													STATUS_ID = ( SELECT ID FROM ESB_ERROR_STATUS_TYPE WHERE NAME = 'ERROR') AND
																													RCD_STATUS = '1';
	END;
END;
/

COMMIT;
