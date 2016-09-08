xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/ConversationManager/getNewConversation/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/getNewConversation_ConversationManager_v1_CSM.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/putConversationStatusAdapter";
(:: import schema at "../JCA/putConversationStatusAdapter/putConversationStatusAdapter_sp.xsd" ::)

declare variable $NewConv_ID as xs:string external;

declare function local:get_GetNewConversationREQ_Adapter($NewConv_ID as xs:string) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:P_CONVERSATION_ID>{$NewConv_ID}</ns2:P_CONVERSATION_ID>
    </ns2:InputParameters>
};

local:get_GetNewConversationREQ_Adapter($NewConv_ID)
