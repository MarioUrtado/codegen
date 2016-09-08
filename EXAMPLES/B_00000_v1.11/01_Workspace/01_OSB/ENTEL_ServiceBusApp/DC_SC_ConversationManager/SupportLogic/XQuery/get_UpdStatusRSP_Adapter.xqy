xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/ConversationManager/updStatus/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/updStatus_ConversationManager_v1_CSM.xsd" ::)

declare namespace ns2 = "http://www.entel.cl/ESO/Result/v2";

declare namespace ns3 = "http://www.entel.cl/ESO/Error/v1";

declare variable $status as xs:string external;
declare variable $description as xs:string external;

declare function local:get_UpdStatusRSP_Adapter($status as xs:string,$description as xs:string ) as element() (:: schema-element(ns1:UpdStatusRSP) ::) {
    <ns1:UpdStatusRSP>
        <ns2:Result status="{fn:data($status)}" description="{fn:data($description)}">
        </ns2:Result>
    </ns1:UpdStatusRSP>
};

local:get_UpdStatusRSP_Adapter($status, $description)
