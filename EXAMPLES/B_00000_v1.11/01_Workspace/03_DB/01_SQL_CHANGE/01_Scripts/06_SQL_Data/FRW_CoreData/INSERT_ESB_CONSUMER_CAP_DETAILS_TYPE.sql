SET ECHO ON
SET DEFINE OFF
SET SERVEROUTPUT ON
WHENEVER SQLERROR CONTINUE ROLLBACK
DECLARE
BEGIN
BEGIN
Insert into ESB_CONSUMER_CAP_DETAILS_TYPE (ID,NAME,DESCRIPTION) values (ESB_CONS_CAP_DETAILS_TYPE_SEQ.NEXTVAL,'TRANSPORT','Consumer Callback TRANSPORT');
END;
BEGIN
Insert into ESB_CONSUMER_CAP_DETAILS_TYPE (ID,NAME,DESCRIPTION) values (ESB_CONS_CAP_DETAILS_TYPE_SEQ.NEXTVAL,'CALLBACK_URL','Consumer Callback URI');
END;
END;
/
COMMIT;