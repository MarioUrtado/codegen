--------------------------------------------------------
--  DDL for Package ESB_CORRELATIONMANAGER_PKG
--------------------------------------------------------
 CREATE OR REPLACE PACKAGE "ESB_CORRELATIONMANAGER_PKG" AS 
    PROCEDURE REGISTER (GROUP_NAME IN VARCHAR2, GROUP_DESC IN VARCHAR2, GROUP_HEADER IN CLOB, MEMBER_TYPES IN MEMBER_T_CUR, ID_GROUP OUT NUMBER,p_SOURCE_ERROR_DESC OUT VARCHAR2, p_SOURCE_ERROR_CODE OUT VARCHAR2);
 	PROCEDURE GET (GROUP_NAME IN VARCHAR2, MEMBER_TYPES IN MEMBER_T , CORRELATION_MESSAGE OUT SYS_REFCURSOR,p_SOURCE_ERROR_DESC OUT VARCHAR2, p_SOURCE_ERROR_CODE OUT VARCHAR2);
 END ESB_CORRELATIONMANAGER_PKG;
/

