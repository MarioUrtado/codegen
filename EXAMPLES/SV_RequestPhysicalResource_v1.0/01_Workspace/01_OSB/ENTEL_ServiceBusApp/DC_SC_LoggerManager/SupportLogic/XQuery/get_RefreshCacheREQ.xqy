xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/LoggerManager/refreshCache_LoggerManager/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/refreshCache_LoggerManager_v1_CSM.xsd" ::)
declare namespace ns2="http://www.entel.cl/SC/ParameterManager/RefreshCache_Get/v1";
(:: import schema at "../../../DC_SC_ParameterManager/SupportAPI/XSD/CSM/refreshCache_get_ParameterManager_v1_CSM.xsd" ::)

declare variable $RefreshCache_LoggerManagerREQ as element() (:: schema-element(ns1:RefreshCache_LoggerManagerREQ) ::) external;

declare function local:get_RefreshCacheREQ($RefreshCache_LoggerManagerREQ as element() (:: schema-element(ns1:RefreshCache_LoggerManagerREQ) ::)) as element() (:: schema-element(ns2:RefreshCache_GetREQ) ::) {
    <ns2:RefreshCache_GetREQ></ns2:RefreshCache_GetREQ>
};

local:get_RefreshCacheREQ($RefreshCache_LoggerManagerREQ)
