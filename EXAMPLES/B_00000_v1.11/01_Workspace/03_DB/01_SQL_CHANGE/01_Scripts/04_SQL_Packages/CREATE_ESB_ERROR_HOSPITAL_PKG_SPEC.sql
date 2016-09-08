create or replace PACKAGE "ESB_ERROR_HOSPITAL_PKG" AS 
  PROCEDURE SP_GET_THERAPY (P_CAPABILITY_ID IN NUMBER , CANONICAL_ERROR_CODE IN NUMBER , CANONICAL_ERROR_TYPE IN NUMBER, THERAPY_ID OUT VARCHAR2 );
  PROCEDURE SP_ERROR_HOSPITAL (P_MESSAGE_TX_ID IN NUMBER ,  P_CAN_ERR_ID IN NUMBER ,  P_CAPABILITY_ID IN NUMBER ,P_SOURCE_ERROR_CODE OUT NUMBER );
  PROCEDURE SP_ERROR_DERIVATION(P_SOURCE_ERROR_CODE OUT NUMBER);
  PROCEDURE SP_ERROR_DISPATCHER_SET_STATE ( P_ID_DISPATCHER IN NUMBER ,P_STATUS IN VARCHAR2,P_DESCRIPTION IN VARCHAR2, p_SOURCE_ERROR_DESC OUT VARCHAR2, p_SOURCE_ERROR_CODE OUT VARCHAR2);
  PROCEDURE SP_ERROR_HOSPITAL_GET_MAIL (  P_ERROR_TRATEMENT_ID IN NUMBER , MAIL_TO OUT VARCHAR2 , MAIL_SUBJET OUT VARCHAR2 , MAIL_BODY OUT CLOB , p_SOURCE_ERROR_CODE OUT VARCHAR2 );
  PROCEDURE SP_ERROR_HOSPITAL_ADMISSION( P_PRIORITY IN NUMBER ,P_COUNT IN NUMBER);
END ESB_ERROR_HOSPITAL_PKG;