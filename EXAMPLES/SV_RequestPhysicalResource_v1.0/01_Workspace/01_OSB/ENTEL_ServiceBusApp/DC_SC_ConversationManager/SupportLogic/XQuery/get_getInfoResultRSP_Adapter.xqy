xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/Result/v2";
(:: import schema at "../../../SR_Commons/XSD/ESO/Result_v2_ESO.xsd" ::)
declare namespace ns2="http://www.entel.cl/SC/ConversationManager/getInfo/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/getInfo_ConversationManager_v1_CSM.xsd" ::)

declare variable $Result as element() (:: schema-element(ns1:Result) ::) external;

declare function local:get_getInfoResultRSP_Adapter($Result as element() (:: schema-element(ns1:Result) ::)) as element() (:: schema-element(ns2:GetInfoRSP) ::) {
    <ns2:GetInfoRSP>
      {$Result}
    </ns2:GetInfoRSP>
    
};

local:get_getInfoResultRSP_Adapter($Result)
