--------------------------------------------------------
--  DDL for Package ESB_PARAMETERMANAGER_PKG
--------------------------------------------------------
  CREATE OR REPLACE PACKAGE "ESB_PARAMETERMANAGER_PKG" AS
  PROCEDURE get(p_Keys IN KEYS_T, p_KeyValues OUT sys_refcursor, p_SourceError OUT SOURCERROR_T); 
  PROCEDURE getMapping(p_MapInput IN MAPS_IN_T, p_MapOutput OUT sys_refcursor, p_SourceError OUT SOURCERROR_T);
  PROCEDURE getConfig(p_ConfigName IN VARCHAR2, p_Config OUT sys_refcursor, p_SourceError OUT SOURCERROR_T);
  PROCEDURE getEndpoint(p_Target IN OUT TARGET_T, p_Endpoint OUT sys_refcursor, p_EndpType OUT VARCHAR2, p_EndpInstance OUT VARCHAR2, p_SourceError OUT SOURCERROR_T);
END ESB_PARAMETERMANAGER_PKG;

/