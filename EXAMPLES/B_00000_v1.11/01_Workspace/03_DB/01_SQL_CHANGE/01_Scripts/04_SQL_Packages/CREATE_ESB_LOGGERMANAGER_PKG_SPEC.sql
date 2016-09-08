--------------------------------------------------------
--  DDL for Package LOGGERMANAGER_PKG
--------------------------------------------------------
create or replace 
PACKAGE ESB_LOGGERMANAGER_PKG AS 
  PROCEDURE LOG(LOGREQ IN LOG_T, REGISTERTIME IN TIMESTAMP DEFAULT NULL);
  PROCEDURE ERROR(ERRORREQ IN ERROR_T, REGISTERTIME IN TIMESTAMP);
END ESB_LOGGERMANAGER_PKG;

/