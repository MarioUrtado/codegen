xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/ESO/MessageHeader/v1";
(:: import schema at "../../../SR_Commons/XSD/ESO/MessageHeader_v1_ESO.xsd" ::)
declare namespace ns2="http://www.entel.cl/SC/ConversationManager/getInfo/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/getInfo_ConversationManager_v1_CSM.xsd" ::)

declare variable $Header as element() external;

declare function local:get_GetInfoREQ($Header as element()) as element() (:: schema-element(ns2:GetInfoREQ) ::) {
    <ns2:GetInfoREQ>
      {$Header}
    </ns2:GetInfoREQ>
};

local:get_GetInfoREQ($Header)
