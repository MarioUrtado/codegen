create or replace 
PACKAGE ESB_ERROR_MANAGER_PKG
AS

/* ================== MAIN PROCEDURE ================== */
  PROCEDURE getCanonicalError(
      p_MODULE                      IN VARCHAR2,
      p_SUB_MODULE                  IN VARCHAR2,
      p_RAW_CODE                    IN VARCHAR2,
      p_ERROR_DETAILS_SOURCE        IN VARCHAR2,
      p_RESULT_STATUS               OUT VARCHAR2,
      p_RESULT_DESCRIPTION          OUT VARCHAR2,
      p_CANONICAL_ERROR_CODE        OUT VARCHAR2,
      p_CANONICAL_ERROR_TYPE        OUT VARCHAR2,
      p_CANONICAL_ERROR_DESCRIPTION OUT VARCHAR2,
      p_SOURCE_ERROR_CODE           OUT NUMBER,
      p_SOURCE_ERROR_DESCRIPTION    OUT VARCHAR2,
      p_ERROR_DETAILS               OUT VARCHAR2,
      p_ERROR_SOURCE                OUT VARCHAR2);
      
/* ================== COMPLETE PROCEDURE ================== 

It gets the canonical error for a given error source with four parameters (Sys_Code, Raw_Code, Module, Sub_Module)

*/
  PROCEDURE Get_Can_Err_Complete(
      p_MODULE                      IN VARCHAR2,
      p_SUB_MODULE                  IN VARCHAR2,
      p_RAW_CODE                    IN VARCHAR2,
      p_ERROR_DETAILS_SOURCE        IN VARCHAR2,
      p_RESULT_STATUS               OUT VARCHAR2,
      p_RESULT_DESCRIPTION          OUT VARCHAR2,
      p_CANONICAL_ERROR_CODE        OUT VARCHAR2,
      p_CANONICAL_ERROR_TYPE        OUT VARCHAR2,
      p_CANONICAL_ERROR_DESCRIPTION OUT VARCHAR2,
      p_SOURCE_ERROR_CODE           OUT NUMBER,
      p_SOURCE_ERROR_DESCRIPTION    OUT VARCHAR2,
      p_ERROR_DETAILS               OUT VARCHAR2,
      p_ERROR_SOURCE                OUT VARCHAR2);

/* ================== PROCEDURE ================== 

It gets the canonical error for a given error source with three parameters (Sys_Code, Module, Sub_Module)

*/
  PROCEDURE Get_Can_Err_For_Sys_API_Oper(
      p_MODULE                      IN VARCHAR2,
      p_SUB_MODULE                  IN VARCHAR2,
      p_ERROR_DETAILS_SOURCE        IN VARCHAR2,
      p_RESULT_STATUS               OUT VARCHAR2,
      p_RESULT_DESCRIPTION          OUT VARCHAR2,
      p_CANONICAL_ERROR_CODE        OUT VARCHAR2,
      p_CANONICAL_ERROR_TYPE        OUT VARCHAR2,
      p_CANONICAL_ERROR_DESCRIPTION OUT VARCHAR2,
      p_SOURCE_ERROR_CODE           OUT NUMBER,
      p_SOURCE_ERROR_DESCRIPTION    OUT VARCHAR2,
      p_ERROR_DETAILS               OUT VARCHAR2,
      p_ERROR_SOURCE                OUT VARCHAR2);
      
/* ================== PROCEDURE ================== 

It gets the canonical error for a given error source with two parameters (Sys_Code, Module)

*/
  PROCEDURE Get_Can_Err_For_Sys_API(
      p_MODULE                      IN VARCHAR2,
      p_ERROR_DETAILS_SOURCE        IN VARCHAR2,
      p_RESULT_STATUS               OUT VARCHAR2,
      p_RESULT_DESCRIPTION          OUT VARCHAR2,
      p_CANONICAL_ERROR_CODE        OUT VARCHAR2,
      p_CANONICAL_ERROR_TYPE        OUT VARCHAR2,
      p_CANONICAL_ERROR_DESCRIPTION OUT VARCHAR2,
      p_SOURCE_ERROR_CODE           OUT NUMBER,
      p_SOURCE_ERROR_DESCRIPTION    OUT VARCHAR2,
      p_ERROR_DETAILS               OUT VARCHAR2,
      p_ERROR_SOURCE                OUT VARCHAR2);
      
/* ================== PROCEDURE ================== 

It gets the canonical error for a given error source with one parameter (Sys_Code)

*/
  PROCEDURE Get_Can_Err_For_System(
      p_ERROR_DETAILS_SOURCE        IN VARCHAR2,
      p_RESULT_STATUS               OUT VARCHAR2,
      p_RESULT_DESCRIPTION          OUT VARCHAR2,
      p_CANONICAL_ERROR_CODE        OUT VARCHAR2,
      p_CANONICAL_ERROR_TYPE        OUT VARCHAR2,
      p_CANONICAL_ERROR_DESCRIPTION OUT VARCHAR2,
      p_SOURCE_ERROR_CODE           OUT NUMBER,
      p_SOURCE_ERROR_DESCRIPTION    OUT VARCHAR2,
      p_ERROR_DETAILS               OUT VARCHAR2,
      p_ERROR_SOURCE                OUT VARCHAR2);
END ESB_ERROR_MANAGER_PKG;
/