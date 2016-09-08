xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.entel.cl/SC/MessageManager/RefreshCache_GetCapabilityChecks/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/refreshCache_getCapabilityChecks_MessageManager_v1_CSM.xsd" ::)

declare namespace ns3 = "http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)

declare variable $Result as element() (:: schema-element(ns3:Result) ::) external;

declare function local:refreshCache_GetCapabilityChecksRSP($Result as element() (:: schema-element(ns3:Result) ::)) as element() (:: schema-element(ns2:RefreshCache_GetCapabilityChecksRSP) ::) {
    <ns2:RefreshCache_GetCapabilityChecksRSP>
       {$Result}
    </ns2:RefreshCache_GetCapabilityChecksRSP>
};

local:refreshCache_GetCapabilityChecksRSP($Result)