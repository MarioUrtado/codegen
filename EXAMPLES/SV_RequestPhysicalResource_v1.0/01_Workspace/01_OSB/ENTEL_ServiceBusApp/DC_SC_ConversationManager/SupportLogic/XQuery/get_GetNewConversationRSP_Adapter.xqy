xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/ConversationManager/getNewConversation/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/getNewConversation_ConversationManager_v1_CSM.xsd" ::)

declare namespace ns2 = "http://www.entel.cl/ESO/Result/v2";

declare namespace ns3 = "http://www.entel.cl/ESO/Error/v1";

declare variable $status as xs:string external;
declare variable $description as xs:string external;
declare variable $conv_ID as xs:string external;

declare function local:get_GetNewConversationRSP_Adapter($status as xs:string , $description as xs:string, $conv_ID as xs:string) as element() (:: schema-element(ns1:GetNewConversationRSP) ::) {
    <ns1:GetNewConversationRSP>
        <ns2:Result status="{$status}" description="{$description}">
        </ns2:Result>
        <ns1:ConversationID>{fn:data($conv_ID)}</ns1:ConversationID>
    </ns1:GetNewConversationRSP>
};

local:get_GetNewConversationRSP_Adapter($status, $description, $conv_ID)
