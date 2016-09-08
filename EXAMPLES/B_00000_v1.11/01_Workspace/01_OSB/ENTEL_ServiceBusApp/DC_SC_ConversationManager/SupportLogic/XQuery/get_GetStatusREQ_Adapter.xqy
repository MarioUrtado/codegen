xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/ConversationManager/getStatus/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/getStatus_ConversationManager_v1_CSM.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/getConversationStatusAdapter";
(:: import schema at "../JCA/getConversationStatusAdapter/getConversationStatusAdapter_sp.xsd" ::)

declare variable $getStatusREQ as element() (:: schema-element(ns1:GetStatusREQ) ::) external;

declare function local:get_GetStatusREQ_Adapter($Input_Parameters as element() (:: schema-element(ns1:GetStatusREQ) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:P_CONVERSATION_ID>{fn:data($Input_Parameters/ns1:ConversationID)}</ns2:P_CONVERSATION_ID>
    </ns2:InputParameters>
};

local:get_GetStatusREQ_Adapter($getStatusREQ)
