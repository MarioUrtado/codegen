xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/CacheManager/lazyRefresh/v1";
(:: import schema at "../../../DC_SC_CacheManager/SupportAPI/XSD/CSM/lazyRefresh_CacheManager_v1_CSM.xsd" ::)
declare namespace ns2="http://www.entel.cl/SC/ParameterManager/RefreshCache_GetConfig/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/refreshCache_getConfig_ParameterManager_v1_CSM.xsd" ::)

declare namespace ns4 = "http://www.entel.cl/ESO/Result/v2";

declare namespace ns3 = "http://www.entel.cl/ESO/Error/v1";

declare variable $refreshCacheRSP as element() (:: schema-element(ns1:LazyRefreshRSP) ::) external;

declare function local:refreshCacheRSP($refreshCacheRSP as element() (:: schema-element(ns1:LazyRefreshRSP) ::)) as element() (:: schema-element(ns2:RefreshCache_GetConfigRSP) ::) {
    <ns2:RefreshCache_GetConfigRSP>
       {$refreshCacheRSP/ns4:Result}
    </ns2:RefreshCache_GetConfigRSP>
};

local:refreshCacheRSP($refreshCacheRSP)
