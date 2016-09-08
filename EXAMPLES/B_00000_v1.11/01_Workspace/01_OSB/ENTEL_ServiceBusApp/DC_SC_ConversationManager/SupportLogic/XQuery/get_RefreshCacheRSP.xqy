xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/CacheManager/lazyRefresh/v1";
(:: import schema at "../../../DC_SC_CacheManager/SupportAPI/XSD/CSM/lazyRefresh_CacheManager_v1_CSM.xsd" ::)

declare namespace ns2="http://www.entel.cl/SC/ConversationManager/RefreshCache_PublishResult/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/refreshCache_publishResult_ConversationManager_v1_CSM.xsd" ::)

declare namespace ns4 = "http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/ESO/Error/v1";

declare variable $Result as element() (:: schema-element(ns4:Result) ::) external;

declare function local:get_RefreshCacheRSP($Result as element() (:: schema-element(ns4:Result) ::)) as element() (:: schema-element(ns2:RefreshCache_PublishResultRSP) ::) {
    <ns2:RefreshCacheRSP>
        {$Result}
    </ns2:RefreshCacheRSP>
};

local:get_RefreshCacheRSP($Result)
