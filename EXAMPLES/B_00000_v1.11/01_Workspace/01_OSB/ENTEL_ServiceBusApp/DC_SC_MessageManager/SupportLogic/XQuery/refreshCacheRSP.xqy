xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/MessageManager/RefreshCache/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/refreshCache_MessageManager_v1_CSM.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)

declare variable $Result as element() (:: schema-element(ns3:Result) ::) external;

declare function local:refreshCacheRSP($Result as element() (:: schema-element(ns3:Result) ::)) as element() (:: schema-element(ns1:RefreshCacheRSP) ::) {
    <ns1:RefreshCacheRSP>
       {$Result}
    </ns1:RefreshCacheRSP>
};

local:refreshCacheRSP($Result)
