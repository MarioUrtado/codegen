SET ECHO ONSET DEFINE OFFSET SERVEROUTPUT ONWHENEVER SQLERROR CONTINUE ROLLBACKDECLAREvRes NUMBER;BEGIN	BEGIN			INSERT INTO ESB_CANONICAL_ERROR (ID,CODE,TYPE_ID,DESCRIPTION,PRIORITY,RCD_STATUS) VALUES (ESB_CANONICAL_ERROR_SEQ.NEXTVAL,'160',( SELECT ID FROM ESB_CANONICAL_ERROR_TYPE WHERE TYPE = 'NEG'),'Transaccion Fuera de Horario','1','1');	END;	
	BEGIN			INSERT INTO ESB_CANONICAL_ERROR (ID,CODE,TYPE_ID,DESCRIPTION,PRIORITY,RCD_STATUS) VALUES (ESB_CANONICAL_ERROR_SEQ.NEXTVAL,'161',( SELECT ID FROM ESB_CANONICAL_ERROR_TYPE WHERE TYPE = 'NEG'),'La Transaccion se encuentra Fuera de Horario.','1','1');	END;
	BEGIN			INSERT INTO ESB_CANONICAL_ERROR (ID,CODE,TYPE_ID,DESCRIPTION,PRIORITY,RCD_STATUS) VALUES (ESB_CANONICAL_ERROR_SEQ.NEXTVAL,'90000',( SELECT ID FROM ESB_CANONICAL_ERROR_TYPE WHERE TYPE = 'NEG'),'No se ha encontrado el ConsumerID reportado.','1','1');	END;		BEGIN			INSERT INTO ESB_CANONICAL_ERROR (ID,CODE,TYPE_ID,DESCRIPTION,PRIORITY,RCD_STATUS) VALUES (ESB_CANONICAL_ERROR_SEQ.NEXTVAL,'350',( SELECT ID FROM ESB_CANONICAL_ERROR_TYPE WHERE TYPE = 'NEG'),'Error generico encontrado ejecutando capacidades del legado SALESFORCE','1','1');	END;		BEGIN			INSERT INTO ESB_CANONICAL_ERROR (ID,CODE,TYPE_ID,DESCRIPTION,PRIORITY,RCD_STATUS) VALUES (ESB_CANONICAL_ERROR_SEQ.NEXTVAL,'351',( SELECT ID FROM ESB_CANONICAL_ERROR_TYPE WHERE TYPE = 'NEG'),'Error generico encontrado ejecutando capacidades del legado AS400','1','1');	END;	END;/COMMIT;
