SET ECHO ONSET DEFINE OFFSET SERVEROUTPUT ONWHENEVER SQLERROR CONTINUE ROLLBACKDECLAREvRes NUMBER;BEGIN	BEGIN			INSERT INTO ESB_CDM_ENTITY (ID,NAME,MAJ_VERSION,DESCRIPTION,RCD_STATUS) VALUES (ESB_CDM_ENTITY_SEQ.NEXTVAL,'Client','1','Client','1');	END;		BEGIN		INSERT INTO ESB_CDM_ENTITY (ID,NAME,MAJ_VERSION,DESCRIPTION,RCD_STATUS) VALUES (ESB_CDM_ENTITY_SEQ.NEXTVAL,'CanonicalError','1','CanonicalError','1');	END;END;/COMMIT;