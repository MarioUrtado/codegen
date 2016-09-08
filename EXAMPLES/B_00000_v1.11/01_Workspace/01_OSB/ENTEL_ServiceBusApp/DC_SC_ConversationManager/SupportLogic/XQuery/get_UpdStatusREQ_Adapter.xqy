xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.entel.cl/SC/ConversationManager/updStatus/v1";
(:: import schema at "../../SupportAPI/XSD/CSM/updStatus_ConversationManager_v1_CSM.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/updateConversationManagerAdapter";
(:: import schema at "../JCA/updateConversationStatusAdapter/updateConversationStatusAdapter_sp.xsd" ::)

declare namespace con = "http://www.entel.cl/SC/ConversationManager/Aux/ConversationStatus";

declare namespace ns4 = "http://www.entel.cl/ESO/Error/v1";

declare namespace ns3 = "http://www.entel.cl/ESO/Result/v2";

declare variable $updateStatusREQ as element() (:: schema-element(ns1:UpdStatusREQ) ::) external;

declare function local:get_UpdStatusREQ_Adapter($updateStatusREQ as element() (:: schema-element(ns1:UpdStatusREQ) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:P_CONVERSATION_ID>{fn:data($updateStatusREQ/ns1:ConversationID)}</ns2:P_CONVERSATION_ID>
        <ns2:P_STATUS>{fn:data($updateStatusREQ/ns1:ConversationStatus/@status)}</ns2:P_STATUS>
        {
            if ($updateStatusREQ/ns1:ConversationStatus/con:ReponseMessage)
            then <ns2:P_RSP_MSG>{$updateStatusREQ/ns1:ConversationStatus/con:ReponseMessage/*}</ns2:P_RSP_MSG>
            else ()
        }
        {
            if ($updateStatusREQ/ns1:ConversationStatus/ns3:Result/ns4:CanonicalError/@code)
            then <ns2:P_CAN_ERROR_CODE>{fn:data($updateStatusREQ/ns1:ConversationStatus/ns3:Result/ns4:CanonicalError/@code)}</ns2:P_CAN_ERROR_CODE>
            else ()
        }
        {
            if ($updateStatusREQ/ns1:ConversationStatus/ns3:Result/ns4:CanonicalError/@type)
            then <ns2:P_CAN_ERROR_TYPE>{fn:data($updateStatusREQ/ns1:ConversationStatus/ns3:Result/ns4:CanonicalError/@type)}</ns2:P_CAN_ERROR_TYPE>
            else ()
        }
        <ns2:P_UPDATE_COMPONENT>{fn:data($updateStatusREQ/ns1:SourceComponent/@component)}</ns2:P_UPDATE_COMPONENT>
        {
            if ($updateStatusREQ/ns1:SourceComponent/@operation)
            then <ns2:P_UPDATE_OPERATION>{fn:data($updateStatusREQ/ns1:SourceComponent/@operation)}</ns2:P_UPDATE_OPERATION>
            else ()
        }
    </ns2:InputParameters>
};

local:get_UpdStatusREQ_Adapter($updateStatusREQ)
